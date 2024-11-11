import { ICard, ICardItem, IConfirm, INavBar, UserSettingClass } from 'basic';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct Setting {
  // 1. 实例化弹窗对象
  controller: CustomDialogController = new CustomDialogController({
    builder: IConfirm({
      // message: "确定要删除这张照片吗?",
      buttonList: [
        {
          text: "取消",
          fontColor: $r("app.color.primary"),
          fontSize: 18,
        },
        {
          text: "确定",
          fontColor: $r("app.color.primary"),
          action: () => {
            // 调用退出登录方法
            this.logout()
          },
          fontSize: 18
        }
      ]
    }),
    // 取消默认的弹窗样式
    customStyle: true
  })

  // 退出登录
  logout() {
    // 删除token
    const setting = new UserSettingClass(getContext())
    setting.deleteUserToken()

    // 跳转到登录页
    router.replaceUrl({
      url: "pages/Login/Login"
    })
  }

  build() {
    Column() {
      // 系统设置标题栏
      INavBar({
        title: "系统设置"
      })
        .margin({
          bottom: 20
        })


      // 选项列表
      ICard() {
        ICardItem({
          leftText: "换绑手机"
        })
        ICardItem({
          leftText: "修改密码"
        })
        ICardItem({
          leftText: "消息通知设置"
        })
        ICardItem({
          leftText: "清理缓存"
        })
      }

      // 退出按钮
      Row() {
        Button("退出", { type: ButtonType.Normal })
          .width("100%")
          .backgroundColor($r("app.color.white"))
          .fontColor($r("app.color.text_primary"))
          .height(60)
          .borderRadius(8)
          .onClick(() => {
            // 3. 打开弹窗
            this.controller.open()
          })
      }
      .width("100%")
      .padding({
        left: 15,
        right: 15
      })
      .margin({
        top: 20
      })
    }
    .height('100%')
    .width('100%')
    .backgroundColor($r("app.color.background_page"))
  }
}
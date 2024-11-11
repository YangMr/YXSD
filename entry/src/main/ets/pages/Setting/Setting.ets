import { ICard, ICardItem, INavBar } from 'basic';

@Entry
@Component
struct Setting {
  // 1. 实例化弹窗对象
  controller: CustomDialogController = new CustomDialogController({
    builder: this.IConfirm,
    // 取消默认的弹窗样式
    customStyle: true
  })

  // 2. 定义弹窗的内容
  @Builder
  IConfirm() {
    Row() {
      Column() {
        Row() {
          Text("确定要退出登录吗?")
            .fontSize(16)
            .fontColor($r("app.color.text_primary"))
            .fontWeight(600)
        }
        .width("100%")
        .height(88)
        .justifyContent(FlexAlign.Center)
        .border({
          width: {
            bottom: 1
          },
          color: $r("app.color.background_divider")
        })

        Row() {
          Text("取消")
            .fontSize(16)
            .textAlign(TextAlign.Center)
            .layoutWeight(1)
            .fontColor($r("app.color.text_secondary"))
            .height("100%")
            .border({
              width: {
                right: 1
              },
              color: $r("app.color.background_divider")
            })

          Text("确定")
            .fontSize(16)
            .textAlign(TextAlign.Center)
            .layoutWeight(1)
            .fontColor($r("app.color.text_secondary"))
            .height("100%")
        }
        .width("100%")
        .height(49)
      }
      .width("100%")
      .backgroundColor($r("app.color.white"))
      .borderRadius(12)
    }
    .width("100%")
    .padding({
      left: 25,
      right: 25
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
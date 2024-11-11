import { ICard, ICardItem, INavBar } from 'basic';

@Entry
@Component
struct Setting {
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
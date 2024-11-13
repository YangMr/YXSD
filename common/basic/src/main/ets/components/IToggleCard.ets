@Component
export struct IToggleCard {
  // true 表示展开 false 收起
  @State
  title: string = "基本信息"
  @State
  toggleCard: boolean = true
  @BuilderParam
  CardContent: () => void

  build() {
    Column() {
      Row() {
        Text(this.title)
          .fontSize(16)
          .fontColor($r("app.color.text_primary"))
          .fontWeight(600)

        Image(this.toggleCard ? $r("app.media.ic_btn_cut") : $r("app.media.ic_btn_add"))
          .width(24)
          .aspectRatio(1)
          .onClick(() => {
            animateTo({ duration: 300 }, () => {
              this.toggleCard = !this.toggleCard
            })
          })
      }
      .width("100%")
      .justifyContent(FlexAlign.SpaceBetween)

      if (this.toggleCard && this.CardContent) {
        this.CardContent()
      }

    }
    .backgroundColor($r("app.color.white"))
    .padding(18)
    .borderRadius(10)
    .margin({
      top: 10,
      left: 18,
      right: 18
    })
  }
}


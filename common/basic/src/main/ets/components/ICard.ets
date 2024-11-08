@Component
export struct ICard {
  @BuilderParam
  ICardFn: () => void

  build() {
    Column() {
      if (this.ICardFn) {
        this.ICardFn()
      }
    }
    .margin({
      left: 15,
      right: 15
    })
    .backgroundColor($r("app.color.white"))
    .borderRadius(8)
    .padding({
      left: 18,
      right: 18
    })
  }
}

export default ICard
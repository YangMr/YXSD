@Preview
@Component
struct ISkeleton {
  @State
  showAvatar: boolean = true
  @State
  count: number = 3
  @State
  currentColor: string = "#f60"
  @State
  timer: number = -1

  aboutToAppear(): void {
    this.splash()
  }

  splash() {
    this.timer = setInterval(() => {
      if (this.currentColor === "#f60") {
        this.currentColor = "#ccc"
      } else {
        this.currentColor = "#f60"
      }
    }, 100)
  }

  aboutToDisappear(): void {
    clearInterval(this.timer)
  }

  @Builder
  getSingleItem() {
    Row({ space: 10 }) {
      if (this.showAvatar) {
        Row()
          .width(40)
          .height(40)
          .backgroundColor(this.currentColor)
          .borderRadius(20)
      }


      Column({ space: 10 }) {
        Row()
          .width("30%")
          .height(26)
          .backgroundColor(this.currentColor)
        Row()
          .width("100%")
          .height(26)
          .backgroundColor(this.currentColor)
        Row()
          .width("100%")
          .height(26)
          .backgroundColor(this.currentColor)
        Row()
          .width("50%")
          .height(26)
          .backgroundColor(this.currentColor)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(VerticalAlign.Top)
  }

  build() {
    Column({ space: 30 }) {
      ForEach(Array.from(Array(this.count)), () => {
        this.getSingleItem()
      })

    }
    .width("100%")
    .height("100%")
    .padding(20)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor($r("app.color.white"))
  }
}

export default ISkeleton
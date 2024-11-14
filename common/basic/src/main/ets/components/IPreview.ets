@CustomDialog
@Component
export struct IPreview {
  @Prop
  urls: string[] = []
  controller: CustomDialogController
  @Prop
  selectIndex: number = 0

  build() {
    Column() {
      Swiper() {
        ForEach(this.urls, (item: string) => {
          Image(item)
            .width("100%")
            .onClick(() => {
              this.controller.close()
            })
        })
      }
      .index(this.selectIndex)
      .indicator(false)

    }
    .width("100%")
    .height("100%")
    .justifyContent(FlexAlign.Center)
  }
}


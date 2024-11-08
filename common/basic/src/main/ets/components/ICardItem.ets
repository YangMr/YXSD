@Component
export struct ICardItem {
  // 左侧的文字
  leftText: string = ""
  // 控制是否显示右侧的图标
  showRightIcon: boolean = true
  // 右侧图标
  rightIcon: ResourceStr = $r("app.media.ic_btn_more")
  // 右侧文本
  @Prop
  rightText: string = ""
  // 控制是否显示下边框
  showBottomBorder: boolean = true
  // 接受父组件传递的方法
  onRightClick: () => void = () => {
  }

  build() {
    Row() {
      Text(this.leftText)
        .fontSize(16)
        .fontWeight(400)
        .fontColor($r("app.color.text_primary"))


      Row() {
        if (this.rightText) {
          Text(this.rightText)
            .fontColor($r("app.color.text_secondary"))
            .fontSize(14)
            .fontWeight(400)
            .margin({
              right: 5
            })
        }


        if (this.showRightIcon) {
          Image(this.rightIcon)
            .width(24)
            .height(24)
        }
      }
      .onClick(() => {
        this.onRightClick()
      })

    }
    .width("100%")
    .height(60)
    .border({
      width: {
        bottom: this.showBottomBorder ? 1 : 0
      },
      color: $r("app.color.background_divider")
    })
    .justifyContent(FlexAlign.SpaceBetween)

  }
}


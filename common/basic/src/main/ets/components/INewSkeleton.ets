@Component
export struct INewSkeleton {
  customWidth: number | string = ""
  customHeight: number | string = ""
  circle: boolean = false
  // bgColor: string = "#f3f4f5"
  bgColor: string = "rgb(245, 245, 241)"
  bdRadius: number | string | BorderRadiuses = ""
  @State
  timer: number = -1

  aboutToAppear(): void {
    this.splash()
  }

  splash() {
    this.timer = setInterval(() => {
      if (this.bgColor === "rgb(245, 245, 241)") {
        this.bgColor = "#f7f8f9"
      } else {
        this.bgColor = "rgb(245, 245, 241)"
      }
    }, 100)
  }

  aboutToDisappear(): void {
    clearInterval(this.timer)
  }

  build() {
    Row() {

    }
    .width(this.customWidth)
    .height(this.circle ? this.customWidth : this.customHeight)
    .borderRadius(this.circle ? this.customWidth : this.bdRadius)
    .backgroundColor(this.bgColor)
  }
}


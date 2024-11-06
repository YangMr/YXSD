import { AdvertClass } from 'basic'

@Entry
@Component
struct Start {
  @State
  adObj: AdvertClass = {
    showAd: false,
    adTime: 5,
  }
  @State
  timer: number = -1

  // 页面开始加载的时候就会触发当前生命周期方法
  aboutToAppear(): void {
    // 调用倒计时方法
    this.countDown()
  }

  // 倒计时的方法
  countDown() {
    this.timer = setInterval(() => {
      if (this.adObj.adTime === 0) {
        clearInterval(this.timer)
        return
      }
      this.adObj.adTime--
    }, 1000)
  }

  // 当前页面销毁的时候,一定要清除定时器, 如果不清除(内存泄露)
  aboutToDisappear(): void {
    // 清除定时器
    clearInterval(this.timer)
  }

  build() {
    Stack({ alignContent: Alignment.TopEnd }) {
      Image($r("app.media.start"))
        .objectFit(ImageFit.Cover)

      Text(this.adObj.adTime + "秒后跳过")
        .padding({ left: 10, right: 10 })
        .height(30)
        .margin({ right: 20, top: 20 })
        .fontSize(14)
        .borderRadius(15)
        .textAlign(TextAlign.Center)
        .backgroundColor($r("app.color.background_page"))
    }
    .height('100%')
    .width('100%')
  }
}
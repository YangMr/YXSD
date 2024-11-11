import { INavBar } from 'basic';

@Entry
@Component
struct Setting {
  build() {
    Column() {
      INavBar({
        title: "系统设置"
      })
    }
    .height('100%')
    .width('100%')
    .backgroundColor($r("app.color.background_page"))
  }
}
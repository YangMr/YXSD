import { TabClass } from 'basic'

@Entry
@Component
struct Index {
  @State
  tabsData: TabClass[] = [
    {
      title: "任务",
      icon: $r("app.media.ic_tab_btn_mess_nor"),
      name: "task"
    },
    {
      title: "消息",
      icon: $r("app.media.ic_tab_btn_mess_nor"),
      name: "message"
    },
    {
      title: "我的",
      icon: $r("app.media.ic_tab_btn_mine_nor"),
      name: "my"
    }
  ]

  build() {
    RelativeContainer() {
      
    }
    .height('100%')
    .width('100%')
  }
}
import { TabClass } from 'basic'

@Entry
@Component
struct Index {
  // tabBar的数据
  @State
  tabsData: TabClass[] = [
    {
      title: "任务",
      icon: $r("app.media.ic_tab_btn_task"),
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
  // 初始化一个变量,保存选中的Tabbar
  @State
  currentIndex: number = 0

  // 自定义tabBar的布局
  @Builder
  getTabBar(item: TabClass) {
    Column() {
      Image(item.icon)
        .width(22)
        .height(22)
        .fillColor(item.name === this.tabsData[this.currentIndex].name ? $r("app.color.primary") :
        $r("app.color.text_secondary"))

      Text(item.title)
        .fontSize(12)
        .fontWeight(400)
        .margin({
          top: 5
        })
        .fontColor(item.name === this.tabsData[this.currentIndex].name ? $r("app.color.primary") :
        $r("app.color.text_secondary"))
    }
  }

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.End, index: $$this.currentIndex }) {
        ForEach(this.tabsData, (item: TabClass) => {
          TabContent() {
            Text(item.name)
          }.tabBar(this.getTabBar(item))
        })
      }
      .animationDuration(500)
    }
    .height('100%')
    .width('100%')
  }
}
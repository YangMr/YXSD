import { TabClass } from 'basic'
import { TaskTypeEnum } from '../../../models'
import TaskList from './TaskList'

@Component
export struct TaskTabs {
  @State
  tabsData: TabClass[] = [
    {
      title: "待提货",
      name: "waiting"
    },
    {
      title: "在途",
      name: "line"
    },
    {
      title: "已完成",
      name: "finish"
    }
  ]
  @State
  currentIndex: number = 0
  controller: TabsController = new TabsController()

  @Builder
  getTabBar(item: TabClass, index: number) {
    Column() {
      Text(item.title)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.currentIndex === index ? $r("app.color.text_primary") : $r("app.color.text_secondary"))
        .margin({
          bottom: 10
        })
        .animation({
          duration: 300
        })

      Divider()
        .color($r("app.color.primary"))
        .strokeWidth(4)
        .width(this.currentIndex === index ? 23 : 0)
        .lineCap(LineCapStyle.Round)
        .animation({
          duration: 300
        })
    }
    .onClick(() => {
      this.controller.changeIndex(index)
    })
  }

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Tabs({ controller: this.controller, index: $$this.currentIndex }) {
        ForEach(this.tabsData, (item: TabClass) => {
          TabContent() {
            // 待提货
            if (item.name === "waiting") {
              TaskList()
            } else if (item.name === "line") {
              TaskList({
                queryParams: {
                  page: 1,
                  pageSize: 5,
                  status: TaskTypeEnum.Line
                }
              })
            } else if (item.name === "finish") {

            }
          }.tabBar(item.title)
        })
      }

      Row({ space: 30 }) {
        ForEach(this.tabsData, (item: TabClass, index: number) => {
          this.getTabBar(item, index)
        })
      }
      .width("100%")
      .padding({
        left: 40,
        right: 40
      })
      .height(50)
      .backgroundColor($r("app.color.white"))
    }

  }
}


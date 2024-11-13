import { TaskListItemDataModel } from '../../../models'
import { router } from '@kit.ArkUI'

@Component
struct TaskItemCard {
  @Prop
  taskItem: TaskListItemDataModel = {} as TaskListItemDataModel

  toPickUp() {
    router.pushUrl({
      url: "pages/TaskDetail/TaskDetail",
      params: {
        id: this.taskItem.id
      }
    })
  }

  build() {
    Column() {
      // 任务编号
      Row() {
        Text("任务编号：" + this.taskItem.transportTaskId)
          .fontSize(16)
          .fontWeight(500)
          .lineHeight(22)
          .fontColor($r("app.color.text_primary"))

        // Text("已延迟")
      }
      .width("100%")
      .justifyContent(FlexAlign.SpaceBetween)

      // 起点与终点的地址
      Row() {
        Text("起")
          .width(22)
          .height(22)
          .backgroundColor($r("app.color.text_primary"))
          .fontColor($r("app.color.white"))
          .borderRadius(11)
          .textAlign(TextAlign.Center)
          .fontSize(12)

        Text(this.taskItem.startAddress)
          .fontSize(14)
          .margin({ left: 12 })
          .fontColor($r("app.color.text_secondary"))
      }
      .alignItems(VerticalAlign.Center)
      .width("100%")
      .margin({
        top: 20
      })

      Row() {
        Text("止")
          .width(22)
          .height(22)
          .backgroundColor($r("app.color.primary"))
          .fontColor($r("app.color.white"))
          .borderRadius(11)
          .textAlign(TextAlign.Center)
          .fontSize(12)

        Text(this.taskItem.endAddress)
          .fontSize(14)
          .margin({ left: 12 })
          .fontColor($r("app.color.text_secondary"))
      }
      .alignItems(VerticalAlign.Center)
      .width("100%")
      .margin({
        top: 20
      })

      Divider()
        .strokeWidth(1)
        .color($r("app.color.background_divider"))
        .margin({
          top: 20,
          bottom: 20
        })


      // 提货
      Row() {
        Column({ space: 5 }) {
          Text("提货时间")
            .fontSize(14)
            .fontColor($r("app.color.text_secondary"))
          Text(this.taskItem.planDepartureTime)
            .fontColor($r("app.color.text_primary"))
            .fontSize(14)
        }
        .alignItems(HorizontalAlign.Start)

        Button("提货", { type: ButtonType.Capsule })
          .backgroundColor(this.taskItem.enablePickUp ? $r("app.color.primary") : $r("app.color.primary_disabled"))
          .fontColor($r("app.color.white"))
          .fontSize(14)
          .height(32)
          .enabled(this.taskItem.enablePickUp)
          .onClick(() => {
            AlertDialog.show({
              message: "aaa"
            })
          })

      }
      .width("100%")
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width("100%")
    .backgroundColor($r("app.color.white"))
    .borderRadius(10)
    .padding(20)
    .onClick(() => {
      this.toPickUp()
    })
  }
}

export default TaskItemCard
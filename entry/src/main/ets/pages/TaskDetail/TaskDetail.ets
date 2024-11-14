import { router } from '@kit.ArkUI'
import { BaseBuilderClass, INavBar, IToggleCard, IUpload, RouterParamsModel } from 'basic'
import { getTaskDetailInfoApi } from '../../api'
import { TaskDetailInfoModel } from '../../models/task_detail'
import { TaskDetailSkeleton } from './Skeleton/TaskDetail-Skeleton'


@Entry
@Component
struct TaskDetail {
  @State
  params: RouterParamsModel = {} as RouterParamsModel
  @State
  taskDetailInfo: TaskDetailInfoModel = {} as TaskDetailInfoModel
  @State
  skeletonStatus: boolean = false

  aboutToAppear(): void {
    this.getParamsData()
    this.getTaskDetailInfo()
  }

  // 获取任务页面传递过来的司机的id
  getParamsData() {
    this.params = router.getParams() as RouterParamsModel
  }

  // 获取任务详情的数据
  async getTaskDetailInfo() {
    try {
      this.skeletonStatus = true
      this.taskDetailInfo = await getTaskDetailInfoApi(this.params.id)
      this.skeletonStatus = false
    } catch (e) {
      console.log("Error", e)
    }
  }

  // 基本信息
  @Builder
  getBaseContent() {
    Column() {
      Row() {
        Text("起")
          .baseTextIconStyle()
          .backgroundColor($r("app.color.text_primary"))


        Text(this.taskDetailInfo.startAddress)
          .baseTextStyle()

      }.margin({ top: 21 })
      .justifyContent(FlexAlign.Start)

      Row() {
        Text("止")
          .baseTextIconStyle()
          .backgroundColor($r("app.color.primary"))

        Text(this.taskDetailInfo.endAddress)
          .baseTextStyle()
      }.margin({ top: 15 })
      .justifyContent(FlexAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .margin({
      right: 20
    })
    .width("100%")
    .margin({ left: 10 })

    Divider()
      .strokeWidth(1)
      .color($r("app.color.background_divider"))
      .width("100%")
      .margin({
        top: 20,
        // bottom: 20
      })

    this.getBaseContentItem({
      title: "任务编号",
      value: this.taskDetailInfo.transportTaskId
    })

    this.getBaseContentItem({
      title: "联系人",
      value: this.taskDetailInfo.startHandoverName
    })

    this.getBaseContentItem({
      title: "联系电话",
      value: this.taskDetailInfo.startHandoverPhone,
      icon: $r("app.media.ic_phone")
    })

    this.getBaseContentItem({
      title: "提货时间",
      value: this.taskDetailInfo.planDepartureTime
    })

    this.getBaseContentItem({
      title: "预计送达时间",
      value: this.taskDetailInfo.planArrivalTime
    })

  }

  @Builder
  getBaseContentItem(item: BaseBuilderClass) {
    Row() {
      Text(item.title)
        .fontSize(14)
        .fontColor($r("app.color.text_secondary"))
        .lineHeight(20)
      Row() {
        Text(item.value)
          .fontSize(14)
          .fontColor($r("app.color.text_primary"))
          .lineHeight(20)

        if (item.icon) {
          Image(item.icon)
            .width(24)
            .height(24)
        }
      }
    }
    .width("100%")
    .justifyContent(FlexAlign.SpaceBetween)
    .margin({ top: 14 })
  }

  // 车辆司机信息
  @Builder
  getDriverContent() {
    this.getBaseContentItem({
      title: "车牌号",
      value: this.taskDetailInfo.licensePlate
    })

    this.getBaseContentItem({
      title: "司机姓名",
      value: this.taskDetailInfo.driverName
    })
  }

  // 运输路线
  @Builder
  getTransLineContent() {
    Row() {
      Column() {
        Text(this.taskDetailInfo.startProvince)
          .fontSize(16)
          .lineHeight(22)
          .fontColor($r("app.color.text_primary"))
          .fontWeight(600)

        Text(this.taskDetailInfo.startCity)
          .fontSize(14)
          .lineHeight(22)
          .fontColor($r("app.color.text_primary"))
      }
      .width(50)

      Image($r("app.media.ic_right_arrow"))
        .width(36)
        .height(16)

      Column() {
        Text(this.taskDetailInfo.endProvince)
          .fontSize(16)
          .lineHeight(22)
          .fontColor($r("app.color.text_primary"))
          .fontWeight(600)

        Text(this.taskDetailInfo.endCity)
          .fontSize(14)
          .lineHeight(22)
          .fontColor($r("app.color.text_primary"))
      }
      .width(50)
    }
    .width("100%")
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({
      left: 60,
      right: 60
    })
    .margin({
      top: 20
    })
  }

  @Builder
  getBottomBtn() {
    Row() {
      Button("延迟收货", { type: ButtonType.Capsule })
        .width(125)
        .height(50)
        .fontSize(16)
        .backgroundColor($r("app.color.btn_gray"))
        .fontColor($r("app.color.text_primary"))

      Button("提货")
        .layoutWeight(1)
        .height(50)
        .fontSize(16)
        .backgroundColor($r("app.color.primary_disabled"))
        .fontColor($r("app.color.white"))
        .margin({ left: 13 })
    }
    .width("100%")
    .padding({ left: 15, right: 15 })
    .backgroundColor($r("app.color.white"))
    .height(70)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  build() {
    if (this.skeletonStatus) {
      TaskDetailSkeleton()
    } else {
      Column() {
        INavBar({ title: "任务详情", rightText: "取消任务" })

        Scroll() {
          Column() {
            IToggleCard({ title: "基本信息" }) {
              this.getBaseContent()
            }

            IToggleCard({ title: "车辆司机信息", toggleCard: false }) {
              this.getDriverContent()
            }

            IToggleCard({ title: "运输路线", toggleCard: false }) {
              this.getTransLineContent()
            }
            

            IToggleCard({ title: "物品信息", toggleCard: false })
            IToggleCard({ title: "提货信息", toggleCard: false }) {
              IUpload({
                title: "请拍照上传回单凭证",
                imageList: this.taskDetailInfo.cargoPickUpPictureList || []
              })
              IUpload({
                title: "请拍照上传货品照片",
                imageList: this.taskDetailInfo.cargoPictureList || []
              })
            }
          }
          .padding({
            bottom: 20
          })
        }
        // .height("100%")
        .layoutWeight(1)
        .backgroundColor($r("app.color.background_page"))

        this.getBottomBtn()

      }
      .height('100%')
      .width('100%')
      .backgroundColor($r("app.color.background_page"))
    }

  }
}


@Extend(Text)
function baseTextIconStyle() {
  .width(22)
  .height(22)
  .fontColor($r("app.color.white"))
  .borderRadius(11)
  .textAlign(TextAlign.Center)
  .fontSize(12)
}

@Extend(Text)
function baseTextStyle() {
  .fontSize(14)
  .lineHeight(20)
  .fontColor($r("app.color.text_secondary"))
  .margin({
    left: 12
  })
}



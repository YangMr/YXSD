import { router } from '@kit.ArkUI'
import { INavBar, IToggleCard, RouterParamsModel } from 'basic'
import { getTaskDetailInfoApi } from '../../api'
import { TaskDetailInfoModel } from '../../models/task_detail'


@Entry
@Component
struct TaskDetail {
  @State
  params: RouterParamsModel = {} as RouterParamsModel
  @State
  taskDetailInfo: TaskDetailInfoModel = {} as TaskDetailInfoModel

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
      this.taskDetailInfo = await getTaskDetailInfoApi(this.params.id)
    } catch (e) {
      console.log("Error", e)
    }
  }

  @Builder
  getBaseContentItem(item: BaseBuilderClass) {
    Row() {
      Text(item.title).fontSize(14).fontColor($r('app.color.text_secondary'))
        .lineHeight(20)
      Row() {
        Text(item.value).fontSize(14).fontColor($r('app.color.text_secondary'))
        if (item.icon) {
          Image(item.icon).width(24).height(24)
        }
      }
    }.justifyContent(FlexAlign.SpaceBetween).width('100%').margin({
      top: 14
    })
  }

  // 基本信息
  @Builder
  getBaseContent() {
    Row() {
      Column() {
        Row() {
          Text("起").baseTextIconStyle()
          Text("北京市昌平区回龙观街道西三旗桥东金燕龙写字楼8877号").baseTextStyle()
        }.margin({ top: 21 })

        Row() {
          Text("止").baseTextIconStyle().backgroundColor($r('app.color.primary'))
          Text("河南省郑州市路北区北清路99号").baseTextStyle()
        }.margin({ top: 14.5 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ right: 20 })

      Column() {
        Image($r("app.media.ic_navigation")).width(22).height(22)
        Text("开始导航").fontSize(14).margin({ top: 10, bottom: 10 })
      }.justifyContent(FlexAlign.SpaceBetween)
      .margin({
        top: 20
      })

    }.justifyContent(FlexAlign.SpaceBetween).alignItems(VerticalAlign.Center).width('100%')

    Divider()
      .vertical(false)
      .height(2)
      .color($r('app.color.background_divider'))
      .margin({ left: 8, right: 8, top: 21 })

    this.getBaseContentItem({
      title: '任务编号',
      value: '2132324324343434'
    })
    this.getBaseContentItem({
      title: '联系人',
      value: '2132324324343434'
    })
    this.getBaseContentItem({
      title: '联系电话',
      value: '2132324324343434',
      icon: $r('app.media.ic_phone')
    })
    this.getBaseContentItem({
      title: '提货时间',
      value: '2132324324343434'
    })
    this.getBaseContentItem({
      title: '预计送达时间',
      value: '2132324324343434'
    })
  }

  // 车辆司机信息
  // 司机信息
  @Builder
  getDriverContent() {

    this.getBaseContentItem({
      title: '车牌号',
      value: "京A123456"
    })

    this.getBaseContentItem({
      title: '司机姓名',
      value: "张三"
    })

  }

  // 运输路线
  @Builder
  getTransLineContent() {
    Row() {
      Column() {
        Text("北京市").fontSize(16).fontColor($r('app.color.text_primary')).lineHeight(22).fontWeight(600)
        Text("北京市").fontSize(14).lineHeight(22)
      }.width(50)

      Image($r("app.media.ic_right_arrow")).width(36).height(16)
      Column() {
        Text("河南省").fontSize(16).fontColor($r('app.color.text_primary')).lineHeight(22).fontWeight(600)
        Text("郑州市").fontSize(14).lineHeight(22)
      }.width(50)
    }.justifyContent(FlexAlign.SpaceBetween).alignItems(VerticalAlign.Center).width('100%').padding({
      left: 60,
      right: 60,
      top: 20,
      bottom: 20
    })
  }

  build() {
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
          IToggleCard({ title: "提货信息", toggleCard: false })
        }
        .padding({
          bottom: 50
        })
        .height("100%")
      }
      .height("100%")
      .backgroundColor($r("app.color.background_page"))

    }
    .height('100%')
    .width('100%')
    .backgroundColor($r("app.color.background_page"))
  }
}

@Extend(Text)
function baseTextIconStyle() {
  .fontSize(12)
  .fontColor($r('app.color.white'))
  .backgroundColor($r('app.color.text_primary'))
  .width(22)
  .height(22)
  .borderRadius(11)
  .textAlign(TextAlign.Center)
}

@Extend(Text)
function baseTextStyle() {
  .margin({ left: 11.5 })
  .fontColor($r('app.color.text_secondary'))
  .fontSize(14)
  .lineHeight(20)
}

interface BaseBuilderClass {
  title: string
  value: string
  icon?: ResourceStr
}
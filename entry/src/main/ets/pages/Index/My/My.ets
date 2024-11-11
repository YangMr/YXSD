import { ICard, ICardItem, ISkeleton } from 'basic'
import { getUserInfoApi, getUserTaskInfoApi } from '../../../api'
import { UserInfoModel, UserTaskInfoModel, UserTaskInfoParamsModel } from '../../../models'
import { router } from '@kit.ArkUI'

@Component
struct My {
  // 3. 在我的页面创建一个变量,保存获取到用户信息
  @State
  userInfo: UserInfoModel = {
    avatar: $r("app.media.ic_avatar_driver"),
    name: "",
    number: "",
    phone: ""
  } as UserInfoModel
  @Consume
  @Watch("initUserInfo")
  currentName: string
  // 定义获取任务数据接口的参数
  @State
  queryTaskParams: UserTaskInfoParamsModel = {
    month: (new Date().getMonth() + 1).toString(),
    year: new Date().getFullYear().toString()
  }
  // 初始化一个变量,用来保存请求到的任务数据
  @State
  userTaskInfo: UserTaskInfoModel = {} as UserTaskInfoModel
  @State
  loading: boolean = false

  // 当进入到我的页面的时候,就会触发当前的方法
  async initUserInfo() {
    this.loading = true
    await this.getUserInfo()
    await this.getUserTaskInfo()
    this.loading = false
  }

  // 获取用户信息方法
  async getUserInfo() {
    try {
      if (this.currentName === "my") {
        this.userInfo = await getUserInfoApi()
      }

    } catch (e) {
      console.log("error", e)
    }
  }

  // 获取任务数据方法
  async getUserTaskInfo() {
    try {
      this.userTaskInfo = await getUserTaskInfoApi(this.queryTaskParams)
    } catch (e) {
      console.log("error", e)
    }
  }

  build() {
    Column() {
      if (this.loading && !this.userInfo.name && !this.userTaskInfo.taskAmounts) {
        ISkeleton()
      } else {
        Column() {

          // 用户信息模块
          Column() {
            Image(this.userInfo?.avatar)
              .width(67)
              .height(67)
              .borderRadius(33.5)

            Text(this.userInfo?.name)
              .fontSize(18)
              .fontWeight(600)
              .lineHeight(25)
              .margin({
                top: 9,
                bottom: 9
              })
              .fontColor($r("app.color.white"))

            Text("司机编号: " + this.userInfo.number)
              .fontSize(14)
              .fontWeight(400)
              .lineHeight(20)
              .fontColor($r("app.color.white"))

            Text("手机号: " + this.userInfo.phone)
              .fontSize(14)
              .fontWeight(400)
              .lineHeight(20)
              .margin({
                top: 10
              })
              .fontColor($r("app.color.white"))
          }
          .backgroundImage($r("app.media.bg_page_my"))
          .height(292)
          .width("100%")
          .backgroundImageSize(ImageSize.Cover)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)


          // 本月任务
          Column() {
            Text("- 本月任务 -")
              .fontSize(14)
              .fontColor($r("app.color.text_secondary"))
              .lineHeight(20)

            Row() {
              Column() {
                Text(this.userTaskInfo.taskAmounts?.toString() || '')
                  .fontSize(18)
                  .fontColor($r("app.color.text_primary"))
                  .lineHeight(25)
                  .margin({
                    bottom: 17
                  })

                Text("任务总量")
                  .fontSize(12)
                  .fontColor($r("app.color.text_primary"))
                  .lineHeight(17)
              }

              Column() {
                Text(this.userTaskInfo.completedAmounts?.toString() || "")
                  .fontSize(18)
                  .fontColor($r("app.color.text_primary"))
                  .lineHeight(25)
                  .margin({
                    bottom: 17
                  })

                Text("完成任务量")
                  .fontSize(12)
                  .fontColor($r("app.color.text_primary"))
                  .lineHeight(17)
              }

              Column() {
                Text(this.userTaskInfo.transportMileage?.toString() || "")
                  .fontSize(18)
                  .fontColor($r("app.color.text_primary"))
                  .lineHeight(25)
                  .margin({
                    bottom: 17
                  })

                Text("运输里程(km)")
                  .fontSize(12)
                  .fontColor($r("app.color.text_primary"))
                  .lineHeight(17)
              }
            }
            .justifyContent(FlexAlign.SpaceAround)
            .width("100%")
            .layoutWeight(1)
          }
          .backgroundColor($r("app.color.white"))
          .borderRadius(8)
          .margin({
            left: 15,
            right: 15,
            top: -45,
            bottom: 15
          })
          .justifyContent(FlexAlign.SpaceBetween)
          .padding({
            top: 14,
            bottom: 14
          })
          .height(134)

          // 选项列表
          ICard() {
            // 尾随闭包的写法
            ICardItem({
              leftText: "车辆信息",
              // rightText: "123"
              onRightClick() {
                AlertDialog.show({
                  message: "123"
                })
              }
            })
            ICardItem({
              leftText: "任务数据"
            })
            ICardItem({
              leftText: "系统设置",
              onRightClick: () => {
                router.pushUrl({
                  url: "pages/Setting/Setting"
                })
              }
            })
          }

        }
        .width("100%")
        .height("100%")
        .backgroundColor($r("app.color.background_page"))
      }
    }
    .width("100%")
    .height("100%")
  }
}

export default My
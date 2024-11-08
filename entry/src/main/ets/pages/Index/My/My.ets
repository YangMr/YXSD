import { ICard, ICardItem } from 'basic'
import { getUserInfoApi } from '../../../api'
import { UserInfoModel } from '../../../models'

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
  @Watch("getUserInfo")
  currentName: string

  // 页面第一次加载的时候,才会执行当前的方法
  // aboutToAppear(): void {
  //   // 4. 调用获取用户信息接口
  //   this.getUserInfo()
  // }

  // 获取用户信息方法
  async getUserInfo() {
    try {
      if (this.currentName === "my") {
        this.userInfo = await getUserInfoApi()
        AlertDialog.show({
          message: "aaa"
        })
      }

    } catch (e) {
      console.log("error", e)
    }
  }

  build() {
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
            Text("18")
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
            Text("16")
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
            Text("1000")
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
          leftText: "系统设置"
        })
      }

      // Column() {
      //   Row() {
      //     Text("车辆信息")
      //       .fontSize(16)
      //       .fontWeight(400)
      //       .fontColor($r("app.color.text_primary"))
      //
      //     Image($r("app.media.ic_btn_more"))
      //       .width(24)
      //       .height(24)
      //   }
      //   .width("100%")
      //   .height(60)
      //   .border({
      //     width: {
      //       bottom: 1
      //     },
      //     color: $r("app.color.background_page")
      //   })
      //   .justifyContent(FlexAlign.SpaceBetween)
      //
      //   Row() {
      //     Text("任务数据")
      //       .fontSize(16)
      //       .fontWeight(400)
      //       .fontColor($r("app.color.text_primary"))
      //
      //     Image($r("app.media.ic_btn_more"))
      //       .width(24)
      //       .height(24)
      //   }
      //   .width("100%")
      //   .height(60)
      //   .border({
      //     width: {
      //       bottom: 1
      //     },
      //     color: $r("app.color.background_page")
      //   })
      //   .justifyContent(FlexAlign.SpaceBetween)
      //
      //   Row() {
      //     Text("系统设置")
      //       .fontSize(16)
      //       .fontWeight(400)
      //       .fontColor($r("app.color.text_primary"))
      //
      //     Image($r("app.media.ic_btn_more"))
      //       .width(24)
      //       .height(24)
      //   }
      //   .width("100%")
      //   .height(60)
      //   .border({
      //     width: {
      //       bottom: 1
      //     },
      //     color: $r("app.color.background_page")
      //   })
      //   .justifyContent(FlexAlign.SpaceBetween)
      // }
      // .margin({
      //   left: 15,
      //   right: 15
      // })
      // .backgroundColor($r("app.color.white"))
      // .borderRadius(8)
      // .padding({
      //   left: 18,
      //   right: 18
      // })

    }
    .width("100%")
    .height("100%")
    .backgroundColor($r("app.color.background_page"))
  }
}

export default My
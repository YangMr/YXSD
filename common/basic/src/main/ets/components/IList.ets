@Component
export struct IList {
  @Prop
  finishedText: string = "没有更多数据了"
  @Prop
  loadingText: string = "拼命加载中"
  // 保存任务列表的数据
  @Prop
  dataSource: object[] = [] // 动态的, 应该是让父组件传递进来
  // 任务列表接口传递的参数
  // @State
  // 初始化一个变量保存请求的状态, false表示未上拉加载 , true上拉加载中
  @Prop
  loading: boolean = false
  // 初始化一个变量,保存数据是否请求完毕
  @Prop
  finished: boolean = false
  // 创建一个变量,保存下拉刷新的状态
  @Prop
  refreshIng: boolean = false
  @Prop
  refreshStatus: number = RefreshStatus.Inactive
  @BuilderParam
  renderItem: (item: object) => void
  // 下拉刷新方法
  onRefresh: () => Promise<void> = async () => {
  }

  getRefreshText() {
    // 如果下拉的距离小于刷新距离, 提示文本为继续下拉
    // 如果下拉的距离超过刷新距离, 松手刷新
    // 如果当前的状态是刷新中: 正在刷新
    switch (this.refreshStatus) {
      case RefreshStatus.Inactive:
        return ""
      case RefreshStatus.Drag:
        return "继续下拉"
      case RefreshStatus.OverDrag:
        return "松手刷新"
      case RefreshStatus.Refresh:
        return "正在刷新"
      default:
        return ""
    }
  }

  // 请求任务列表数据的方法
  onLoad: (flag?: boolean) => void = () => {
  }

  @Builder
  getBottom() {
    Row() {
      if (this.finished) {
        Text(this.finishedText)
          .fontSize(12)
          .fontColor($r("app.color.text_secondary"))
      } else {
        LoadingProgress()
          .width(20)
          .aspectRatio(1)
          .color($r("app.color.text_secondary"))

        Text(this.loadingText)
          .fontSize(12)
          .fontColor($r("app.color.text_secondary"))
      }

    }
    .width("100%")
    .padding(10)
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  getRefreshBuilder() {
    Row() {
      LoadingProgress()
        .width(40)
        .aspectRatio(1)
        .color($r("app.color.primary"))

      Text(this.getRefreshText())
        .fontSize(14)
        .fontColor($r("app.color.text_secondary"))
    }
    .width("100%")
    .height(50)
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Refresh({ refreshing: $$this.refreshIng, builder: this.getRefreshBuilder }) {
      List({ space: 10 }) {
        ForEach(this.dataSource, (item: object) => {
          ListItem() {
            this.renderItem(item)
          }
        })
        ListItem() {
          this.getBottom()
        }
      }
      .width("100%")
      .height("100%")
      .padding(15)
      .backgroundColor($r("app.color.background_page"))
      .onReachEnd(() => {
        if (this.loading) {
          return
        }
        if (this.finished) {
          return
        }
        this.onLoad()
      })
    }

    .onStateChange(async (state) => {
      // 下拉刷新的状态发生变化的时候进行触发
      this.refreshStatus = state
      if (this.refreshStatus === RefreshStatus.Refresh) {

        await this.onRefresh()

        // AlertDialog.show({
        //   message: this.refreshIng + ""
        // })
        this.refreshIng = false
      }
    })
  }
}


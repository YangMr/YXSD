import { getTaskListApi } from '../../../api/task';
import { TaskListDataModel, TaskListItemDataModel, TaskListParamsModel, TaskTypeEnum } from '../../../models';
import TaskItemCard from './TaskItemCard';

@Component
struct TaskList {
  // 保存任务列表的数据
  @State
  taskList: TaskListItemDataModel[] = []
  // 任务列表接口传递的参数
  // @State
  queryParams: TaskListParamsModel = {
    page: 1,
    pageSize: 10,
    status: TaskTypeEnum.Waiting
  }
  // 初始化一个变量保存请求的状态, false表示未上拉加载 , true上拉加载中
  @State
  loading: boolean = false
  // 初始化一个变量,保存数据是否请求完毕
  @State
  finished: boolean = false
  // 创建一个变量,保存下拉刷新的状态
  @State
  refreshIng: boolean = false
  @State
  refreshStatus: number = RefreshStatus.Inactive

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
  async onLoad(flag?: boolean) {
    try {
      // 将状态修改为上拉加载中
      this.loading = true


      // 获取任务列表数据
      const res: TaskListDataModel = await getTaskListApi(this.queryParams)

      // 数据追加
      if (flag) {
        this.taskList = res.items
      } else {
        this.taskList.push(...res.items)
      }

      // 如果当前数据的页面大于总页码,则不继续进行请求
      if (this.queryParams.page >= res.pages) {
        // AlertDialog.show({
        //   message: this.queryParams.page + ""
        // })
        this.finished = true
      }
      // 页码++
      this.queryParams.page++


      // flag ? this.taskList = res.items : this.taskList.push(...res.items)


      // 将状态修改为上拉加载已结束
      this.loading = false
    } catch (e) {
      console.log("error", e)
    }
  }

  // 下拉刷新方法
  async onRefresh() {
    this.queryParams.page = 1
    this.finished = false
    await this.onLoad(true)
  }

  @Builder
  getBottom() {
    Row() {
      if (this.finished) {
        Text("没有更多数据了~")
          .fontSize(12)
          .fontColor($r("app.color.text_secondary"))
      } else {
        LoadingProgress()
          .width(20)
          .aspectRatio(1)
          .color($r("app.color.text_secondary"))

        Text("拼命加载中...")
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
        ForEach(this.taskList, (item: TaskListItemDataModel) => {
          ListItem() {
            TaskItemCard({
              taskItem: item
            })
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
        this.refreshIng = false
      }


    })
  }
}

export default TaskList
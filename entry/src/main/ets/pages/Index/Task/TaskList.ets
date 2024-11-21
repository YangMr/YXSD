import { IList } from 'basic';
import { getTaskListApi } from '../../../api/task';
import { TaskListDataModel, TaskListItemDataModel, TaskListParamsModel, TaskTypeEnum } from '../../../models';
import TaskItemCard from './TaskItemCard';

@Component
struct TaskList {
  // 保存任务列表的数据
  @State
  taskList: TaskListItemDataModel[] = []
  // 任务列表接口传递的参数
  @Prop
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
  // 请求任务列表数据的方法
  onLoad = async (flag?: boolean) => {
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
      // AlertDialog.show({
      //   message: JSON.stringify(this.taskList, null, 2)
      // })


      // 如果当前数据的页面大于总页码,则不继续进行请求
      if (this.queryParams.page >= res.pages) {
        this.finished = true
      }
      // 页码++
      this.queryParams.page++
      // 将状态修改为上拉加载已结束
      this.loading = false
    } catch (e) {
      console.log("error", e)
    }
  }
  // 下拉刷新方法
  onRefresh = async () => {
    this.queryParams.page = 1
    this.finished = false
    await this.onLoad(true)
  }

  @Builder
  renderItem(item: object) {
    TaskItemCard({
      taskItem: item as TaskListItemDataModel
    })
  }

  build() {
    IList({
      finishedText: "没有了",
      loadingText: "加载中123",
      dataSource: this.taskList,
      renderItem: this.renderItem,
      onLoad: this.onLoad,
      finished: this.finished,
      onRefresh: this.onRefresh,
      loading: this.loading,
      refreshIng: this.refreshIng
    })
  }
}

export default TaskList
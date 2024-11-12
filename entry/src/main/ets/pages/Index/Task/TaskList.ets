import { getTaskListApi } from '../../../api/task';
import { TaskListDataModel, TaskListItemDataModel, TaskListParamsModel, TaskTypeEnum } from '../../../models';
import TaskItemCard from './TaskItemCard';

@Component
struct TaskList {
  // 保存任务列表的数据
  @State
  taskList: TaskListItemDataModel[] = []
  // 任务列表接口传递的参数
  @State
  queryParams: TaskListParamsModel = {
    page: 1,
    pageSize: 10,
    status: TaskTypeEnum.Waiting
  }

  aboutToAppear(): void {
    // 调用获取任务列表数据方法
    this.getTaskList()
  }

  // 获取任务列表数据
  async getTaskList() {
    try {
      const res: TaskListDataModel = await getTaskListApi(this.queryParams)
      this.taskList = res.items
    } catch (e) {
      console.log("error", e)
    }
  }

  build() {
    List({ space: 10 }) {
      ForEach(this.taskList, (item: TaskListItemDataModel) => {
        ListItem() {
          TaskItemCard({
            taskItem: item
          })
        }
      })
    }
    .width("100%")
    .height("100%")
    .padding(15)
    .backgroundColor($r("app.color.background_page"))
  }
}

export default TaskList
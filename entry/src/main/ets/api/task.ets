import { Http } from 'basic';
import { TaskListDataModel, TaskListParamsModel } from '../models';


/**
 * 任务列表接口
 */
export const getTaskListApi = (params: TaskListParamsModel): Promise<TaskListDataModel> => {
  return Http.get<TaskListDataModel>("/tasks/list", params)
}
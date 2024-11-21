import { Http } from 'basic';
import { deliverModel, PickUpModel, TaskDetailInfoModel } from '../models/task_detail';


// 任务详情
export const getTaskDetailInfoApi = (jobId: string): Promise<TaskDetailInfoModel> => {
  return Http.get<TaskDetailInfoModel>(`/tasks/details/${jobId}`,)
}

// 提货接口
export const pickUpApi = (data: PickUpModel): Promise<null> => {
  return Http.post<null>("/tasks/takeDelivery", data)
}

// 交货接口
export const deliverApi = (data: deliverModel): Promise<null> => {
  return Http.post<null>("/tasks/deliver", data)
}

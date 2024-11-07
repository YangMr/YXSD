// 1. 导入封装http请求
import { Http } from 'basic'

// 导入登录参数类型
import { AccountFormModel } from '../models'

// 2. 导出并创建对应接口方法
// 3. 给参数以及返回的数据指定类型

/**
 * 登录接口
 */
export const loginApi = (data: AccountFormModel): Promise<string> => {
  return Http.post<string>("/login/account", data)
}

// 获取用户信息接口

// 退出登录接口
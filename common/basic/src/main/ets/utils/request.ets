// 1. 安装axios(已完成)
// 2. 引入axios
import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios';
import { BASE_URL } from '../constants';

// 3. 创建axios实例对象
const service = axios.create({
  baseURL: BASE_URL,
  timeout: 10000
})
// 4. 创建请求拦截器
service.interceptors.request.use((config: InternalAxiosRequestConfig) => {
  return config;
}, (error: AxiosError) => {
  return Promise.reject(error);
});


// 5. 创建响应拦截器
service.interceptors.response.use((response: AxiosResponse) => {
  // 如果状态码是200 , 并页业务码也是200, 再返回的数据的时候,直接将需要的数据从data.data中获取出来
  if (response.status === 200 && response.data.code === 200) {
    return response.data.data
  }
}, (error: AxiosError) => {
  return Promise.reject(error);
});

// 6. 创建自定义的请求方式
class Http {
  static get<T>(url: string, params?: object) {
    return service.get<null, T>(url, { params })
  }

  static post<T>(url: string, data?: object) {
    return service.post<null, T>(url, data)
  }

  static put<T>(url: string, data?: object) {
    return service.put<null, T>(url, data)
  }

  static delete<T>(url: string, data?: object) {
    return service.delete<null, T>(url, data)
  }
}

// 7. 导出自定义的请求方法
export { Http }

import { request } from '@kit.BasicServicesKit'
import { BASE_URL, ImageListModel, UserSettingClass } from '../../../../Index'

interface ResponseData {
  code: number,
  msg: string,
  data: string
}


// export const uploadImageApi = async (fileParams: request.File[]) => {
//   const task = await request.uploadFile(getContext(), {
//     url: "https://slwl-api.itheima.net/driver/files/upload",
//     method: "POST",
//     header: {
//       Authorization: "eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiIxMDI0NzM4NDc2ODAyNzk5NTUzIiwiYWNjb3VudCI6Inhic2owMDEiLCJuYW1lIjoi5ZGo5LiAIiwib3JnaWQiOjEwMjQ3MDQ4NDQ0ODY3NTY2NDEsInN0YXRpb25pZCI6MTAyNDcwNzUzNTg5MTk0NDc2OSwiYWRtaW5pc3RyYXRvciI6ZmFsc2UsImV4cCI6MTczMjEyNTE4NX0.0XtcyVwfe2jHTKV1e7JKVJoZOpG7XLdJZCspikR9QTR6fAchwkUozNT4KeSGZmWKHUANXgnQNj17XqXh_PQuVQ",
//       "Content-Type": "multipart/form-data"
//     },
//     files: fileParams,
//     data: []
//   })
//
//
//   // 监听上传失败
//   task.on("fail", () => {
//     AlertDialog.show({
//       message: "123"
//     })
//   })
//
//   // 监听上传成功
//   task.on("headerReceive", (headers: object) => {
//     AlertDialog.show({
//       message: "1"
//     })
//     const result = JSON.parse(headers["body"]) as ResponseData
//     AlertDialog.show({
//       message: "2"
//     })
//     AlertDialog.show({
//       message: JSON.stringify(result, null, 2)
//     })
//   })
//
//
// }


// 实现文件上传有两种方式
// 1. axios上传
// 1.1 核心: 能够获取选择的文件对象


// 2. request.uploadFile上传
// 2.2 核心: 必须将图片存储到沙箱


// 3. request.uploadFile上传流程

// 3.1 创建一个方法,名字叫uploadImageApi的方法,在这个方法内封装文件上传的内容
// 3.2 使用request.uploadFile内置文件上传方法,在方法内传入两个参数, 分别是getContent , 与 上传的参数
// 3.3 上传的参数需要定义url、method、header、files、data
// 3.4 header中定义token
// 3.5 在files定义上传的文件对象, 而这个文件对象需要要4个参数:filename、name、uri、type
// 3.6 监听headerReceive获取文件上传成功的数据
// 3.6 监听fail获取文件上传失败的的数据


export async function uploadImageAPI(context: Context, fileParams: request.File[]) {

  // 1. 获取token
  const setting = new UserSettingClass(context)
  const token = setting.getUserToken()

  // 2. 发送请求
  const task = await request.uploadFile(context, {
    url: BASE_URL + "/files/upload",
    method: "POST",
    header: {
      Authorization: token,
      "Content-Type": "multipart/form-data"
    },
    data: [],
    files: fileParams
    // files: [
    //   {
    //     fileName: "文件名",
    //     name: "接口文档上文件上传的字段",
    //     uri: "internal://cache/文件的名称",
    //     type: "上传的文件的后缀名"
    //   }
    // ]
  })

  // 3. 监听上传成功
  return new Promise<ImageListModel[]>((resolve, reject) => {
    const arr: ImageListModel[] = []
    // 接受上传的数据
    task.on("headerReceive", (headers: object) => {
      if (headers["body"]) {
        const result = JSON.parse(headers["body"]) as ResponseData
        if (result.code === 200) {
          arr.push({
            url: result.data
          })
        }
      }
    })
    //  4. 监听上传成功
    task.on("fail", () => {
      AlertDialog.show({
        message: "上传失败"
      })
      reject(new Error("上传失败"))
    })
    // 不管成功或者失败都会触发的方法, 都将结果返回出去
    task.on("complete", () => {
      resolve(arr)
    })
  })
}


/***
 *
 * 1. 先打开系统相册(图片选择器)
 * 2. 获取选择的图片
 * 3. 将选择的图片存储到沙箱
 * 4. 将存储到沙箱的图片处理文件上传所需要的对象
 * 5. 获取token
 * 6. 发送请求
 * 7. 监听上传成功
 * 8. 监听上传失败
 * 9. 监听不管成功还是失败
 * 10. 使用promise将成功或者失败的结果返回出去
 * */






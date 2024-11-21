import { fileIo } from '@kit.CoreFileKit'
import { ImageListModel } from '../models'
import { request } from '@kit.BasicServicesKit'
import { uploadFile } from '../api'


export const SaveLocalFile = async (dataSource: ImageListModel[]) => {
  // 1. 获取到存储的沙箱目录 --- files目录
  const saveDir = getContext().cacheDir

  // 创建一个数组, 保存要上传的文件列表
  const fileParams: request.File[] = []
  dataSource.forEach((item: ImageListModel) => {
    // 2. 图片的名称
    // const imgName = util.generateRandomUUID() + ".jpg"
    const imgName = Date.now() + ".jpg"
    // 3.读取保存到沙箱的图片文件数据
    const file = fileIo.openSync(item.url, fileIo.OpenMode.READ_ONLY)
    // 4. 将相册文件拷贝到存储到沙箱的图片文件中
    fileIo.copyFileSync(file.fd, saveDir + "/" + imgName)
    // 5. 关闭文件数据的读取
    fileIo.closeSync(file.fd)

    // 将上传的每一个文件添加到fileParams中
    fileParams.push({
      filename: imgName,
      name: "file",
      type: "jpg",
      uri: `internal://cache/${imgName}`
    })
  })

  return await uploadFile(getContext(), fileParams)

}


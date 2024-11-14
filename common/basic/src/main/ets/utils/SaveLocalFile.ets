import { fileIo } from '@kit.CoreFileKit'
import { ImageListModel } from '../models'

export const SaveLocalFile = (dataSource: ImageListModel[]) => {
  // 1. 获取到存储的沙箱目录 --- files目录
  const saveDir = getContext().filesDir

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
  })
}
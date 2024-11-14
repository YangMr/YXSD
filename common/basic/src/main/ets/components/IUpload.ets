import { photoAccessHelper } from '@kit.MediaLibraryKit';
import { ImageListModel } from '../models';
import { SaveLocalFile } from '../utils';
import { IPreview } from './IPreview';


@Component
export struct IUpload {
  @Prop
  title: string = ""
  @Prop
  maxNumber: number = 3
  @Prop
  imageList: ImageListModel[] = []
  @State
  index: number = 0
  customDialogController: CustomDialogController = new CustomDialogController({
    builder: IPreview({
      urls: this.imageList.map((item: ImageListModel) => item.url),
      selectIndex: this.index
    }),
    customStyle: true
  })

  // 唤醒系统相册
  async selectImage() {
    // 创建图库选择器实例
    const photoViewPicker = new photoAccessHelper.PhotoViewPicker();
    // 打开系统相册
    const result = await photoViewPicker.select({
      maxSelectNumber: this.maxNumber - this.imageList.length,
      MIMEType: photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE
    })
    const data = result.photoUris.map((item: string) => {
      return { url: item } as ImageListModel
    })
    // 将选择的图片保存到imageList里面
    this.imageList.push(...data)

    // 将选择的图片存储到沙箱
    SaveLocalFile(this.imageList)

  }

  build() {
    Column() {
      if (this.title) {
        Text(this.title)
          .fontSize(14)
          .fontColor($r("app.color.text_secondary"))
          .margin({
            top: 16,
            bottom: 16
          })
      }


      Grid() {

        ForEach(this.imageList, (item: ImageListModel, index: number) => {
          GridItem() {
            Image(item.url)
              .width(95)
              .height(95)
              .borderRadius(5)
              .onClick(() => {
                this.customDialogController.open()
                this.index = index
              })
          }
        })

        if (this.imageList?.length < 3) {
          GridItem() {
            Row() {
              Image($r("app.media.ic_add_img"))
                .width(30)
                .height(30)
            }
            .width(95)
            .height(95)
            .backgroundColor("#f2f2f2")
            .justifyContent(FlexAlign.Center)
            .onClick(() => {
              this.selectImage()
            })
          }
        }

      }
      .columnsTemplate("1fr 1fr 1fr")
      .columnsGap(10)
      .rowsGap(10)

    }
    .width("100%")
    .alignItems(HorizontalAlign.Start)
  }
}


function saveLocalFile() {
  throw new Error('Function not implemented.');
}

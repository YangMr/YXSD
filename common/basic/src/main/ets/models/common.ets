export interface RouterParamsModel {
  id: string
}

export interface ImageListModel {
  url: string
}

export class BaseBuilderClass {
  title: string = ""
  value: string = ""
  icon?: ResourceStr = ""
}
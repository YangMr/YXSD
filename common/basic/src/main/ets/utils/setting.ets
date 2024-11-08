// 封装存储数据的方法
import { preferences } from '@kit.ArkData'
import { TOKEN_KEY, XSD_SETTING, XSD_SETTING_AD } from '../constants'
import { AdvertClass } from '../models'

// 广告的默认配置(后台返回的广告配置)
export const defaultAd: AdvertClass = {
  // 广告时长
  adTime: 10,
  // 显示广告
  showAd: true,
  //  广告图片
  adImage: $r("app.media.start")
}


export class UserSettingClass {
  context: Context

  // 实例化UserSettingClass这个类进行触发
  constructor(context: Context) {
    // 初始化上下文对象
    this.context = context
  }

  // 创建仓库
  getStore() {
    // 创建仓库
    return preferences.getPreferencesSync(this.context, {
      name: XSD_SETTING
    })
  }

  // 存储广告数据
  setUserAd(ad: AdvertClass) {
    // 获取到了创建的仓库
    const store = this.getStore()
    // 给仓库中存储数据
    store.putSync(XSD_SETTING_AD, JSON.stringify(ad))
    // 将输入写入到磁盘
    store.flush()
  }

  // 获取数据
  getUserAd(): AdvertClass {
    // 获取到了创建的仓库
    const store = this.getStore()
    // 获取广告的数据
    return JSON.parse(store.getSync(XSD_SETTING_AD, JSON.stringify(defaultAd)) as string)
  }

  // 存储token的数据
  setUserToken(token: string) {
    // 获取仓库
    const store = this.getStore()
    // 给仓库中添加数据
    store.putSync(TOKEN_KEY, token)
    // 写入到磁盘
    store.flush()
  }

  // 获取存储在首选中的token数据
  getUserToken(): string {
    // 获取仓库
    const store = this.getStore()
    // 获取数据
    return store.getSync(TOKEN_KEY, "") as string
  }
}


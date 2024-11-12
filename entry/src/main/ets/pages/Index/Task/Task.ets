import { TaskTabs } from './TaskTabs'

@Component
struct Task {
  build() {
    Column() {
      TaskTabs()
    }
    .width("100%")
    .height("100%")
  }
}

export default Task
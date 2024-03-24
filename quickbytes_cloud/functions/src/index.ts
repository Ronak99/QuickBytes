import { onNewsPublish, publishNews, removeNews } from './routes/news.routes'
import { notifyTopic } from './routes/notifications.route'
import { onSettingsUpdate, createSetting } from './routes/settings.route'

export {
    notifyTopic,
    onNewsPublish,
    publishNews,
    removeNews,
    onSettingsUpdate,
    createSetting,
}
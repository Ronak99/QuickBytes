import { Article } from "./article";

enum NotificationCategory {
  deliverNews = "deliverNews",
  cancelNews = "cancelNews",
  randomUpdates = "randomUpdates",
}

interface BaseNotification {
  topic: string;
  payload: {};
}

interface NewsNotification extends BaseNotification {
  payload: {
    article: Article;
    category: NotificationCategory;
  };
}

export { NewsNotification, BaseNotification, NotificationCategory };

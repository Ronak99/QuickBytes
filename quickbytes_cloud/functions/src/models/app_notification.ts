import { Article } from "./article";

enum Category {
  deliverNews = "deliver_news",
  cancelNews = "cancel_news",
  randomUpdates = "random_updates",
}

interface BaseNotification {
  topic: string;
  payload: {};
}

interface NewsNotification extends BaseNotification {
  payload: {
    article: Article;
    category: Category;
  };
}

export { NewsNotification, BaseNotification, Category };

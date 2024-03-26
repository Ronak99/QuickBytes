import { Article } from "./article";

enum Category {
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
    category: Category;
  };
}

export { NewsNotification, BaseNotification, Category };

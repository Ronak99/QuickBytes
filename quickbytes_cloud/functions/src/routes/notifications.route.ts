import { onDocumentCreated } from "firebase-functions/v2/firestore";
import { onRequest, onCall } from "firebase-functions/v2/https";
import * as notificationService from "../services/notifications.service";
import { Article, Relevancy } from "../models/article";
import { Category, NewsNotification } from "../models/app_notification";

const notifyTopic = onCall(async (request) => {
  const notification: NewsNotification = {
    topic: "entertainment_all",
    payload: {
      article: {
        id: "random-article-1",
        title: "News Title",
        content: "Content",
        image:
          "https://png.pngtree.com/thumb_back/fh260/background/20230519/pngtree-landscape-jpg-wallpapers-free-download-image_2573540.jpg",
        published_on: new Date(),
        category_list: ["entertainment", "politics"],
        relevancy: Relevancy.all,
        source_url: "https://www.google.com",
      },
      category: Category.deliverNews,
    },
  };

  const response = await notificationService.notifyTopic(notification);
  return response;
});

export { notifyTopic };

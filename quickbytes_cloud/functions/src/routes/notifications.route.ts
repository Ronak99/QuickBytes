import { onDocumentCreated } from "firebase-functions/v2/firestore";
import { onRequest, onCall } from "firebase-functions/v2/https";
import * as notificationService from "../services/notifications.service";
import { Article } from "../models/article";
import AppNotification from "src/models/app_notification";

const notifyTopic = onCall(async (request) => {
  const payload = {
    type: "delivery",
    article: {
      id: "random-article-1",
      title: "News Title",
      content: "Content",
      image:
        "https://png.pngtree.com/thumb_back/fh260/background/20230519/pngtree-landscape-jpg-wallpapers-free-download-image_2573540.jpg",
      published_on: "date",
      category_list: ["entertainment", "politics"],
      relevancy: "all",
      source_url: "https://www.google.com",
    },
  };

  const notification: AppNotification = {
    topic: "entertainment_all",
    payload: {
      data: {
        data: JSON.stringify(payload),
      },
    },
  };

  const response = await notificationService.notifyTopic(notification);
  return response;
});

export { notifyTopic };

import httpStatus = require("http-status");
import { Article } from "../models/article";
import ApiError from "../utils/ApiError";
import { logger } from "firebase-functions/v2";
import { Firestore } from "../utils/FirestoreReference";
import { notifyTopic } from "./notifications.service";
import AppNotification from "src/models/app_notification";

const onNewsPublish = async ({ article }: { article: Article }) => {
  let log: any = {};

  for (const category of article.category_list) {
    const topic = `${category}_${article.relevancy}`;

    // initialize notification
    const notification: AppNotification = {
      payload: {},
      topic: topic,
    };

    // handle response
    let response: any;
    try {
      response = await notifyTopic(notification);
    } catch (e) {
      if (e instanceof ApiError) {
        response = e.message;
      }
    }

    // notification response
    log[topic] = response;
  }

  Firestore.notificationDelivery.doc(article.id!).set(log);
};

const publishNews = async ({ article }: { article: Article }) => {
  try {
    article.id = Firestore.news.doc().id;
    await Firestore.news.doc(article.id).set(article);
    return article.id;
  } catch (e) {
    throw new ApiError(httpStatus.FORBIDDEN, "Forbidden");
  }
};

export { onNewsPublish, publishNews };

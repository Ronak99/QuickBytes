import httpStatus from "http-status";
import prisma from "../../client";
import ApiError from "../../utils/ApiError";
import { articleKeys } from "../constants/fields";
import {
  NewsNotification,
  NotificationCategory,
} from "../models/app_notification";
import { Article } from "../models/article";
import notificationService from "./notification.service";

const notifyUsers = async (article: any) => {
  const categories = article.categories;

  if (!Array.isArray(categories)) {
    return;
  }

  for (const category of categories) {
    const newsNotification: NewsNotification = {
      topic: category.name,
      payload: {
        article: article,
        category: NotificationCategory.deliverNews,
      },
    };

    console.log(JSON.stringify(newsNotification.payload));

    // notificationService.notifyTopic(newsNotification);
  }
};

const createArticle = async (article: Article) => {
  const response = await prisma.article.create({
    data: {
      title: article.title,
      content: article.content,
      image: article.image,
      published_on: article.published_on,
      source_url: article.source_url,
      category_ids: article.categories as string[],
      user_id: article.user_id,
    },
    select: {
      ...articleKeys.reduce((obj, k) => ({ ...obj, [k]: true }), {}),
    },
  });

  // notify others
  notifyUsers(response);

  return response;
};

const queryArticles = () => {
  return prisma.article.findMany({
    select: {
      id: true,
      title: true,
      content: true,
      categories: true,
      author: true,
    },
  });
};

export default {
  createArticle,
  queryArticles,
};

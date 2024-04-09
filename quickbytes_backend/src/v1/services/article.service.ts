import { category, user } from "@prisma/client";
import httpStatus from "http-status";
import prisma from "../../client";
import ApiError from "../../utils/ApiError";

interface Article {
  title: string;
  content: string;
  image: string;
  published_on: Date;
  source_url: string;
  userId: string;
  categories: string[];
}

const createArticle = async (article: Article) => {
  const response = await prisma.article.create({
    data: {
      title: article.title,
      content: article.content,
      image: article.image,
      published_on: article.published_on,
      source_url: article.source_url,
      category_ids: article.categories,
      user_id: article.userId,
    },
  });

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

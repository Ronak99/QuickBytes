import { newsCategory } from "@prisma/client";
import httpStatus from "http-status";
import prisma from "../../client";
import ApiError from "../../utils/ApiError";
import { NewsCategory } from "../models/news_category";

const createCategory = async (category: NewsCategory) => {
  if (await getCategoryByName(category.name)) {
    throw new ApiError(httpStatus.BAD_REQUEST, "Category exists!");
  }
  return prisma.newsCategory.create({
    data: category,
  });
};

const queryCategories = () => {
  return prisma.newsCategory.findMany({
    select: {
      name: true,
      id: true,
      relevancy: true,
      label: true,
    },
  });
};

const getCategoryByName = async <Key extends keyof newsCategory>(
  name: string,
  keys: Key[] = ["name", "relevancy", "label"] as Key[]
): Promise<Pick<newsCategory, Key> | null> => {
  return prisma.newsCategory.findUnique({
    where: { name },
    select: keys.reduce((obj, k) => ({ ...obj, [k]: true }), {}),
  }) as Promise<Pick<newsCategory, Key> | null>;
};

export default {
  createCategory,
  queryCategories,
};

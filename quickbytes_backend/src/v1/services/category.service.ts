import { category, user } from "@prisma/client";
import httpStatus from "http-status";
import prisma from "../../client";
import ApiError from "../../utils/ApiError";

enum Relevancy {
  all = "all",
  major = "major",
}

interface Category {
  name: string;
  relevancy: Relevancy;
  label: string;
}

const createCategory = async (category: Category) => {
  if (await getCategoryByName(category.name)) {
    throw new ApiError(httpStatus.BAD_REQUEST, "Category exists!");
  }
  return prisma.category.create({
    data: category,
  });
};

const queryCategories = () => {
  return prisma.category.findMany({
    select: {
      name: true,
      id: true,
      relevancy: true,
      label: true,
    },
  });
};

const getCategoryByName = async <Key extends keyof category>(
  name: string,
  keys: Key[] = ["name", "relevancy", "label"] as Key[]
): Promise<Pick<category, Key> | null> => {
  return prisma.category.findUnique({
    where: { name },
    select: keys.reduce((obj, k) => ({ ...obj, [k]: true }), {}),
  }) as Promise<Pick<category, Key> | null>;
};

export default {
  createCategory,
  queryCategories,
};

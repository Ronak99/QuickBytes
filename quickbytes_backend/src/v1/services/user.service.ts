import { user } from "@prisma/client";
import httpStatus from "http-status";
import prisma from "../../client";
import ApiError from "../../utils/ApiError";
import { articleKeys, userKeys } from "../constants/fields";

interface User {
  id: string;
  name: string;
  email: string;
  image: string;
}

const createUser = async (user: User) => {
  if (await getUserByEmail(user.email)) {
    throw new ApiError(httpStatus.BAD_REQUEST, "Email already taken");
  }

  return prisma.user.create({
    data: user,
  });
};

const queryUser = async (userId: string) => {
  if (!userId) {
    throw new ApiError(httpStatus.BAD_REQUEST, "User ID was not provided.");
  }
  return prisma.user.findUnique({
    where: {
      id: userId,
    },
    select: {
      ...userKeys.reduce((obj, k) => ({ ...obj, [k]: true }), {}),
      article: {
        select: {
          ...articleKeys.reduce((obj, k) => ({ ...obj, [k]: true }), {}),
        },
      },
    },
  });
};

const getUserByEmail = async <Key extends keyof user>(
  email: string,
  keys: Key[] = ["id", "name", "email", "image"] as Key[]
): Promise<Pick<user, Key> | null> => {
  return prisma.user.findUnique({
    where: { email },
    select: keys.reduce((obj, k) => ({ ...obj, [k]: true }), {}),
  }) as Promise<Pick<user, Key> | null>;
};

export default {
  queryUser,
  createUser,
};

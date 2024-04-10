import { Prisma } from "@prisma/client";
import { NewsCategory, Relevancy } from "./news_category";

export interface Article {
  id?: string;
  title: string;
  content: string;
  image: string;
  published_on: Date;
  categories: string[] | Prisma.article$categoriesArgs;
  source_url: string;
  user_id: string;
}

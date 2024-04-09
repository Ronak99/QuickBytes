import express from "express";
import { categoryController } from "../controllers";
import articlesRoute from "./article.route";
import userRoute from "./user.route";
import categoryRoute from "./category.route";

const router = express.Router();

const defaultRoutes = [
  {
    path: "/articles",
    route: articlesRoute,
  },
  {
    path: "/users",
    route: userRoute,
  },
  {
    path: "/categories",
    route: categoryRoute,
  },
];

defaultRoutes.forEach((route) => {
  router.use(route.path, route.route);
});

export default router;

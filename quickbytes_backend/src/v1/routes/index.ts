import express from "express";
import { categoryController } from "../controllers";
import articlesRoute from "./article.route";
import userRoute from "./user.route";
import categoryRoute from "./category.route";
import notificationRoute from "./notification.route";

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
  {
    path: "/notifications",
    route: notificationRoute,
  },
];

defaultRoutes.forEach((route) => {
  router.use(route.path, route.route);
});

export default router;

import express from "express";
import { articleController } from "../controllers";

const router = express.Router();

router
  .route("/")
  .post(articleController.createArticle)
  .get(articleController.queryArticles);

router.route("/:articleId").get(articleController.queryArticle);

router.route("/testing").post(articleController.testing);

export default router;

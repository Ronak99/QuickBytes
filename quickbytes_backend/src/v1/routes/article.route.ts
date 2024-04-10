import express from "express";
import { articleController } from "../controllers";

const router = express.Router();

router
  .route("/articles")
  .post(articleController.createArticle)
  .get(articleController.queryArticles);

router.route("/testing").post(articleController.testing);

export default router;

import express from "express";
import { articleController } from "../controllers";

const router = express.Router();

router
  .route("/articles")
  .post(articleController.createArticle)
  .get(articleController.queryArticles);

export default router;

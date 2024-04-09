import express from "express";
import { categoryController } from "../controllers";

const router = express.Router();

router
  .route("/categories")
  .post(categoryController.createCategory)
  .get(categoryController.queryCategories);

export default router;

import express from "express";
import { categoryController } from "../controllers";

const router = express.Router();

router
  .route("/")
  .post(categoryController.createCategory)
  .get(categoryController.queryCategories);

router.route("/testing").post(categoryController.testing);

export default router;

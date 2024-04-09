import express from "express";
import auth from "../../middlewares/auth";
import { notificationController } from "../controllers";

const router = express.Router();

router.route("/topic").post(notificationController.notifyTopic);

export default router;

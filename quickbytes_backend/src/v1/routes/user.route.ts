import express from "express";
import auth from "../../middlewares/auth";
import { userController } from "../controllers";

const router = express.Router();

router.route("/").post(userController.createUser);
router.route("/me").get(userController.queryUser);

export default router;

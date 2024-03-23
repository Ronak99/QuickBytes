import httpStatus = require("http-status");
import { notifications } from "../firebase";
import AppNotification from "../models/app_notification";
import ApiError from "../utils/ApiError";

const notifyTopic = async (notification: AppNotification) => {
  try {
    // const response = await notifications.sendToTopic(notification.topic, notification.payload)
    return notification;
    // return response.messageId;
  } catch (e: any) {
    throw new ApiError(httpStatus.EXPECTATION_FAILED, e);
  }
};

export { notifyTopic };

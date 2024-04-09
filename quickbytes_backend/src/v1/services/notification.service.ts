import httpStatus from "http-status";
import { notifications } from "../../config/firebase";
import ApiError from "../../utils/ApiError";
import { BaseNotification } from "../models/app_notification";

// Always return something
const notifyTopic = async (notification: BaseNotification) => {
  try {
    const response = await notifications.sendToTopic(notification.topic, {
      data: {
        data: JSON.stringify(notification.payload),
      },
    });
    // return notification;
    return response;
  } catch (e: any) {
    throw new ApiError(httpStatus.EXPECTATION_FAILED, e);
  }
};

export default { notifyTopic };

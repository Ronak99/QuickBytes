import httpStatus = require("http-status");
import { notifications } from "../firebase";
import { BaseNotification } from "../models/app_notification";
import ApiError from "../utils/ApiError";

// Always return something
const notifyTopic = async (notification: BaseNotification) => {
  console.log(notification);
  return "test123";
  // console.log(`notifying topic: ${notification.topic}`);
  // try {
  //   const response = await notifications.sendToTopic(
  //     notification.topic,
  //     notification.payload
  //   );
  //   // return notification;
  //   return response;
  // } catch (e: any) {
  //   throw new ApiError(httpStatus.EXPECTATION_FAILED, e);
  // }
};

export { notifyTopic };

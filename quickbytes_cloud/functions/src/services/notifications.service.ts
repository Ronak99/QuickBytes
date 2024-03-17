import httpStatus = require("http-status")
import { notifications } from "../firebase"
import AppNotification from "../models/notification"
import ApiError from "../utils/ApiError"

const notifyTopic = async (notification: AppNotification) => {
    try {
        const response = await notifications.sendToTopic(notification.topic, notification.payload)
        return response.messageId;
    } catch (e) {
        throw new ApiError(httpStatus.EXPECTATION_FAILED, JSON.stringify(e));
    }
}

export {
    notifyTopic,
}
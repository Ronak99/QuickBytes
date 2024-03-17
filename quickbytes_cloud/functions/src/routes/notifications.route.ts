import { onDocumentCreated } from 'firebase-functions/v2/firestore'
import { onRequest, onCall } from 'firebase-functions/v2/https'
import * as notificationService from '../services/notifications.service';
import { News } from '../models/news';
import AppNotification from 'src/models/notification';

const notifyTopic = onCall(async (request) => {
    const notification: AppNotification = {
        topic: 'example',
        payload: {
            notification: {
                title: 'This is a headline',
                body: 'This is some body',
                channel_id: 'default',
            },
            data: {
                id: "1234",
            },
        }
    }

    await notificationService.notifyTopic(notification);
    return "Done"
});

export {
    notifyTopic,
}
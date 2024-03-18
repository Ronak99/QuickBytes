import { onDocumentCreated } from 'firebase-functions/v2/firestore'
import { onRequest, onCall } from 'firebase-functions/v2/https'
import * as notificationService from '../services/notifications.service';
import { Article } from '../models/article';
import AppNotification from 'src/models/notification';

const notifyTopic = onCall(async (request) => {
    const notification: AppNotification = {
        topic: 'example',
        payload: {
            notification: {
                title: 'What are the important Lok Sabha election dates for Madhya Pradesh',
                channel_id: 'default',
                imageUrl: 'https://media.istockphoto.com/id/1470130937/photo/young-plants-growing-in-a-crack-on-a-concrete-footpath-conquering-adversity-concept.webp?b=1&s=170667a&w=0&k=20&c=IRaA17rmaWOJkmjU_KD29jZo4E6ZtG0niRpIXQN17fc='
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
import { firestore } from "../firebase";
import { newsConverter, settingsConverter } from "./FirestoreConverter";

export const Firestore = {
    news: firestore.collection('news').withConverter(newsConverter),
    notificationDelivery: firestore.collection('logs/document/notification_delivery'),
    settings: firestore.collection('settings').withConverter(settingsConverter),
};
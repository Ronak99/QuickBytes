import { firestore } from "../firebase";
import { newsConverter } from "./FirestoreConverter";

export const Firestore = {
    news: firestore.collection('news').withConverter(newsConverter)
};
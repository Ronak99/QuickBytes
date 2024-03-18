import Settings from "src/models/settings";
import { Article } from "../models/article";

const newsConverter = {
    toFirestore: (data: Article) => data,
    fromFirestore: (snap: FirebaseFirestore.QueryDocumentSnapshot) =>
        snap.data() as Article
}

const settingsConverter = {
    toFirestore: (data: Settings) => data,
    fromFirestore: (snap: FirebaseFirestore.QueryDocumentSnapshot) =>
        snap.data() as Settings
}

export {
    newsConverter,
    settingsConverter,
}

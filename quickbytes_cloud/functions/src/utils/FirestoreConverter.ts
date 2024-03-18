import { Article } from "../models/article";

const newsConverter = {
    toFirestore: (data: Article) => data,
    fromFirestore: (snap: FirebaseFirestore.QueryDocumentSnapshot) =>
        snap.data() as Article
}

export {
    newsConverter,
}

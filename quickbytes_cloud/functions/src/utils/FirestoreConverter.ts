import { News } from "../models/news";

const newsConverter = {
    toFirestore: (data: News) => data,
    fromFirestore: (snap: FirebaseFirestore.QueryDocumentSnapshot) =>
        snap.data() as News
}

export {
    newsConverter,
}

import httpStatus = require("http-status")
import { News } from "../models/news"
import ApiError from "../utils/ApiError"
import { logger } from 'firebase-functions/v2'
import { Firestore } from "../utils/FirestoreReference"

const onNewsPublish = () => {
    throw new ApiError(httpStatus.BAD_REQUEST, "An error occurred!")
}

const publishNews = async ({ news }: { news: News }) => {
    try {
        news.id = Firestore.news.doc().id
        await Firestore.news.doc(news.id).set(news);
        return news.id
    } catch (e) {
        throw new ApiError(httpStatus.FORBIDDEN, "Forbidden")
    }
}

export {
    onNewsPublish,
    publishNews,
}
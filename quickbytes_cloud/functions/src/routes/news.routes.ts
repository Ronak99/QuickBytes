import { onDocumentCreated } from 'firebase-functions/v2/firestore'
import { onRequest, onCall } from 'firebase-functions/v2/https'
import ApiErrorHandler from '../utils/ApiErrorHandler';
import * as newsService from '../services/news.service';
import { News } from '../models/news';

const onNewsPublish = onDocumentCreated("news/{newsId}", (newsDoc) => {
    newsService.onNewsPublish();
    console.log(newsDoc.data?.data())
});


/**
 * Publishes NEWS within the news collection
 * @param {number} page - The page number to retrieve.
 * @param {number} limit - The number of users per page.
 * @returns {Promise<User[]>} A promise that resolves with an array of User objects.
 */
const publishNews = onRequest(async (request, response) => {
    try {
        const newsId = await newsService.publishNews({ news: request.body });
        response.send({ 'success': newsId })
    } catch (error: any) {
        new ApiErrorHandler(error, response);
    }
});

const removeNews = onCall((request) => {
    console.log(request)
    return "Done"
});

export {
    onNewsPublish,
    publishNews,
    removeNews,
}
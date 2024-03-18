import { onDocumentCreated, onDocumentUpdated } from 'firebase-functions/v2/firestore'
import { onRequest, onCall } from 'firebase-functions/v2/https'
import ApiErrorHandler from '../utils/ApiErrorHandler';
import * as settingsService from '../services/settings.service';
import { Article } from '../models/article';
import Settings from '../models/settings';

/**
 * Handled FCM topic subscription/unsubscription
 */
const onSettingsUpdate = onDocumentUpdated("settings/{uid}", async (settingsDoc) => {
    const response = settingsService.onTopicListUpdate({
        oldSettings: settingsDoc.data?.before.data() as Settings,
        newSettings: settingsDoc.data?.after.data() as Settings,
    });

    console.log(response)
});

const createSetting = onCall(async (request) => {
    settingsService.createSetting();
});

export {
    onSettingsUpdate,
    createSetting,
}
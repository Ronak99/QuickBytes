import Settings from "src/models/settings";
import { Firestore } from "../utils/FirestoreReference";

const onTopicListUpdate = (
    { oldSettings, newSettings }: { oldSettings: Settings, newSettings: Settings }
) => {

    const previouslySubscribedTopics = oldSettings.subscribed_topics;
    const subscribedTopics = newSettings.subscribed_topics;

    // Find topics that were in previouslySubscribedTopics but are not in subscribedTopics
    const topicsUnsubscribed = previouslySubscribedTopics.filter(topic => !subscribedTopics.includes(topic));

    // Find topics that were not in previouslySubscribedTopics but are in subscribedTopics
    const topicsSubscribed = subscribedTopics.filter(topic => !previouslySubscribedTopics.includes(topic));

    return {
        topicsSubscribed: topicsSubscribed,
        topicsUnsubscribed: topicsUnsubscribed,
    }
}

const createSetting = () => {
    const randomId = Firestore.settings.doc().id
    const settings: Settings = {
        subscribed_topics: [
            'entertainment',
        ]
    };
    Firestore.settings.doc(randomId).set(settings)
}

export {
    onTopicListUpdate,
    createSetting,
}
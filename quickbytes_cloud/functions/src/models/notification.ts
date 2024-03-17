interface AppNotification {
    topic: string,
    payload: Payload,
}

interface Payload {
    notification: {
        title: string,
        body: string,
        channel_id: string,
        priority?: 'high',
        click_action?: 'FLUTTER_NOTIFICATION_CLICK',
    },
    data: {
        id: string,
    },
}

export default AppNotification
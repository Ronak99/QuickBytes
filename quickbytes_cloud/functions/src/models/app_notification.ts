interface AppNotification {
  topic: string;
  payload: {};
}

interface Payload {
  notification: {
    title: string;
    body: string;
    channel_id: string;
    imageUrl: string;
    priority?: "high";
    click_action?: "FLUTTER_NOTIFICATION_CLICK";
  };
  data: {
    id: number;
    articleId: string;
  };
}

export default AppNotification;

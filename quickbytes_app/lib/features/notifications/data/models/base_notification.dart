import 'package:quickbytes_app/features/notifications/data/models/news/news_notification.dart';

enum Category {
  deliverNews,
  cancelNews,
  reminder,
}

const Map<String, Category> categoryMap = {
  'deliverNews': Category.deliverNews,
  'cancelNews': Category.cancelNews,
  'reminder': Category.reminder,
};

class BaseNotification {
  const BaseNotification({
    required Category category,
  });

  factory BaseNotification.empty(String message) {
    throw Exception(message);
  }

  factory BaseNotification.fromJson(Map<String, dynamic> json) {
    Category category = categoryMap[json['category']]!;

    switch (category) {
      case Category.deliverNews:
      case Category.cancelNews:
        return NewsNotification.fromJson(json);
      default:
        return BaseNotification.empty(
          "Invalid category for BaseNotification: $category",
        );
    }
  }
}

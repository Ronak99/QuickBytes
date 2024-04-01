import 'package:news_repository/news_repository.dart';
import 'package:quickbytes_app/features/notifications/data/models/base_notification.dart';

class NewsNotification extends BaseNotification {
  final Article article;
  final Category category;

  const NewsNotification({
    required this.article,
    required this.category,
  }) : super(category: category);

  factory NewsNotification.fromJson(Map<String, dynamic> json) {
    return NewsNotification(
      article: Article.fromJson(json['article']),
      category: categoryMap[json['category']]!,
    );
  }
}

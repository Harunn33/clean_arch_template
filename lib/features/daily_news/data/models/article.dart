import 'package:clean_arch_template/features/daily_news/domain/entities/article.dart';

class ArticleModel extends ArticleEntity {
  const ArticleModel({
    int? id,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? content,
  }) : super(
          author: author,
          content: content,
          description: description,
          id: id,
          publishedAt: publishedAt,
          title: title,
          url: url,
          urlToImage: urlToImage,
        );

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      author: json['author'] ?? "",
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      url: json['url'] ?? "",
      urlToImage: json['urlToImage'] ?? "",
      publishedAt: json['publishedAt'] ?? "",
      content: json['content'] ?? "",
    );
  }
}

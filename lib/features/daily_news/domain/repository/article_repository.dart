import 'package:clean_arch_template/core/resources/data_state.dart';
import 'package:clean_arch_template/features/daily_news/domain/entities/article.dart';

abstract class ArticleRepository {
  Future<DataState<List<ArticleEntity>>> getArticles();
}

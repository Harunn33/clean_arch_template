import 'package:clean_arch_template/core/usecases/usecase.dart';
import 'package:clean_arch_template/features/daily_news/domain/entities/article.dart';
import 'package:clean_arch_template/features/daily_news/domain/repository/article_repository.dart';

class GetSavedArticleUseCase implements UseCase<List<ArticleEntity>, void> {
  final ArticleRepository repository;
  GetSavedArticleUseCase({required this.repository});

  @override
  Future<List<ArticleEntity>> call({void params}) {
    return repository.getSavedArticles();
  }
}

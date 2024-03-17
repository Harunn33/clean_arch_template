import 'package:clean_arch_template/core/usecases/usecase.dart';
import 'package:clean_arch_template/features/daily_news/domain/entities/article.dart';
import 'package:clean_arch_template/features/daily_news/domain/repository/article_repository.dart';

class DeleteArticleUseCase implements UseCase<void, ArticleEntity> {
  final ArticleRepository repository;
  DeleteArticleUseCase({required this.repository});

  @override
  Future<void> call({ArticleEntity? params}) {
    return repository.deleteArticle(params!);
  }
}

import 'package:clean_arch_template/core/resources/data_state.dart';
import 'package:clean_arch_template/core/usecases/usecase.dart';
import 'package:clean_arch_template/features/daily_news/domain/entities/article.dart';
import 'package:clean_arch_template/features/daily_news/domain/repository/article_repository.dart';

class GetArticlesUseCase
    implements UseCase<DataState<List<ArticleEntity>>, void> {
  final ArticleRepository repository;
  GetArticlesUseCase({required this.repository});

  @override
  Future<DataState<List<ArticleEntity>>> call({void params}) {
    return repository.getArticles();
  }
}

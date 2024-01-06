import 'package:clean_arch_template/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:clean_arch_template/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:clean_arch_template/features/daily_news/domain/usecases/get_articles.dart';
import 'package:clean_arch_template/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

class DependencyInjection {
  Future<void> init() async {
    // Dio
    sl.registerSingleton<Dio>(Dio());

    // Dependencies
    sl.registerSingleton<NewsApiService>(NewsApiService(sl<Dio>()));

    sl.registerSingleton<ArticleRepositoryImpl>(
      ArticleRepositoryImpl(
        newsApiService: sl<NewsApiService>(),
      ),
    );

    // Use Cases
    sl.registerSingleton<GetArticlesUseCase>(
      GetArticlesUseCase(
        repository: sl<ArticleRepositoryImpl>(),
      ),
    );

    // Blocs
    sl.registerFactory<RemoteArticleBloc>(
      () => RemoteArticleBloc(
        sl<GetArticlesUseCase>(),
      ),
    );
  }
}

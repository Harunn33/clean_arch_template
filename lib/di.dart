import 'package:clean_arch_template/features/daily_news/data/data_sources/locale/app_database.dart';
import 'package:clean_arch_template/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:clean_arch_template/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:clean_arch_template/features/daily_news/domain/usecases/delete_article.dart';
import 'package:clean_arch_template/features/daily_news/domain/usecases/get_articles.dart';
import 'package:clean_arch_template/features/daily_news/domain/usecases/get_saved_article.dart';
import 'package:clean_arch_template/features/daily_news/domain/usecases/save_article.dart';
import 'package:clean_arch_template/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:clean_arch_template/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

class DependencyInjection {
  Future<void> init() async {
    // Database
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    sl.registerSingleton<AppDatabase>(database);

    // Dio
    sl.registerSingleton<Dio>(Dio());

    // Dependencies
    sl.registerSingleton<NewsApiService>(NewsApiService(sl<Dio>()));

    sl.registerSingleton<ArticleRepositoryImpl>(
      ArticleRepositoryImpl(
        sl<AppDatabase>(),
        newsApiService: sl<NewsApiService>(),
      ),
    );

    // Use Cases
    sl.registerSingleton<GetArticlesUseCase>(
      GetArticlesUseCase(
        repository: sl<ArticleRepositoryImpl>(),
      ),
    );

    sl.registerSingleton<GetSavedArticleUseCase>(
      GetSavedArticleUseCase(
        repository: sl<ArticleRepositoryImpl>(),
      ),
    );

    sl.registerSingleton<SaveArticleUseCase>(
      SaveArticleUseCase(
        repository: sl<ArticleRepositoryImpl>(),
      ),
    );

    sl.registerSingleton<DeleteArticleUseCase>(
      DeleteArticleUseCase(
        repository: sl<ArticleRepositoryImpl>(),
      ),
    );

    // Blocs
    sl.registerFactory<RemoteArticleBloc>(
      () => RemoteArticleBloc(
        sl<GetArticlesUseCase>(),
      ),
    );

    sl.registerFactory<LocalArticlesBloc>(
      () => LocalArticlesBloc(
        sl<GetSavedArticleUseCase>(),
        sl<SaveArticleUseCase>(),
        sl<DeleteArticleUseCase>(),
      ),
    );
  }
}

import 'package:clean_arch_template/core/constants/api_url.dart';
import 'package:clean_arch_template/core/resources/data_state.dart';
import 'package:clean_arch_template/features/daily_news/data/data_sources/locale/app_database.dart';
import 'package:clean_arch_template/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:clean_arch_template/features/daily_news/data/models/article.dart';
import 'package:clean_arch_template/features/daily_news/domain/entities/article.dart';
import 'package:clean_arch_template/features/daily_news/domain/repository/article_repository.dart';
import 'package:dio/dio.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService newsApiService;
  final AppDatabase _appDatabase;

  ArticleRepositoryImpl(this._appDatabase, {required this.newsApiService});

  @override
  Future<DataState<List<ArticleModel>>> getArticles() async {
    try {
      final resp = await newsApiService.getArticles(
        country: ApiUrl.countryQuery,
        category: ApiUrl.categoryQuery,
        apiKey: ApiUrl.newsAPIKey,
      );

      if (resp.response.statusCode == 200) {
        return DataSuccess(resp.data);
      } else {
        return DataError(
          DioException(
            error: resp.response.statusMessage,
            response: resp.response,
            type: DioExceptionType.badResponse,
            requestOptions: resp.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataError(
        DioException(
          error: e.error,
          response: e.response,
          type: e.type,
          requestOptions: e.requestOptions,
        ),
      );
    }
  }

  @override
  Future<void> deleteArticle(ArticleEntity article) {
    return _appDatabase.articleDao
        .deleteArticle(ArticleModel.fromEntity(article));
  }

  @override
  Future<List<ArticleEntity>> getSavedArticles() {
    return _appDatabase.articleDao.getAllArticles();
  }

  @override
  Future<void> saveArticle(ArticleEntity article) {
    return _appDatabase.articleDao
        .insertArticle(ArticleModel.fromEntity(article));
  }
}

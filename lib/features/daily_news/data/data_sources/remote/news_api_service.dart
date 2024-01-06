import 'package:clean_arch_template/core/constants/api_url.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/article.dart';

part 'news_api_service.g.dart';

@RestApi(baseUrl: ApiUrl.newsApiBaseUrl)
abstract class NewsApiService {
  factory NewsApiService(Dio dio) = _NewsApiService;

  @GET("/top-headlines")
  Future<HttpResponse<List<ArticleModel>>> getArticles({
    @Query("country") String? country,
    @Query("apiKey") String? apiKey,
    @Query("category") String? category,
  });
}

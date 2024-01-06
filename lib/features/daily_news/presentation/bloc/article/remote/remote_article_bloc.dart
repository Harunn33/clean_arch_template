import 'package:clean_arch_template/core/resources/data_state.dart';
import 'package:clean_arch_template/features/daily_news/domain/usecases/get_articles.dart';
import 'package:clean_arch_template/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:clean_arch_template/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteArticleBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {
  final GetArticlesUseCase getArticlesUseCase;

  RemoteArticleBloc(this.getArticlesUseCase) : super(RemoteArticleLoading()) {
    on<GetArticles>(onGetArticles);
  }

  void onGetArticles(
      GetArticles event, Emitter<RemoteArticleState> emit) async {
    final dataState = await getArticlesUseCase.call();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(
        RemoteArticleSuccess(
          dataState.data!,
        ),
      );
    } else if (dataState is DataError) {
      emit(
        RemoteArticleError(
          dataState.error!,
        ),
      );
    } else {
      emit(RemoteArticleLoading());
    }
  }
}

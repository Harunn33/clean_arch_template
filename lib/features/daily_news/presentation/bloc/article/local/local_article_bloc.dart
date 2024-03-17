import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_arch_template/features/daily_news/domain/entities/article.dart';
import 'package:clean_arch_template/features/daily_news/domain/usecases/delete_article.dart';
import 'package:clean_arch_template/features/daily_news/domain/usecases/get_saved_article.dart';
import 'package:clean_arch_template/features/daily_news/domain/usecases/save_article.dart';
import 'package:equatable/equatable.dart';

part 'local_article_event.dart';
part 'local_article_state.dart';

class LocalArticlesBloc extends Bloc<LocalArticlesEvent, LocalArticlesState> {
  final GetSavedArticleUseCase _getSavedArticleUseCase;
  final SaveArticleUseCase _saveArticleUseCase;
  final DeleteArticleUseCase _deleteArticleUseCase;

  LocalArticlesBloc(
    this._getSavedArticleUseCase,
    this._saveArticleUseCase,
    this._deleteArticleUseCase,
  ) : super(const LocalArticlesLoading()) {
    on<GetSavedArticles>(onGetSavedArticles);
    on<SaveArticle>(onSaveArticle);
    on<DeleteArticle>(onDeleteArticle);
  }

  void onGetSavedArticles(
      GetSavedArticles event, Emitter<LocalArticlesState> emit) async {
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticlesLoaded(articles));
  }

  void onSaveArticle(
      SaveArticle saveArticle, Emitter<LocalArticlesState> emit) async {
    await _saveArticleUseCase(params: saveArticle.article);
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticlesLoaded(articles));
  }

  void onDeleteArticle(
      DeleteArticle deleteArticle, Emitter<LocalArticlesState> emit) async {
    await _deleteArticleUseCase(params: deleteArticle.article);
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticlesLoaded(articles));
  }
}

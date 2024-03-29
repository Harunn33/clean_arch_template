part of 'local_article_bloc.dart';

abstract class LocalArticlesState extends Equatable {
  final List<ArticleEntity>? articles;
  const LocalArticlesState(this.articles);

  @override
  List<Object> get props => [articles!];
}

class LocalArticlesLoading extends LocalArticlesState {
  const LocalArticlesLoading() : super(null);
}

class LocalArticlesLoaded extends LocalArticlesState {
  const LocalArticlesLoaded(List<ArticleEntity> super.articles);
}

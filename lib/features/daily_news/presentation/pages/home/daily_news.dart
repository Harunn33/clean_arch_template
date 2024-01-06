import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_arch_template/features/daily_news/data/models/article.dart';
import 'package:clean_arch_template/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:clean_arch_template/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text(
        'Daily News',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
        builder: (context, state) {
      if (state is RemoteArticleLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is RemoteArticleSuccess) {
        return ListView.separated(
          separatorBuilder: (context, _) => const Divider(
            color: Colors.grey,
          ),
          itemCount: state.articles?.length ?? 0,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(state.articles?[index].title ?? ""),
              subtitle: Text(state.articles?[index].description ?? ""),
              minLeadingWidth: 100,
              leading: SizedBox(
                width: 100,
                height: 100,
                child: CachedNetworkImage(
                  imageUrl: state.articles?[index].urlToImage ?? "",
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) {
                    return const Center(
                      child: Text("Resim Yüklenemedi"),
                    );
                  },
                ),
              ),
            );
          },
        );
      } else if (state is RemoteArticleError) {
        return Center(
          child: Text(state.error?.message ?? ""),
        );
      } else {
        return const Center(
          child: Text(
            "Something went wrong!",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        );
      }
    });
  }
}

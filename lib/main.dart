import 'package:clean_arch_template/config/theme/app_theme.dart';
import 'package:clean_arch_template/di.dart';
import 'package:clean_arch_template/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:clean_arch_template/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:clean_arch_template/features/daily_news/presentation/pages/home/daily_news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  await DependencyInjection().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteArticleBloc>(
      create: (context) => sl<RemoteArticleBloc>()
        ..add(
          const GetArticles(),
        ),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: appTheme(),
        debugShowCheckedModeBanner: false,
        home: const DailyNews(),
      ),
    );
  }
}

// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:clean_arch_template/features/daily_news/data/data_sources/locale/dao/article_dao.dart';
import 'package:clean_arch_template/features/daily_news/data/models/article.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'app_database.g.dart';

@Database(version: 1, entities: [ArticleModel])
abstract class AppDatabase extends FloorDatabase {
  ArticleDao get articleDao;
}

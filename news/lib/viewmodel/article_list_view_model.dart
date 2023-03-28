import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:news/models/articles.dart';
import 'package:news/services/news_servise.dart';
import 'package:news/viewmodel/article_view_model.dart';

enum Status { initial, loading, loaded }

class ArticleListViewModel extends ChangeNotifier {
  ArticleViewModel viewModel = ArticleViewModel('technology', []);
  ArticleListViewModel() {
    getNews();
  }
  Status status = Status.initial;
  Future<void> getNews() async {
    status = Status.loading;
    notifyListeners();
    viewModel.articles = await NewsService().fetchNews(viewModel.category);
    status = Status.loaded;
    notifyListeners();
  }
}

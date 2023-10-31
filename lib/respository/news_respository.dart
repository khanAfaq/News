import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news/models/categeries_news_model.dart';

import '../models/news_channels_headlines_model.dart';

class NewsRepository {
  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlineApi(
      String newschannel) async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=$newschannel&apiKey=d1402199ba70473aa4c6865797734cab';
    final response = await http.get(Uri.parse(url));

    // if (kDebugMode) {
    //   print(response.body);
    // }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelsHeadlinesModel.fromJson(body);
    }
    throw Exception('Error occur while fetching data');
  }

  Future<CategeriesNewsModel> fetchCategeriesNewsApi(String category) async {
    String url =
        'https://newsapi.org/v2/everything?q=$category&apiKey=d1402199ba70473aa4c6865797734cab';
    final response = await http.get(Uri.parse(url));

    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategeriesNewsModel.fromJson(body);
    }
    throw Exception('Error occur while fetching data');
  }
}

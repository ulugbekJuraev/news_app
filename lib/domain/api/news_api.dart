import 'package:dart_rss/dart_rss.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

class NewsApi {
//https://uzreport.news/feed/rss/ru

  static Future<RssFeed?> getNews({String lang = 'ru'}) async {
    try {
      final Uri url = Uri.parse('https://uzreport.news/feed/rss/$lang');

      final response = await http.get(url);
      final data = RssFeed.parse(response.body);
      // print(data.title);
      // print(data.items[0].description);
      return data;
    } catch (e) {
      print(e);
    }
  }
}

import 'package:dio/dio.dart';
import 'package:newsapi/models/news_model.dart';

class NewsRepository {
  Future<List<News>> getAllNews(String category) async {
    final url =
        "https://newsapi.org/v2/top-headlines?category=$category&apiKey=ddb0a6120e514e2b9512bfbe572c531d";

    try {
      final response = await Dio().get(url);

      final data = response.data['articles'];

      final List<News> news =
          List.from(data).map((json) => News.fromJson(json)).toList();

      return news;
    } on DioException catch (e) {
      throw "Error d: ${e.toString}";
    } catch (e) {
      throw "Error g:  ${e.toString}";
    }
  }
}

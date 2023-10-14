import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webtoon_clone/models/webtoon_detail_model.dart';
import 'package:webtoon_clone/models/webtoon_episode_model.dart';
import 'package:webtoon_clone/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";

  static const String today = "/today";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonList = [];
    final url = Uri.parse(baseUrl + today);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> webtoonListDy = jsonDecode(response.body);
      for (var webtoon in webtoonListDy) {
        final toon = WebtoonModel.fromJson(webtoon);
        webtoonList.add(toon);
      }
      return webtoonList;
    } else {
      throw Error();
    }
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse("$baseUrl/$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJsin(webtoon);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getlatestEpisodeById(
      String id) async {
    List<WebtoonEpisodeModel> episodeList = [];
    final url = Uri.parse("$baseUrl/$id/episodes");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        episodeList.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return episodeList;
    }
    throw Error();
  }
}

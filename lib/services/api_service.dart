import 'dart:convert';

import 'package:http/http.dart' as http;
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
}

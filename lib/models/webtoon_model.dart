class WebtoonModel {
  final String title, thumb, id;

  WebtoonModel.fromJson(Map<String, dynamic> map)
      : title = map["title"],
        thumb = map["thumb"],
        id = map["id"];
}

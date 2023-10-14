import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webtoon_clone/models/webtoon_episode_model.dart';

class WebtoonEpisode extends StatelessWidget {
  const WebtoonEpisode(
      {super.key, required this.webtoonId, required this.data});

  void onButtonTap(String webtoonId, String episodeId) async {
    await launchUrlString(
        "https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=$episodeId");
  }

  final String webtoonId;
  final WebtoonEpisodeModel data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onButtonTap(webtoonId, data.id);
      },
      child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                )
              ],
            ),
          )),
    );
  }
}

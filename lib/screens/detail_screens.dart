import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webtoon_clone/models/webtoon_detail_model.dart';
import 'package:webtoon_clone/models/webtoon_episode_model.dart';
import 'package:webtoon_clone/services/api_service.dart';
import 'package:webtoon_clone/wedgets/webtoon_episode.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen(
      {super.key, required this.title, required this.thumb, required this.id});

  final String title, thumb, id;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;
  late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    webtoon = ApiService.getToonById(widget.id);
    episodes = ApiService.getlatestEpisodeById(widget.id);
    initPref();
  }

  //
  bool isLike = false;

  Future initPref() async {
    prefs = await SharedPreferences.getInstance();
    final likesToons = prefs.getStringList('likeToons');
    if (likesToons != null) {
      if (likesToons.contains(widget.id) == true) {
        isLike = true;
        setState(() {});
      }
    } else {
      await prefs.setStringList('likeToons', []);
    }
  }

  onHeartTap() async {
    final likesToons = prefs.getStringList('likeToons');
    if (likesToons != null) {
      if (isLike) {
        likesToons.remove(widget.id);
        isLike = false;
      } else {
        likesToons.add(widget.id);
        isLike = true;
      }
      await prefs.setStringList("likeToons", likesToons);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: onHeartTap,
              icon: Icon(
                isLike ? Icons.favorite : Icons.favorite_outline,
              ))
        ],
        title: Center(
          child: Text(widget.title),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Hero(
                      tag: widget.id,
                      child: Container(
                        width: 250,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 5,
                                  offset: const Offset(5, 5),
                                  color: Colors.black.withOpacity(0.7))
                            ]),
                        child: Image.network(
                          widget.thumb,
                          headers: const {
                            "User-Agent":
                                "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            FutureBuilder(
              future: webtoon,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "장르 : ${snapshot.data!.genre} / +${snapshot.data!.age}",
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        snapshot.data!.about,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  );
                }
                return const Text(". . .");
              },
            ),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder(
                future: episodes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        for (int i = 0; i < 10; i++)
                          WebtoonEpisode(
                              webtoonId: widget.id, data: snapshot.data![i])
                      ],
                    );
                  }
                  return Container();
                })
          ]),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:webtoon_clone/models/webtoon_model.dart';
import 'package:webtoon_clone/services/api_service.dart';
import 'package:webtoon_clone/wedgets/webtoon_weget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        title: const Center(
          child: Text("Todays Toons~!"),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(child: makeList(snapshot)),
              ],
            );
          }
          return (const Center(
            child: CircularProgressIndicator(),
          ));
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return Webtoon(
            title: webtoon.title, thumb: webtoon.thumb, id: webtoon.id);
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: 40,
        );
      },
    );
  }
}

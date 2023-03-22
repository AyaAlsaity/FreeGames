import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/game_module.dart';
import '../widgets/game_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GameModel> gameList = [];
  bool suess = false;

  getGame() async {
    // ignore: unused_local_variable
    var response =
        await http.get(Uri.parse('https://www.freetogame.com/api/games'));
    if (kDebugMode) {
      print("STATUS CODE IS :${response.statusCode}");
      print("BODY IS : ${response.body}");
    }
    if (response.statusCode == 200) {
      setState(() {
        suess = true;
        var rawData = json.decode(response.body);
        for (var i in rawData) {
          gameList.add(GameModel.fromJson(i));
        }
      });
    } else {
      setState(() {
        suess = false;
      });
    }
  }

  @override
  void initState() {
    getGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          getGame();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              suess
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: gameList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GameCard(
                          gameList: gameList[index],
                          
                        );
                      },
                    )
                  : SizedBox(
                      height: size.height * 1.01,
                      child: const Center(
                        child: Text('FAILED'),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}

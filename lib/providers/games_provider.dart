import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/games_module.dart';
import '../servies/api.dart';


class GamesProvider with ChangeNotifier {
  bool isLoading = false;
  bool isFailed = false;

  List<GameModel> gamesList = [];

  final _api = Api();

  getGames(String? platformQuery) async {
    isLoading = true;
    
         var response = await _api.get(
     
        platformQuery == null
            ? '/api/games'
            : '/api/games?platform=$platformQuery',
        {});
     

    if (response.statusCode == 200) {
      var rawData = json.decode(response.body);
      setGames(rawData);
    }
  }

  setGames(jsonData) {
    gamesList.clear();
    isLoading = false;

    for (var i in jsonData) {
      gamesList.add(GameModel.fromJson(i));
    }

    notifyListeners();
  }
}
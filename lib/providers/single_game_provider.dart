import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/single_PC_game_module.dart';
import '../model/single_web_game.dart';
import '../servies/api.dart';

class SingleGameProvider with ChangeNotifier {
  bool isLoading = false;
  bool isFailed = false;
   

 SinglePCModule? singlePCGame;
 SingleWebModule? singleWindowsGame;

  final _api = Api();

  getSingleGame(
    int? platformQuery,bool isPC
  ) async {
    isLoading = true;
    var response = await _api.get('/api/game?id=$platformQuery', {});

    if (response.statusCode == 200) {
      var rawData = json.decode(response.body);
      isPC?
      setSinglePCGame(rawData):setSingleWindowsGame(rawData);
    }
  }

  setSinglePCGame(jsonData) {
    isLoading = false;
    singlePCGame = SinglePCModule.fromJson(jsonData);
    notifyListeners();
  }
  setSingleWindowsGame(jsonData) {
    isLoading = false;
    singleWindowsGame = SingleWebModule.fromJson(jsonData);
    notifyListeners();
  }
}

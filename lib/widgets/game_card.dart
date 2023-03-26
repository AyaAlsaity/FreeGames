import 'package:flutter/material.dart';
import 'package:free_games/model/games_module.dart';

// ignore: must_be_immutable
class GameCard extends StatefulWidget {
  GameCard({
    Key? key,
    required this.gameList,
    
  }) : super(key: key);

  GameModel gameList;
  
  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius:  BorderRadius.circular(200),
                child: Image.network(widget.gameList.thumbnail.toString(), width: size.width /9 ,
                  height:  size.width /9 ,fit: BoxFit.cover,),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.gameList.title.toString()),
                Text(widget.gameList.genre.toString()),
              ],
            )
          ],
        ),
       const Divider(
        color:Colors.black26,
        height:1.5,
       )
      ],
    );
  }
}

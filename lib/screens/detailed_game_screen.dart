import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/single_game_provider.dart';
import '../widgets/shimmer_widget.dart';
import '../providers/theme_provider.dart';

class DetailedGameScreen extends StatefulWidget {
  const DetailedGameScreen({
    Key? key,
    required this.gameId,
    required this.isPC,
  }) : super(key: key);
  final int gameId;
  final bool isPC;
  @override
  State<DetailedGameScreen> createState() => _DetailedGameScreenState();
}

class _DetailedGameScreenState extends State<DetailedGameScreen> {
  @override
  void initState() {
    Provider.of<SingleGameProvider>(context, listen: false).getSingleGame(
      widget.gameId,
      widget.isPC,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    // Listening to the theme provider
    final themeListener = Provider.of<ThemeProvider>(context, listen: true);

   
    return Scaffold(
      body: Consumer<SingleGameProvider>(
          builder: (context, singleGameConsumer, _) {
        return SingleChildScrollView(
            child: !singleGameConsumer.isLoading
                ? Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        child: Image.network(
                          // "https://www.freetogame.com/g/452/thumbnail.jpg",
                          widget.isPC
                              ? singleGameConsumer.singlePCGame!.thumbnail
                              : singleGameConsumer.singleWindowsGame!.thumbnail,

                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Container(
                                  color: Colors.white,
                                  // height:100,
                                  // width: 10,
                                  child: const Icon(Icons.image)),
                            );
                          },
                        ),
                      ),
                      //  !singleGameConsumer.isFailed?
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          // "Call Of Duty: Warzone",
                          widget.isPC
                              ? singleGameConsumer.singlePCGame!.title
                              : singleGameConsumer.singleWindowsGame!.title,

                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: themeListener.isDark
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Divider(
                              color: themeListener.isDark
                                  ? Colors.white24
                                  : Colors.black12,
                              height: 2,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              // "A standalone free-to-play battle royale and modes accessible via Call of Duty: Modern Warfare.",
                              widget.isPC
                                  ? singleGameConsumer
                                      .singlePCGame!.shortDescription
                                  : singleGameConsumer
                                      .singleWindowsGame!.shortDescription,
                              style: TextStyle(
                                color: themeListener.isDark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                 Text('Publisher:',style: TextStyle(
                    color: themeListener.isDark ? Colors.white : Colors.black,
                   ),),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  // "Activision",
                                  widget.isPC
                                      ? singleGameConsumer
                                          .singlePCGame!.publisher
                                      : singleGameConsumer
                                          .singleWindowsGame!.publisher,
                                  style: TextStyle(
                                    color: themeListener.isDark
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                 Text('Platform:',style: TextStyle(
                    color: themeListener.isDark ? Colors.white : Colors.black,
                   ),),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  // "Windows",
                                  widget.isPC
                                      ? singleGameConsumer
                                          .singlePCGame!.platform
                                      : singleGameConsumer
                                          .singleWindowsGame!.platform,
                                  style: TextStyle(
                                    color: themeListener.isDark
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Divider(
                              color: themeListener.isDark
                                  ? Colors.white24
                                  : Colors.black12,
                              height: 2,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                 Text('Developer:',style: TextStyle(
                    color: themeListener.isDark ? Colors.white : Colors.black,
                   ),),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  // "Infinity Ward",
                                  widget.isPC
                                      ? singleGameConsumer
                                          .singlePCGame!.developer
                                      : singleGameConsumer
                                          .singleWindowsGame!.developer,
                                  style: TextStyle(
                                    color: themeListener.isDark
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Divider(
                              color: themeListener.isDark
                                  ? Colors.white24
                                  : Colors.black12,
                              height: 2,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:  singleGameConsumer.isLoading
                              ? 3
                              :widget.isPC
                                    ? singleGameConsumer
                                        .singlePCGame!.screenshots.length
                                    : singleGameConsumer.singleWindowsGame!
                                        .screenshots.length,
                            shrinkWrap: true,
                          
                                itemBuilder: (context, index) {
                                  return singleGameConsumer.isLoading
                                ? ShimmerWidget(
                                    width: 500,
                                    height: 500,
                                    radius: 10,
                                    hilighColor: Colors.black12,
                                    baseColor: Colors.white.withOpacity(0.03),
                                  )
                                :
                               ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        widget.isPC
                                            ? singleGameConsumer.singlePCGame!
                                                .screenshots[index].image
                                            : singleGameConsumer
                                                .singleWindowsGame!
                                                .screenshots[index]
                                                .image,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Center(
                                            child: Container(
                                                color: Colors.white,
                                                width: 60,
                                                height: 60,
                                                child:  Icon(
                                                          Icons.image,color:themeListener.isDark ? Colors.white : Colors.black45)),
                                               
                                          );
                                        },
                                      ));
                                },
                            
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8)),
                          ],
                        ),
                      )
                    ],
                  )
                : ShimmerWidget(
                    width: 500,
                    height: 800,
                    radius: 10,
                    hilighColor: Colors.black12,
                    baseColor: Colors.white.withOpacity(0.03),
                  ));
      }),
    );
  }
}

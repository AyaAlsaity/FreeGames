import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/games_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/drawer_menu.dart';
import '../widgets/shimmer_widget.dart';
import 'detailed_game_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? platformQuery;
  int currentIndex = 0;

  @override
  void initState() {
    Provider.of<GamesProvider>(context, listen: false).getGames(platformQuery);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // Listening to the theme provider
    final themeListener = Provider.of<ThemeProvider>(context, listen: true);

    //  Theme provider functions variable
    final themeFunction = Provider.of<ThemeProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.dark_mode,
                color: themeListener.isDark ? Colors.red : Colors.purple),
            onPressed: () {
              themeFunction.switchMode();
            },
          )
        ],
      ),
      drawer: const Drawer(
        child: DrawerMenu(),
      ),
      body: Consumer<GamesProvider>(builder: (context, gamesConsumer, _) {
        return RefreshIndicator(
          onRefresh: () async {
            Provider.of<GamesProvider>(context, listen: false)
                .getGames(platformQuery);
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                !gamesConsumer.isFailed
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: gamesConsumer.isLoading
                                ? 10
                                : gamesConsumer.gamesList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return gamesConsumer.isLoading
                                  ? ShimmerWidget(
                                      width: 500,
                                      height: 500,
                                      radius: 10,
                                      hilighColor: Colors.black12,
                                      baseColor: Colors.white.withOpacity(0.03),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: InkWell(
                                        child: GridTile(
                                            header: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Icon(gamesConsumer
                                                          .gamesList[index]
                                                          .platform
                                                          .contains('PC')
                                                      ? Icons.computer
                                                      : Icons.web)
                                                ],
                                              ),
                                            ),
                                            footer: Container(
                                              color: Colors.white70,
                                              child: Column(
                                                children: [
                                                  Text(gamesConsumer
                                                      .gamesList[index].title),
                                                  Text(gamesConsumer
                                                      .gamesList[index]
                                                      .platform),
                                                ],
                                              ),
                                            ),
                                            child: Image.network(
                                              gamesConsumer
                                                  .gamesList[index].thumbnail,
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
                                            )),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    DetailedGameScreen(
                                                      gameId: gamesConsumer
                                                          .gamesList[index].id,
                                                      isPC: gamesConsumer
                                                                  .gamesList[
                                                                      index]
                                                                  .platform ==
                                                              'PC'
                                                          ? true
                                                          : false,
                                                    )),
                                          );
                                        },
                                      ),
                                    );
                            },
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8)),
                      )
                    : SizedBox(
                        height: size.height * 1.01,
                        child: const Center(child: Text('FAILED'))),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              currentIndex = index;

              currentIndex == 0
                  ? platformQuery = null
                  : currentIndex == 1
                      ? platformQuery = 'pc'
                      : platformQuery = 'browser';
            });

            Provider.of<GamesProvider>(context, listen: false)
                .getGames(platformQuery);
          },
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'All'),
            BottomNavigationBarItem(icon: Icon(Icons.computer), label: 'PC'),
            BottomNavigationBarItem(icon: Icon(Icons.web), label: 'Browser'),
          ]),
    );
  }
}

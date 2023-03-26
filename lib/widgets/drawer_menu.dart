// import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  PageController page = PageController();

  @override
  // void initState() {
  //   sideMenu.addListener((p0) {
  //     page.jumpToPage(p0);
  //   });
  //   super.initState();
  // }

  // SideMenuController sideMenu = SideMenuController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // buildHeader(context),
          buildMenuItems(context),
        ],
      ),
    );
  }
}

Widget buildHeader(BuildContext context) => Container(
      color: Colors.deepPurpleAccent.shade100,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: Column(
        children: const [
          CircleAvatar(
            radius: 52,
            // backgroundImage: AssetImage('assets/Images/files.png'),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            'Aya Alsaity',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
Widget buildMenuItems(BuildContext context) {
  // Listening to the theme provider
  final themeListener = Provider.of<ThemeProvider>(context, listen: true);

  //  Theme provider functions variable
  final themeFunction = Provider.of<ThemeProvider>(context, listen: false);

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
    child: Wrap(
      runSpacing: 16,
      children: [
        ListTile(
          leading: Icon(Icons.perm_identity,
              color: themeListener.isDark ? Colors.white : Colors.black45),
          title: const Text('Profile'),
          onTap: () {},
        ),
        ListTile(
          leading: IconButton(
            icon: Icon(Icons.dark_mode,
                color: themeListener.isDark ? Colors.red : Colors.purple),
            onPressed: () {
              themeFunction.switchMode();
              
            },
          ),
          title: const Text('DarkMode'),
          onTap: () {},
        ),
        Divider(
          color: themeListener.isDark
              ? Colors.white24
              : Colors.black12,
          height: 2,
        ),
        ListTile(
          leading: const Icon(
            Icons.output,
            color: Colors.red,
          ),
          title: const Text('Log out'),
          onTap: () {},
        ),
      ],
    ),
  );
}

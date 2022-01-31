import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:my_messenger/screens/main_screen/widgets/logs_tab.dart';

import './widgets/chats_tab.dart';

class MainScreen extends StatefulWidget {
  static const tag = '/main';

  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: WillPopScope(
        onWillPop: () async {
          if(_currentIndex > 0) {
            return false;
          }
          else{
            return true;
          }
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            backgroundColor: Colors.black,
            elevation: 10.0,
            shadowColor: Colors.white70,
            title: const Text(
              'My Messenger',
              style: TextStyle(fontSize: 25, letterSpacing: 1.0),
            ),
            actions: [
              const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.search_outlined,
                  size: 25,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                  tooltip: 'Refresh',
                  icon: const Icon(
                    Icons.refresh_outlined,
                    size: 25,
                  ),
                  onPressed: () async {},
                ),
              ),
            ],
            bottom: _bottomBar(),
          ),
          body: TabBarView(
            children: [
              ChatsTab(),
              LogsTabs(),
              Center(),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _bottomBar() {
    return TabBar(
      indicatorPadding: const EdgeInsets.only(left: 20.0, right: 20.0),
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white60,
      indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(width: 2.0, color: Colors.lightBlue),
          insets: EdgeInsets.symmetric(horizontal: 15.0)),
      automaticIndicatorColorAdjustment: true,
      labelStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        letterSpacing: 1.0,
      ),
      onTap: (index) {
        print("\nIndex is: $index");
        if (mounted) {
          setState(() {
            _currentIndex = index;
          });
        }
      },
      tabs: const [
        Tab(
          child: Text(
            "Chats",
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Lora',
              fontWeight: FontWeight.w500,
              letterSpacing: 1.0,
            ),
          ),
        ),
        Tab(
          child: Text(
            "Logs",
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Lora',
              fontWeight: FontWeight.w500,
              letterSpacing: 1.0,
            ),
          ),
        ),
        Tab(
          icon: Icon(
            Icons.store,
            size: 25.0,
          ),
        ),
      ],
    );
  }
}

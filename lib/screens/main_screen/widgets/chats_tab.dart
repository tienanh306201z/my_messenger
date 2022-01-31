import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ChatsTab extends StatefulWidget {
  const ChatsTab({Key? key}) : super(key: key);

  @override
  _ChatsTabState createState() => _ChatsTabState();
}

class _ChatsTabState extends State<ChatsTab> {
  bool _isLoading = false;

  final List<String> _allUserConnectionActivity = ['Generation', 'Tran Tien Anh',];
  final List<String> _allConnectionsUserName = ['Tran Tien Anh', 'Tran Anh Bao'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: LoaderOverlay(
          overlayColor: const Color.fromRGBO(0, 0, 0, 0.5),
          overlayWidget: const CircularProgressIndicator(
            backgroundColor: Colors.black87,
          ),
          useDefaultLoading: _isLoading,
          child: ListView(
            children: [
              _activityList(context),
              _connectionList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _activityList(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 20.0,
        left: 10.0,
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).orientation == Orientation.portrait
          ? MediaQuery.of(context).size.height * (1.5 / 8)
          : MediaQuery.of(context).size.height * (3 / 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Make ListView Horizontally
        itemCount: _allUserConnectionActivity.length,
        itemBuilder: (context, position) {
          return _activityCollectionList(context, position);
        },
      ),
    );
  }

  Widget _activityCollectionList(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.only(right: MediaQuery.of(context).size.width / 18),
      padding: const EdgeInsets.only(top: 3.0),
      height: MediaQuery.of(context).size.height * (1.5 / 8),
      child: Column(
        children: [
          Stack(
            children: [
              if (_allUserConnectionActivity[index]
                  .contains('[[[new_activity]]]'))
                SizedBox(
                  height:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? (MediaQuery.of(context).size.height *
                                  (1.2 / 7.95) /
                                  2.5) *
                              2
                          : (MediaQuery.of(context).size.height *
                                  (2.5 / 7.95) /
                                  2.5) *
                              2,
                  width:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? (MediaQuery.of(context).size.height *
                                  (1.2 / 7.95) /
                                  2.5) *
                              2
                          : (MediaQuery.of(context).size.height *
                                  (2.5 / 7.95) /
                                  2.5) *
                              2,
                  child: const CircularProgressIndicator(
                    color: Colors.blue,
                    value: 1.0,
                  ),
                ),
              OpenContainer(
                closedColor: const Color.fromRGBO(34, 48, 60, 1),
                openColor: const Color.fromRGBO(34, 48, 60, 1),
                middleColor: const Color.fromRGBO(34, 48, 60, 1),
                closedElevation: 0.0,
                closedShape: const CircleBorder(),
                transitionDuration: const Duration(
                  milliseconds: 500,
                ),
                transitionType: ContainerTransitionType.fadeThrough,
                openBuilder: (context, openWidget) {
                  return const Center();
                },
                closedBuilder: (context, closeWidget) {
                  return CircleAvatar(
                    backgroundColor: Colors.black,
                    backgroundImage:
                        const AssetImage('assets/images/google.png'),
                    radius: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? MediaQuery.of(context).size.height * (1.2 / 8) / 2.5
                        : MediaQuery.of(context).size.height * (2.5 / 8) / 2.5,
                  );
                },
              ),
              index == 0 // This is for current user Account
                  ? Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? MediaQuery.of(context).size.height * (0.7 / 8) -
                                10
                            : MediaQuery.of(context).size.height * (1.5 / 8) -
                                10,
                        left: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? MediaQuery.of(context).size.width / 3 - 65
                            : MediaQuery.of(context).size.width / 8 - 15,
                      ),
                      child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.lightBlue,
                          ),
                          child: GestureDetector(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? MediaQuery.of(context).size.height *
                                      (1.3 / 8) /
                                      2.5 *
                                      (3.5 / 6)
                                  : MediaQuery.of(context).size.height *
                                      (1.3 / 8) /
                                      2,
                            ),
                          )),
                    )
                  : const SizedBox(),
            ],
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(
              top: 7.0,
            ),
            child: Text(
              _allUserConnectionActivity[index],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _connectionList(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: _isLoading,
      child: Container(
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).orientation == Orientation.portrait
                ? 5.0
                : 0.0),
        padding: const EdgeInsets.only(top: 18.0, bottom: 30.0),
        height: MediaQuery.of(context).size.height * (5.15 / 8),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(31, 51, 71, 1),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              spreadRadius: 0.0,
              offset: Offset(0.0, -5.0), // shadow direction: bottom right
            )
          ],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
          border: Border.all(
            color: Colors.black26,
            width: 1.0,
          ),
        ),
        child: ReorderableListView.builder(
          onReorder: (first, last) {},
          itemCount: _allConnectionsUserName.length,
          itemBuilder: (context, position) {
            return chatTileContainer(
                context, position, _allConnectionsUserName[position]);
          },
        ),
      ),
    );
  }

  Widget chatTileContainer(BuildContext context, int index, String _userName) {
    return Card(
        key: Key('$index'),
        elevation: 0.0,
        color: const Color.fromRGBO(31, 51, 71, 1),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0.0,
            primary: const Color.fromRGBO(31, 51, 71, 1),
            onPrimary: Colors.lightBlueAccent,
          ),
          onPressed: () {
            print("Chat List Pressed");
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 5.0,
                  bottom: 5.0,
                ),
                child: OpenContainer(
                  closedColor: const Color.fromRGBO(31, 51, 71, 1),
                  openColor: const Color.fromRGBO(31, 51, 71, 1),
                  middleColor: const Color.fromRGBO(31, 51, 71, 1),
                  closedShape: const CircleBorder(),
                  closedElevation: 0.0,
                  transitionDuration: const Duration(milliseconds: 500),
                  transitionType: ContainerTransitionType.fadeThrough,
                  openBuilder: (_, __) {
                    return const Center();
                  },
                  closedBuilder: (_, __) {
                    return const CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Color.fromRGBO(31, 51, 71, 1),
                      backgroundImage:
                          ExactAssetImage('assets/images/google.png'),
                      //getProperImageProviderForConnectionsCollection(
                      //    _userName),
                    );
                  },
                ),
              ),
              OpenContainer(
                closedColor: const Color.fromRGBO(31, 51, 71, 1),
                openColor: const Color.fromRGBO(31, 51, 71, 1),
                middleColor: const Color.fromRGBO(31, 51, 71, 1),
                closedElevation: 0.0,
                openElevation: 0.0,
                transitionDuration: const Duration(milliseconds: 500),
                transitionType: ContainerTransitionType.fadeThrough,
                openBuilder: (context, openWidget) {
                  return const Center();
                },
                closedBuilder: (context, closeWidget) {
                  return Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 2 + 30,
                    padding: const EdgeInsets.only(
                      top: 5.0,
                      bottom: 5.0,
                      left: 5.0,
                    ),
                    child: Column(
                      children: [
                        Text(
                          _userName.length <= 18
                              ? _userName
                              : _userName.replaceRange(
                                  18, _userName.length, '...'),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),

                        /// For Extract latest Conversation Message
//                          _latestDataForConnectionExtractPerfectly(_userName)
                        const Text(
                          'Hello Sam',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                    top: 2.0,
                    bottom: 2.0,
                  ),
                  child: Column(
                    children: const [
                      Text('12:00'),
                      SizedBox(
                        height: 10.0,
                      ),
                      Icon(
                        Icons.notifications_active_outlined,
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

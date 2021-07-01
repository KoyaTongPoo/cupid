import 'package:flutter/material.dart';

class NestedTabBar extends StatefulWidget {
  @override
  _NestedTabBarState createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  TabController? _nestedTabController;

  @override
  void initState() {
    super.initState();

    _nestedTabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        // Center(child: Text('わーーい！！'),),
        TabBar(
          controller: _nestedTabController,
          indicatorColor: Colors.teal,
          // indicatorPadding: EdgeInsets.all(10),
          labelColor: Colors.teal,
          labelPadding: EdgeInsets.symmetric(horizontal: screenWidth / 10),
          unselectedLabelColor: Colors.black54,
          isScrollable: true,
          tabs: const <Widget>[
            Tab(
              icon: Icon(Icons.alternate_email, size: 40.0),
            ),
            Tab(
              icon: Icon(Icons.account_circle_outlined, size: 40.0),
            ),
            Tab(
              icon: Icon(Icons.chat_outlined, size: 40.0),
            ),
          ],
        ),
        Container(
          // color: Colors.black,
          // alignment: MainAxisAlignment.spaceAround,
          height: screenHeight * 0.50,
          margin: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: TabBarView(
            controller: _nestedTabController,
            children: <Widget>[
              Opacity(
                opacity: 0.5,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.orangeAccent.shade100,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.greenAccent,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

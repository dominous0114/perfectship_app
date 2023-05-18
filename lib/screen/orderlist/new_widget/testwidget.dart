import 'package:flutter/material.dart';

class SwitchableAppBar extends StatefulWidget {
  final String title1;
  final String title2;

  const SwitchableAppBar({Key? key, required this.title1, required this.title2}) : super(key: key);

  @override
  _SwitchableAppBarState createState() => _SwitchableAppBarState();
}

class _SwitchableAppBarState extends State<SwitchableAppBar> {
  bool _showFirstAppBar = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // AnimatedSwitcher(
          //   duration: Duration(milliseconds: 300),
          //   transitionBuilder: (Widget child, Animation<double> animation) {
          //     return SlideTransition(
          //       position: Tween<Offset>(
          //         begin: Offset(0.0, -1.0),
          //         end: Offset.zero,
          //       ).animate(animation),
          //       child: child,
          //     );
          //   },
          //   child: _showFirstAppBar ? buildAppBar1() : buildAppBar2(),
          // ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
              childCount: 50,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _showFirstAppBar = !_showFirstAppBar;
          });
        },
        child: Icon(Icons.swap_vert),
      ),
    );
  }

  Widget buildAppBar1() {
    return SliverAppBar(
      key: UniqueKey(), // Use UniqueKey for the first app bar
      title: Text(widget.title1),
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget buildAppBar2() {
    return SliverAppBar(
      key: UniqueKey(), // Use UniqueKey for the second app bar
      title: Text(widget.title2),
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: Colors.red,
        ),
      ),
    );
  }
}

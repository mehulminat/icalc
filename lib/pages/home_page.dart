import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:icalc/models/button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String result = "14555";
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]); //enable fullscreen
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onHorizontalDragEnd: (details) => {_dragToDelete()},
              child: Text(
                result,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: result.length > 5 ? 60 : 80,
                    fontWeight: FontWeight.w200),
              ),
            ),
            SizedBox(height: 15),
            Container(
              height: MediaQuery.of(context).size.height * 0.69,
              child: _buildButtonGrid(),
            )
          ],
        ),
      ),
    );
  }

  _dragToDelete() {
    print("digit deleted");
  }

  Widget _buildButtonGrid() {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      padding: EdgeInsets.zero,
      itemCount: buttons.length,
      itemBuilder: (context, index) {
        final button = buttons[index];
        return MaterialButton(
            onPressed: () {},
            padding: button.value == '0'
                ? EdgeInsets.only(right: 100)
                : EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(60))),
            color: button.bgColor,
            child: Text(
              button.value,
              style: TextStyle(color: button.fgColor, fontSize: 30),
            ));
      },
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      staggeredTileBuilder: (index) =>
          StaggeredTile.count(buttons[index].value == '0' ? 2 : 1, 1),
    );
  }
}

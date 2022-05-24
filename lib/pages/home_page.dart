import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String result = "14555";
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
                    fontSize: result.length > 5 ? 60 : 100,
                    fontWeight: FontWeight.w200),
              ),
            ),
            SizedBox(height: 15),
            Container(
              color: Colors.orange..shade800,
              height: MediaQuery.of(context).size.height * 0.6,
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
      itemCount: 15,
      itemBuilder: (context, index) {
        return MaterialButton(
          onPressed: () {},
          child: Text("$index"),
        );
      },
      staggeredTileBuilder: (index) => StaggeredTile.count(1, 1),
    );
  }
}

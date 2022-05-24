import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:icalc/models/button.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String result = "";
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
                _formatresult(result),
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

  void _dragToDelete() {
    setState(() {
      if (result.length > 1) {
        result = result.substring(0, result.length - 1);
        currentNumber = result;
      } else {
        result = '0';
        currentNumber = '';
      }
    });
  }

  String previousNumber = '';
  String currentNumber = '';
  String selectedOperation = '';
  void _onButtonPressed(String buttontext) {
    setState(() {
      switch (buttontext) {
        case '÷':
        case '+':
        case '-':
        case 'X':
          if (previousNumber != '') {
            _calculateResult();
          } else {
            previousNumber = currentNumber;
          }
          currentNumber = '';
          selectedOperation = buttontext;
          break;
        case '+/-':
          currentNumber = stringToDouble(currentNumber) < 0
              ? currentNumber.replaceAll('-', '')
              : '-$currentNumber';
          result = currentNumber;
          break;
        case '%':
          currentNumber = (stringToDouble(currentNumber) / 100).toString();
          result = currentNumber;
          break;
        case '=':
          _calculateResult();
          previousNumber = '';
          selectedOperation = '';
          break;
        case 'C':
          _resetcalc();
          break;
        default:
          currentNumber = currentNumber + buttontext;
          result = currentNumber;
      }
    });
  }

  double stringToDouble(String number) {
    return double.tryParse(number) ?? 0;
  }

  String _formatresult(String number) {
    var formatter = NumberFormat("###,###.##", "en-US");
    return formatter.format(stringToDouble(number));
  }

  Widget _buildButtonGrid() {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      padding: EdgeInsets.zero,
      itemCount: buttons.length,
      itemBuilder: (context, index) {
        final button = buttons[index];
        return MaterialButton(
            onPressed: () {
              _onButtonPressed(button.value);
            },
            padding: button.value == '0'
                ? EdgeInsets.only(right: 100)
                : EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(60))),
            color: (button.value == selectedOperation && currentNumber == '')
                ? Colors.white
                : button.bgColor,
            child: Text(
              button.value,
              style: TextStyle(
                  color:
                      (button.value == selectedOperation && currentNumber == '')
                          ? button.bgColor
                          : button.fgColor,
                  fontSize: 30),
            ));
      },
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      staggeredTileBuilder: (index) =>
          StaggeredTile.count(buttons[index].value == '0' ? 2 : 1, 1),
    );
  }

  void _calculateResult() {
    double _prevNumber = stringToDouble(previousNumber);
    double _currNumber = stringToDouble(currentNumber);
    switch (selectedOperation) {
      case '+':
        _prevNumber = _prevNumber + _currNumber;
        break;
      case 'X':
        _prevNumber = _prevNumber * _currNumber;
        break;
      case '-':
        _prevNumber = _prevNumber - _currNumber;
        break;
      case '÷':
        _prevNumber = _prevNumber / _currNumber;
        break;
        defaut:
        break;
    }

    currentNumber =
        (_prevNumber % 1 == 0 ? _prevNumber.toInt() : _prevNumber).toString();
    result = currentNumber;
  }

  void _resetcalc() {
    result = '0';
    previousNumber = currentNumber = '';
  }
}

import 'package:flutter/material.dart';
import 'package:dailyhabit/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetStarted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Container(
          // width: 300,
          // height: 700,
          padding: EdgeInsets.all(50),
          child: Column(
            children: <Widget>[
              _header(),
              Expanded(child: _content(context)),
              _button(context),
            ],
          )),
    );
  }

  Widget _header() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: double.infinity,
      child: Text(
        'DAILYHABIT',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _content(BuildContext context) {
    List<String> lists = const [
      "Helping you achieve life resolution",
      "Set the type of activity, with the reminder feature",
      "Get a summary of the data during your DailyHabit journey"
    ];

    List<Widget> listWidget = _createListWidget(context, lists);

    return (SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: listWidget,
        ),
      ),
    ));
  }

  Widget _button(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: Size(300, 0),
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).primaryColor,
        disabledBackgroundColor: Colors.grey,
        disabledForegroundColor: Colors.black,
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      onPressed: () {
        Future<SharedPreferences> prefsFuture = SharedPreferences.getInstance();
        prefsFuture.then((prefs) {
          prefs.setBool('isStarted', true);
        });
        Navigator.of(context).pushReplacementNamed(Routes.home);
      },
      child: Text(
        "Start",
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }

  // Create List Widget from List<String>
  List<Widget> _createListWidget(BuildContext context, List<String> items) {
    TextStyle textStyle =
        TextStyle(fontSize: 22, color: Colors.white, height: 1.5);
    TextStyle numberStyle =
        TextStyle(fontSize: 18, color: Theme.of(context).primaryColor);
    List<Widget> result = [];

    var number = 1;
    items.forEach((text) {
      result.add(Container(
          margin: EdgeInsets.only(bottom: 50),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 35,
                height: 35,
                margin: EdgeInsets.only(right: 20, top: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(const Radius.circular(50)),
                ),
                child: Center(
                  child: Text(
                    number.toString(),
                    style: numberStyle,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  text,
                  style: textStyle,
                ),
              ),
            ],
          )));
      number++;
    });

    return result;
  }
}

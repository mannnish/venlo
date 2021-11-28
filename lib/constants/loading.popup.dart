import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingPopupGenerator {
  static def({@required text, @required context}) {
    showCupertinoDialog(
      context: context,
      builder: (_) => LoadingPopup(text: text),
    );
  }
}

class LoadingPopup extends StatefulWidget {
  final String text;
  LoadingPopup({@required this.text});
  @override
  _LoadingPopupState createState() => _LoadingPopupState();
}

class _LoadingPopupState extends State<LoadingPopup> {
  @override
  Widget build(BuildContext context) {
    var clipRRect = ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Material(
        child: Container(
          padding: EdgeInsets.all(30),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${widget.text}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                child: LinearProgressIndicator(backgroundColor: Colors.grey),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
    return Column(
      children: <Widget>[
        Spacer(),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          child: clipRRect,
        ),
        Spacer(),
      ],
    );
  }
}

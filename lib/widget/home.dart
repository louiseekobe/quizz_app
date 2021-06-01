import 'package:flutter/material.dart';
import 'package:quizz_app/widget/quizz_page.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Card(
              elevation: 4.0,
              child: new Container(
                height: MediaQuery.of(context).size.height * 0.39,
                width: MediaQuery.of(context).size.width*0.65,
                child: new Image.asset('img/quizz.jpg', fit: BoxFit.contain)
              ),
            ),
            new RaisedButton(onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                return new QuizzPage();
              }));
            },
            child: new Text('DEMARREZ QUIZZ'),
            color: Colors.lightGreen,)
          ],
        ),
      ),
    );
  }
}
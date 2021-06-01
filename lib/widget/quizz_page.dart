import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:quizz_app/widget/test_util.dart';
import 'package:quizz_app/widget/question.dart';



class QuizzPage extends StatefulWidget{
  @override
  _QuizzPage createState() => new _QuizzPage();
}

class _QuizzPage extends State<QuizzPage>{

  Question question;
  List<Question> listeQuestion = [
    new Question('Paris est-elle la capitale de la france', true, 'bla bla bla ', 'paris.jpg'),
    new Question('Les BCAA sont des acides aminées essentiels en Musculation ?' ,true, 'bla bla bla','bcaa.jpg'),
    new Question('Limoges est la plus grande ville du monde ?', false, 'bla bla bla', 'limoges.jpg'),
    new Question('La lune est une planèete ?',  false,  'bla bla bla', 'lune.jpg'),
    new Question('Twitter est le réseau social le plus utilisé ? ', false , 'bla bla bla', 'twitter.jpg'),
    new Question('Flutter est un langage de programmation ? ', false, 'bla bla bla', 'flutter.jpg'),
    new Question('Minecraft est un jeu vidéo ? ', true, 'bla bla bla', 'minecraft.jpg'),
    new Question('Lucifer est une serie original Netflix ? ', true, 'bla bla bla', 'lucifer.jpg'),
    new Question('Louis XVI s est suicidé ?', false, 'bla bla bla', 'louisxvi.jpg'),
    new Question('Les prochains JO seront à Paris ?', true , 'bla bla bla', 'jo.jpg')
  ];

  int indexes = 0;
  int score = 0;

  //methode qui initialise le Scaffold de notre application
  @override
  void initState() {
    super.initState();
    question = listeQuestion[indexes];
  }


  @override
  Widget build(BuildContext context) {
    //on calcule la taille de notre Scaffold
    double size = MediaQuery.of(context).size.width *0.5;
    return new Scaffold(
      appBar: new AppBar(
        title: new TestUtil('QUIZZ : PARTIE'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new TestUtil('Question : ${indexes+1}', color: Colors.green, textScaleFactor: 0.9,),
            new TestUtil('Score : $score/${indexes+1}', color: Colors.pink, textScaleFactor: 0.9),
            new Card(
              elevation: 0.3,
              child: new Container(
                height: size,
                width: size,
                child: new Image.asset('img/'+question.imagePath),
              ),
            ),
            new TestUtil(question.question, color: Colors.black, textScaleFactor: 1.3),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                boutonBool(true),
                boutonBool(false),
              ],
            )
          ],
        ),
      ),
    );
  }

  RaisedButton boutonBool(bool b){
    return new RaisedButton(
        elevation: 8.0,
        color: Colors.green,
        onPressed: ()=> dialog(b),
        child: new TestUtil(b? 'VRAI': 'FAUX', textScaleFactor: 0.8),
    );
  }


  Future<Null> dialog(bool b) async{
    //permet de verifier si la reponse tapée est soit vrai soit fausse
    bool bonneResp = (b == question.reponse);
    String vrai = 'img/true.png';
    String faux = 'img/false.png';
    if(bonneResp){
      setState(() {
        score++;
      });

    }
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return new SimpleDialog(
            title: new TestUtil(bonneResp? 'Bravo': 'Dommage', color: bonneResp? Colors.black: Colors.red ,textScaleFactor: 1.4),
            contentPadding: EdgeInsets.all(5.0),
            children: <Widget>[
              new Image.asset(bonneResp? vrai: faux, fit: BoxFit.cover),
              new Container(height: 20.0,),
              new TestUtil(question.explication, color: Colors.black,textScaleFactor: 1.0,),
              new Container(height: 20.0,),
              new RaisedButton(
                  onPressed: (){
                    Navigator.pop(context);
                    getNextQuestion();
                  },
                color: Colors.lightGreenAccent,
                child: new TestUtil('Question suivante', textScaleFactor: 1.2),
                  ),
            ],
          );
        }
    );
  }

  Future<Null> alerte () async{
      return showDialog(
          context: context,
        barrierDismissible: false,
        builder: (BuildContext builcontext){
            return AlertDialog(
              title: new TestUtil('FIN DU QUIZZ', color: Colors.black54,textScaleFactor: 1.3),
              contentPadding: EdgeInsets.all(10.0),
              content: new TestUtil('Votre score est de $score/${indexes+1}', color: Colors.purple,),
              actions: <Widget>[
                new FlatButton(
                    onPressed: (){
                      Navigator.pop(builcontext);
                      Navigator.pop(context);
                    },
                    child: new TestUtil('Partie terminée',color: Colors.purple,textScaleFactor: 1.2)
                )
              ],
            );
        }
      );
  }

  void getNextQuestion(){
    if(indexes < listeQuestion.length - 1){
      setState(() {
        indexes++;
        question = listeQuestion[indexes];
      });
    }else{
      alerte();
    }
  }
}
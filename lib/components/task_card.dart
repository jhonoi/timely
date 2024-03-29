import 'package:flutter/material.dart';
import 'package:timely/task.dart';
import 'package:timely/screens/task_screen.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskCard extends StatefulWidget {
  final Color color;
  final Task task;

  TaskCard(
      {@required this.color, @required this.task});
  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
    @override
  Widget build(BuildContext context) {
    FirebaseAdMob.instance.initialize(appId: "ca-app-pub-1917637202355156~6665380853");
    InterstitialAd myInterstitial = InterstitialAd(
      adUnitId: "ca-app-pub-1917637202355156/6578245781",
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
      },
    );
    return Card(
      color: widget.task.isRunning ? widget.color : Colors.white,
      child: InkWell(
        highlightColor: widget.color,
        splashColor: widget.color,
        onTap: () async {
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return TaskScreen(task: widget.task);
          }));
          SharedPreferences prefs = await SharedPreferences.getInstance();
          int numOfAds = prefs.getInt('numOfAds') ?? 0;
          print(numOfAds);
          if(numOfAds == 3){
            myInterstitial
              ..load()
              ..show();
            numOfAds = 0;
          }else{
            numOfAds++;
          }
          prefs.setInt(('numOfAds'), numOfAds);
        },
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.task.taskName,
                style: TextStyle(
                  color: widget.task.isRunning ? Colors.white : widget.color,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500
                ),
              ),
              IconButton(
                iconSize: 30.0,
                icon: widget.task.isRunning ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                color: widget.task.isRunning ? Colors.white : widget.color,
                onPressed: (){
                  setState(() {
                    if(widget.task.isRunning){
                      widget.task.cancelTimer(DateTime.now());
                    }else{
                      widget.task.startTimer(DateTime.now());
                    }
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

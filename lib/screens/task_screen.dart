import 'package:flutter/material.dart';
import 'package:timely/constants.dart';
import 'package:timely/task.dart';
import 'package:timely/task_storage.dart';

class TaskScreen extends StatelessWidget {
  final Task task;

  TaskScreen({@required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Timely',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SizedBox(),
              flex: 1,
            ),
            Expanded(
              flex: 11,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            task.taskName,
                            style: headerTextStyle.copyWith(fontSize: 25),
                          ),
                          Text(
                            'Check your stats!',
                            style: infoTextStyle,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        margin: EdgeInsets.only(top: 10.0),
                        decoration: BoxDecoration(
                          color: task.color,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          children: <Widget>[
                            TimeStatRow(text: 'Today', hours: (task.timeSpentToday/60).floor(), minutes: (task.timeSpentToday%60).round()),
                            Container(
                                height: 1.0,
                                color: darkerColors[task.color],
                                margin: EdgeInsets.symmetric(horizontal: 20.0)),
                            TimeStatRow(
                                text: 'This Week', hours: (task.timeSpentWeek/60).floor(), minutes: (task.timeSpentWeek%60).round()),
                            Container(
                                height: 1.0,
                                color: darkerColors[task.color],
                                margin: EdgeInsets.symmetric(horizontal: 20.0)),
                            TimeStatRow(
                                text: 'This Month', hours: (task.timeSpentMonth/60).floor(), minutes: (task.timeSpentMonth%60).round()),
                            Container(
                                height: 1.0,
                                color: darkerColors[task.color],
                                margin: EdgeInsets.symmetric(horizontal: 20.0)),
                            TimeStatRow(
                                text: 'Lifetime', hours: (task.timeSpentYear/60).floor(), minutes: (task.timeSpentYear%60).round()),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SizedBox(),
              flex: 1,
            ),
            Expanded(
              flex: 11,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Actions',
                      style: headerTextStyle.copyWith(fontSize: 24.0),
                    ),
                    Expanded(child: SizedBox()),
                    ActionButton(
                      label: task.isRunning ? 'DEACTIVATE TASK' : 'ACTIVATE TASK',
                      icon: Icons.power_settings_new,
                      color: Color(0xFF82FCC1),
                      onPressed: (){
                        if(task.isRunning){
                          task.isRunning = false;
                          task.cancelTimer();
                        }else{
                          task.isRunning = true;
                          task.startTimer();
                        }
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(child: SizedBox()),
                    ActionButton(
                      label: 'EDIT TASK',
                      icon: Icons.edit,
                      color: Color(0xFF83B4FF),
                      onPressed: (){
                        Navigator.pushNamed(context, '/taskCreator');
                      },
                    ),
                    Expanded(child: SizedBox()),
                    ActionButton(
                      label: 'REMOVE TASK',
                      icon: Icons.delete,
                      color: Color(0xFFFF8383),
                      onPressed: (){
                        if(task.isRunning){
                          task.isRunning = false;
                          task.cancelTimer();
                        }
                        taskArray.removeAt(taskArray.indexOf(task));
                        numOfTasks--;
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  String label;
  IconData icon;
  Function onPressed;
  Color color;

  ActionButton(
      {@required this.label,
        @required this.icon,
        @required this.onPressed,
        @required this.color,
      });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        splashColor: color,
        color: Colors.white,
        onPressed: onPressed,
        child: Row(
          children: <Widget>[
            SizedBox(width: 10.0),
            Icon(
              icon,
              color: color,
            ),
            SizedBox(width: 15.0),
            Text(
              label,
              style: generalTextStyle.copyWith(color: color, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}

class TimeStatRow extends StatelessWidget {
  final String text;
  final int hours;
  final int minutes;

  TimeStatRow(
      {@required this.text, @required this.hours, @required this.minutes});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    text,
                    style: generalTextStyle.copyWith(fontSize: 21.0),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Text(
                    hours < 1 ? '$minutes mins' : '$hours hrs $minutes mins',
                    textAlign: TextAlign.end,
                    style:
                        generalTextStyle.copyWith(fontWeight: FontWeight.w400, fontSize: 21.0),
                  ),
                ),
                Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

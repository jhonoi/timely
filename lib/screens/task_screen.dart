import 'package:flutter/material.dart';
import 'package:timely/constants.dart';
import 'package:timely/task.dart';
import 'package:timely/task_storage.dart';

class TaskScreen extends StatelessWidget {
  final Task task;

  TaskScreen({@required this.task});

  int calcMonth(){
    int timeSpentMonth = 0;
    for(int i = 0; i < task.timeValuesList[DateTime.now().month - 1].length; i++){
      timeSpentMonth += task.timeValuesList[DateTime.now().month - 1][i];
    }

    return timeSpentMonth;
  }

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
                            TimeStatRow(text: 'Today', hours: task.isRunning ? (task.showTime(DateTime.now())/60).floor() : (task.timeValuesList[DateTime.now().month - 1][DateTime.now().day - 1]/60).floor(), minutes: task.isRunning ? (task.showTime(DateTime.now())%60).round() : (task.timeValuesList[DateTime.now().month - 1][DateTime.now().day - 1]%60).round()),
                            Container(
                                height: 1.0,
                                color: darkerColors[task.color],
                                margin: EdgeInsets.symmetric(horizontal: 20.0)),
                            /*
                            If its the first day of January just put yesterday's value to 0 else
                            if its the first day of any other month set yesterday's value to the last day of the previous month else
                            just set yesterday's value to the previous index (yesterday)
                            */
                            TimeStatRow(
                                text: 'Yesterday', hours: DateTime.now().day == 1 && DateTime.now().month == 1 ? 0 :
                                            DateTime.now().day == 1 && DateTime.now().month != 1 ? (task.timeValuesList[DateTime.now().month - 2][task.timeValuesList[DateTime.now().month - 2].length - 1]/60).floor() : (task.timeValuesList[DateTime.now().month - 1][DateTime.now().day - 2]/60).floor(),
                                minutes: DateTime.now().day == 1 && DateTime.now().month == 1 ? 0 :
                                DateTime.now().day == 1 && DateTime.now().month != 1 ? (task.timeValuesList[DateTime.now().month - 2][task.timeValuesList[DateTime.now().month - 2].length - 1]%60).round() : (task.timeValuesList[DateTime.now().month - 1][DateTime.now().day - 2]%60).round()),
                            Container(
                                height: 1.0,
                                color: darkerColors[task.color],
                                margin: EdgeInsets.symmetric(horizontal: 20.0)),
                            TimeStatRow(
                                text: 'This Month', hours: task.isRunning ? ((calcMonth() + DateTime.now().difference(task.timeStarted).inMinutes)/60).floor() : (calcMonth()/60).floor(), minutes: task.isRunning ? ((calcMonth() + DateTime.now().difference(task.timeStarted).inMinutes)%60).round() : (calcMonth()%60).round()),
                            Container(
                                height: 1.0,
                                color: darkerColors[task.color],
                                margin: EdgeInsets.symmetric(horizontal: 20.0)),
                            TimeStatRow(
                                text: 'Lifetime', hours: task.isRunning ? ((task.timeSpentLifetime + DateTime.now().difference(task.timeStarted).inMinutes)/60).floor() : (task.timeSpentLifetime/60).floor(), minutes: task.isRunning ? ((task.timeSpentLifetime + DateTime.now().difference(task.timeStarted).inMinutes)%60).round() : (task.timeSpentLifetime%60).round()),
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
                          task.cancelTimer(DateTime.now());
                        }else{
                          task.startTimer(DateTime.now());
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
                          task.cancelTimer(DateTime.now());
                        }
                        taskArray.removeAt(taskArray.indexOf(task));
                        numOfTasks--;
                        task.saveList(taskArray, numOfTasks);
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

//class TimeStatRow extends StatefulWidget {
//  final String text;
//
//  TimeStatRow({@required this.text});
//
//  @override
//  _TimeStatRowState createState() => _TimeStatRowState();
//}
//
//
//class _TimeStatRowState extends State<TimeStatRow> {
//  int hours, minutes;
//
//  @override
//  Widget build(BuildContext context) {
//    return Expanded(
//      child: Row(
//        children: <Widget>[
//          Expanded(
//            child: Row(
//              children: <Widget>[
//                Expanded(
//                  child: SizedBox(),
//                ),
//                Expanded(
//                  flex: 4,
//                  child: Text(
//                    widget.text,
//                    style: generalTextStyle.copyWith(fontSize: 21.0),
//                  ),
//                ),
//              ],
//            ),
//          ),
//          Expanded(
//            child: Row(
//              children: <Widget>[
//                Expanded(
//                  flex: 4,
//                  child: Text(
//                    hours < 1 ? '$minutes mins' : '$hours hrs $minutes mins',
//                    textAlign: TextAlign.end,
//                    style:
//                    generalTextStyle.copyWith(fontWeight: FontWeight.w400, fontSize: 21.0),
//                  ),
//                ),
//                Expanded(
//                  child: SizedBox(),
//                ),
//              ],
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}

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

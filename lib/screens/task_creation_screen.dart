import 'package:flutter/material.dart';
import 'package:timely/constants.dart';
import 'package:timely/task.dart';

class TaskCreationScreen extends StatefulWidget {
  @override
  _TaskCreationScreenState createState() => _TaskCreationScreenState();
}

class _TaskCreationScreenState extends State<TaskCreationScreen> {
  int hours = 1;
  int minutes = 30;
  String taskName;
  bool beneficialTask;
  Color taskColor;

  //Converts the user's input of hours and minutes to minutes
  int convertToMinutes({int hours, int minutes}) {
    return (hours * 60) + minutes;
  }

  void setTaskColor(Color color){
    taskColor =  color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Timely'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SizedBox(),
              flex: 1,
            ),
            Expanded(
              flex: 20,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter a task name',
                        ),
                        onChanged: (value) {
                          taskName = value;
                        },
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Expanded(
                      flex: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'I want to spend at least...',
                              style: infoTextStyle,
                            ),
                          ),
                          Expanded(
                            child: SizedBox()
                          ),
                          Expanded(
                            flex: 8,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(15.0),
                                    margin: EdgeInsets.only(right: 5.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(child: SizedBox()),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            'Hours',
                                            style: TextStyle(
                                                color: Color(0xFF719AAD)),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            hours.toString(),
                                            style: headerTextStyle.copyWith(
                                                fontSize: 24),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              RoundButton(
                                                icon: Icons.remove,
                                                onPressed: () {
                                                  if (hours > 0) {
                                                    setState(() {
                                                      hours--;
                                                    });
                                                  }
                                                },
                                              ),
                                              RoundButton(
                                                icon: Icons.add,
                                                onPressed: () {
                                                  if (hours < 24) {
                                                    setState(() {
                                                      hours++;
                                                    });
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(child: SizedBox()),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(15.0),
                                    margin: EdgeInsets.only(left: 5.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(child: SizedBox()),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            'Minutes',
                                            style: TextStyle(
                                                color: Color(0xFF719AAD)),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            minutes.toString(),
                                            style: headerTextStyle.copyWith(
                                                fontSize: 24),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              RoundButton(
                                                icon: Icons.remove,
                                                onPressed: () {
                                                  if (minutes > 0) {
                                                    setState(() {
                                                      minutes--;
                                                    });
                                                  }
                                                },
                                              ),
                                              RoundButton(
                                                icon: Icons.add,
                                                onPressed: () {
                                                  if (minutes < 60) {
                                                    setState(() {
                                                      minutes++;
                                                    });
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(child: SizedBox()),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  ColorDropper(color: Color(0xFF83B4FF), onPressed: setTaskColor),
                                  ColorDropper(color: Color(0xFFFF8383), onPressed: setTaskColor),
                                  ColorDropper(color: Color(0xFF82FCC1), onPressed: setTaskColor),
                                  ColorDropper(color: Color(0xFF41E3DA), onPressed: setTaskColor),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  ColorDropper(color: Color(0xFFBD95FE), onPressed: setTaskColor),
                                  ColorDropper(color: Color(0xFFFF82E3), onPressed: setTaskColor),
                                  ColorDropper(color: Color(0xFFFFAB7B), onPressed: setTaskColor),
                                  ColorDropper(color: Color(0xFFFFE175), onPressed: setTaskColor),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Expanded(
                      child: Container(
                        child: Center(
                          child: FlatButton(
                            color: Color(0xFF83B4FF),
                            onPressed: () {
                              Navigator.pop(
                                context,
                                Task(
                                  taskName: taskName,
                                  color: taskColor,
                                  timeToSpend: convertToMinutes(
                                      hours: hours, minutes: minutes),
                                  timeSpentToday: 0,
                                  timeSpentWeek: 0,
                                  timeSpentMonth: 0,
                                  timeSpentYear: 0
                                ),
                              );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(Icons.add, color: Colors.blue.shade50),
                                SizedBox(width: 10.0),
                                Text(
                                  'Create Task',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: SizedBox(), flex: 1),
          ],
        ),
      ),
    );
  }
}

class RoundButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;

  RoundButton({@required this.icon, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(
        icon,
        size: 20.0,
        color: Colors.white,
      ),
      onPressed: onPressed,
      constraints: BoxConstraints.tightFor(
        width: 45.0,
        height: 45.0,
      ),
      shape: CircleBorder(),
      elevation: 6.0,
      fillColor: Color(0xFF83B4FF),
    );
  }
}

class ColorDropper extends StatelessWidget {
  final Color color;
  final Function onPressed;

  ColorDropper({@required this.color, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: RawMaterialButton(
          onPressed: ()=> onPressed(color),
          fillColor: color,
          shape: CircleBorder(),
          constraints: BoxConstraints.expand(),
        ),
      ),
    );
  }
}


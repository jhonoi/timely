import 'package:flutter/material.dart';
import 'package:timely/constants.dart';
import 'package:timely/task.dart';
import 'package:timely/task_storage.dart';

class TaskCreationScreen extends StatefulWidget {
  final bool editingTask;
  final Task task;

  TaskCreationScreen({@required this.editingTask, this.task});

  @override
  _TaskCreationScreenState createState() => _TaskCreationScreenState();
}

class _TaskCreationScreenState extends State<TaskCreationScreen> {
  int hours = 1;
  int minutes = 30;
  String taskName;
  bool beneficialTask;
  Color taskColor;
  Color themeColor = Color(
      0xFF83B4FF); //Color of the icon buttons and create task button. Changes when user picks a task color
  TextEditingController controller = TextEditingController();

  //Converts the user's input of hours and minutes to minutes
  int convertToMinutes({int hours, int minutes}) {
    return (hours * 60) + minutes;
  }

  void setTaskColor(Color color) {
    taskColor = color;
    setState(() {
      themeColor = color;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.editingTask) {
      controller.text = widget.task.taskName;
      themeColor = widget.task.color;
    }
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
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: 'Enter a task name',
                        ),
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
                          Expanded(child: SizedBox()),
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
                                                color: themeColor,
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
                                                color: themeColor,
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
                                                color: themeColor,
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
                                                color: themeColor,
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
                                  ColorDropper(
                                      color: Color(0xFF83B4FF),
                                      onPressed: setTaskColor),
                                  ColorDropper(
                                      color: Color(0xFFFF8383),
                                      onPressed: setTaskColor),
                                  ColorDropper(
                                      color: Color(0xFF82FCC1),
                                      onPressed: setTaskColor),
                                  ColorDropper(
                                      color: Color(0xFF41E3DA),
                                      onPressed: setTaskColor),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  ColorDropper(
                                      color: Color(0xFFBD95FE),
                                      onPressed: setTaskColor),
                                  ColorDropper(
                                      color: Color(0xFFFF82E3),
                                      onPressed: setTaskColor),
                                  ColorDropper(
                                      color: Color(0xFFFFAB7B),
                                      onPressed: setTaskColor),
                                  ColorDropper(
                                      color: Color(0xFFFFE175),
                                      onPressed: setTaskColor),
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
                            color: themeColor,
                            onPressed: () {
                              bool duplicateFound = false;
                              bool blankName = false;
                              if(controller.text == null || controller.text == ''){
                                blankName = true;
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        title: Text("Task Name Required"),
                                        content: Text('A name for the task is needed, for example Reading.'));
                                  },
                                );
                              }
                              if(!blankName){
                                taskName = controller.text;
                                if (widget.editingTask) {
                                  Navigator.popUntil(
                                      context,
                                      ModalRoute.withName(
                                          Navigator.defaultRouteName));
                                  if (taskName == null || taskName == '') {
                                    widget.task.editTask(
                                        editColor: taskColor != null
                                            ? taskColor
                                            : widget.task.color);
                                  } else {
                                    widget.task.editTask(
                                        editName: taskName,
                                        editColor: taskColor != null
                                            ? taskColor
                                            : widget.task.color);
                                  }
                                } else {
                                  for (int i = 0; i < numOfTasks; i++) {
                                    if (controller.text == taskArray[i].taskName) {
                                      duplicateFound = true;
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              title: Text("Duplicate Detected"),
                                              content: Text('A task with this name already exists. You can use another name for this task or cancel and go home.'));
                                        },
                                      );
                                      break;
                                    }
                                  }
                                  if(!duplicateFound){
                                    Navigator.pop(
                                      context,
                                      Task(
                                        taskName: taskName,
                                        color: taskColor != null
                                            ? taskColor
                                            : Color(0xFF83B4FF),
                                        timeToSpend: convertToMinutes(
                                            hours: hours, minutes: minutes),
                                        timeValuesList: [
                                          List.filled(31, 0, growable: false),
                                          List.filled(28, 0, growable: false),
                                          List.filled(31, 0, growable: false),
                                          List.filled(30, 0, growable: false),
                                          List.filled(31, 0, growable: false),
                                          List.filled(30, 0, growable: false),
                                          List.filled(31, 0, growable: false),
                                          List.filled(31, 0, growable: false),
                                          List.filled(30, 0, growable: false),
                                          List.filled(31, 0, growable: false),
                                          List.filled(30, 0, growable: false),
                                          List.filled(31, 0, growable: false),
                                        ],
                                        timeSpentLifetime: 0,
                                        isRunning: false,
                                        timeStarted: DateTime(2001),
                                      ),
                                    );
                                  }
                                }
                              }
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(Icons.add, color: Colors.blue.shade50),
                                SizedBox(width: 10.0),
                                Text(
                                  widget.editingTask
                                      ? 'Edit Task'
                                      : 'Create Task',
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
  final Color color;

  RoundButton(
      {@required this.icon, @required this.onPressed, @required this.color});

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
      fillColor: color,
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
          onPressed: () => onPressed(color),
          fillColor: color,
          shape: CircleBorder(),
          constraints: BoxConstraints.expand(),
        ),
      ),
    );
  }
}

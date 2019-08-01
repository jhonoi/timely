import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'task_storage.dart';
import 'dart:convert';
import 'dart:async';

class Task {
  String taskName;
  Color color;
  bool isRunning = false;
  int timeToSpend; //Amount of time the user wishes to spend on a task (in minutes)
  int timeSpentToday;
  int timeSpentWeek;
  int timeSpentMonth;
  int timeSpentYear; //Actual amount of time spent on said task
  Duration duration = Duration(minutes: 1);
  Timer timer;

  Task({
    @required this.taskName,
    @required this.color,
    @required this.timeToSpend,
    this.timeSpentToday,
    this.timeSpentWeek,
    this.timeSpentMonth,
    this.timeSpentYear
  });

  void startTimer() {
    timer = Timer.periodic(duration, (timer) {
      timeSpentToday++;
    });
  }

  void cancelTimer() {
    timer.cancel();
    saveList(taskArray, numOfTasks);
  }

  void saveList(List<Task> tasks, int arrSize) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> list = [];
    for (int i = 0; i < arrSize; i++) {
      list.add(jsonEncode(tasks[i].toMap()));
    }
    tasksInJson = list;
    prefs.setStringList('savedTasks', tasksInJson);
    prefs.setInt('numOfTasks', arrSize);
    print('Save Complete!');
  }

  Map<String, dynamic> toMap(){
    return {
      'taskName': taskName,
      'color': int.parse(color.toString().substring(6, 16)),
      'timeToSpend': timeToSpend,
      'timeSpentToday': timeSpentToday,
      'timeSpentWeek': timeSpentWeek,
      'timeSpentMonth': timeSpentMonth,
      'timeSpentYear': timeSpentYear
    };
  }
}

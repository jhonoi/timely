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
  int timeSpentLifetime; //Actual amount of time spent on said task
  DateTime timeStarted;
  DateTime timeStopped;
  List<dynamic> timeValuesList;

  Task({
    @required this.taskName,
    @required this.color,
    @required this.timeToSpend,
    @required this.timeValuesList,
    this.timeSpentLifetime
  });

  void startTimer(DateTime now) {
    isRunning = true;
    timeStarted = now;
  }

  void cancelTimer(DateTime now) {
    isRunning = false;
    timeStopped = now;
    timeValuesList[DateTime.now().month - 1][DateTime.now().day - 1] += timeStopped.difference(timeStarted).inSeconds;
    timeSpentLifetime += timeStopped.difference(timeStarted).inSeconds;
    saveList(taskArray, numOfTasks);
  }

  int showTime(DateTime now){
    return timeValuesList[DateTime.now().month - 1][DateTime.now().day - 1] + DateTime.now().difference(timeStarted).inSeconds;
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
    //print('Save Complete!');
  }

  Map<String, dynamic> toMap(){
    return {
      'taskName': taskName,
      'color': int.parse(color.toString().substring(6, 16)),
      'timeToSpend': timeToSpend,
      'timeSpentLifetime': timeSpentLifetime,
      'timeValuesList': timeValuesList,
    };
  }
}

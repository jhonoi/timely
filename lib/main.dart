import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:timely/components/task_card.dart';
import 'package:timely/screens/task_creation_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'task.dart';
import 'task_storage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timley',
      theme: ThemeData(
        primaryColor: Color(0xFF83B4FF),
        accentColor: Color(0xFF83B4FF),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          textTheme: TextTheme(
            title: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
//      prefs.setStringList('savedTasks', []);
//      prefs.setInt('numOfTasks', 0);
      tasksInJson = prefs.getStringList('savedTasks') ?? [];
      numOfTasks = prefs.getInt('numOfTasks') ?? 0;

      for (int i = 0; i < numOfTasks; i++) {
        jsonConvertedTasks.add(jsonDecode(tasksInJson[i]));
        taskArray.add(
            Task(
              taskName: jsonConvertedTasks[i]['taskName'],
              color: Color(jsonConvertedTasks[i]['color']),
              timeToSpend: jsonConvertedTasks[i]['timeToSpend'],
              timeValuesList: jsonConvertedTasks[i]['timeValuesList'],
              timeSpentLifetime : jsonConvertedTasks[i]['timeSpentLifetime'],
            )
        );
      }
//      print('numOftasks: $numOfTasks');
//      print('tasksInJson: $tasksInJson');
    });
  }

  void saveList(List<Task> tasks, int arrSize) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      List<String> list = [];
      for (int i = 0; i < arrSize; i++) {
        list.add(jsonEncode(tasks[i].toMap()));
      }
      tasksInJson = list;
      prefs.setStringList('savedTasks', tasksInJson);
      prefs.setInt('numOfTasks', arrSize);
      print('Save Complete!');
    });
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
              flex: 20,
              child: BodyContent(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var newTask = await Navigator.push(context, MaterialPageRoute(builder: (context) => TaskCreationScreen()));
          if (newTask != null) {
            setState(() {
              taskArray.add(newTask);
              numOfTasks++;
            });
            setState(() {
              newTask.saveList(taskArray, numOfTasks);
            });
          }
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class BodyContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (numOfTasks > 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Your Tasks',
                    style: headerTextStyle,
                  ),
                  Text(
                    'Click to start timing or for more info!',
                    style: infoTextStyle,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              child: ListView.builder(
                itemCount: numOfTasks,
                itemBuilder: (context, index) {
                  return TaskCard(
                    color: taskArray[index].color,
                    task: taskArray[index],
                  );
                },
              ),
            ),
          ),
        ],
      );
    } else {
      return Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(child: SizedBox()),
              Expanded(
                child: Icon(
                  Icons.create,
                  size: 100.0,
                  color: Color(0xFFD3D3D3),
                ),
              ),
              Expanded(
                child: Wrap(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Created Tasks Will Show Up Here',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFD3D3D3),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: SizedBox()),
            ],
          ),
        ),
      );
    }
  }
}

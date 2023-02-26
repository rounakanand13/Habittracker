import 'package:flutter/material.dart';

import '../Components/habit_tile.dart';
import '../Components/my_fab.dart';
import '../Components/my_alert_box.dart';
// ignore_for_file: prefer_const_constructors

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //data structure for todays list
  List todaysHabitList = [
    //[habitName, habitCompleted]
    ["Morning Run", false],
    ["Read book", false],
    ["Code App", true]
  ];
  //checkbox was tapped
  void checkBoxTapped(bool? value, int index) {
    setState(() {
      todaysHabitList[index][1] = value;
    });
  }

  //Create a new habit
  final _newHabitNameController = TextEditingController();
  void createNewHabit() {
    //Show Alert Dialog for user to enter new habit details
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newHabitNameController,
          onSave: saveNewHabit,
          onCancel: cancelDialogBox,
        );
      },
    );
  }

//Save New Habit

  void saveNewHabit() {
    //Add new habit to todayshabitlist
    setState(() {
      todaysHabitList.add([_newHabitNameController.text, false]);
    });
    //Clear text field
    _newHabitNameController.clear();

    //pop dialog box
    Navigator.of(context).pop();
  }

//Cancel New Habit
  void cancelDialogBox() {
    //Clear text field
    _newHabitNameController.clear();

    //pop dialog box
    Navigator.of(context).pop();
  }

  //Open Habit settings to edit

  void openHabitSettings(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newHabitNameController,
          onSave: () => saveExistingHabit(index),
          onCancel: cancelDialogBox,
        );
      },
    );
  }

//Save existing habit with a new name

  void saveExistingHabit(int index) {
    setState(() {
      todaysHabitList[index][0] = _newHabitNameController.text;
    });
    _newHabitNameController.clear();
    Navigator.of(context).pop();
  }

//Delete Habit

  void deleteHabit(int index) {
    setState(() {
      todaysHabitList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[350],
        floatingActionButton: MyFloatingActionButton(
          onPressed: createNewHabit,
        ),
        body: ListView.builder(
          itemCount: todaysHabitList.length,
          itemBuilder: (context, index) {
            return HabitTile(
              habitName: todaysHabitList[index][0],
              habitCompleted: todaysHabitList[index][1],
              onChanged: (value) => checkBoxTapped(value, index),
              settingsTapped: (context) => openHabitSettings(index),
              deleteTapped: (context) => deleteHabit(index),
            );
          },
        ));
  }
}

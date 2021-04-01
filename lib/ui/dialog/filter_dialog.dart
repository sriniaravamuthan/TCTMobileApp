/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 1/4/21 5:39 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 1/4/21 5:39 PM by Kanmalai.
 * /
 */

import 'package:flutter/material.dart';

class FilterDialog extends StatefulWidget {
  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  bool valuefirst = false;
  bool valuesecond = false;
  bool valuethird = false;
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Row(
        children: [
          Text("Filter"),
          Text("Filter"),
        ],
      ),
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text("Location"),
                    ),
                    CheckboxListTile(
                      secondary: const Icon(Icons.alarm),
                      title: const Text('Lalipalayam'),
                      value: this.valuefirst,
                      onChanged: (bool value) {
                        setState(() {
                          this.valuefirst = value;
                        });
                      },
                    ),
                    CheckboxListTile(
                      secondary: const Icon(Icons.alarm),
                      title: const Text('Lala Pettai'),
                      value: this.valuesecond,
                      onChanged: (bool value) {
                        setState(() {
                          this.valuesecond = value;
                        });
                      },
                    ),
                    CheckboxListTile(
                      secondary: const Icon(Icons.alarm),
                      title: const Text('Edappalayam'),
                      value: this.valuesecond,
                      onChanged: (bool value) {
                        setState(() {
                          this.valuethird = value;
                        });
                      },
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text("Village Number"),
                    ),
                    CheckboxListTile(
                      secondary: const Icon(Icons.alarm),
                      title: const Text('121354'),
                      value: this.valuefirst,
                      onChanged: (bool value) {
                        setState(() {
                          this.valuefirst = value;
                        });
                      },
                    ),
                    CheckboxListTile(
                      secondary: const Icon(Icons.alarm),
                      title: const Text('6546565'),
                      value: this.valuesecond,
                      onChanged: (bool value) {
                        setState(() {
                          this.valuesecond = value;
                        });
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text("Gender"),
                    ),
                    CheckboxListTile(
                      secondary: const Icon(Icons.alarm),
                      title: const Text('Male'),
                      value: this.valuefirst,
                      onChanged: (bool value) {
                        setState(() {
                          this.valuefirst = value;
                        });
                      },
                    ),
                    CheckboxListTile(
                      secondary: const Icon(Icons.alarm),
                      title: const Text('Female'),
                      value: this.valuesecond,
                      onChanged: (bool value) {
                        setState(() {
                          this.valuesecond = value;
                        });
                      },
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text("Last Updated"),
                    ),
                    CheckboxListTile(
                      secondary: const Icon(Icons.alarm),
                      title: const Text('5.22PM 21/3/21'),
                      value: this.valuefirst,
                      onChanged: (bool value) {
                        setState(() {
                          this.valuefirst = value;
                        });
                      },
                    ),
                    CheckboxListTile(
                      secondary: const Icon(Icons.alarm),
                      title: const Text('5.22PM 21/3/21'),
                      value: this.valuesecond,
                      onChanged: (bool value) {
                        setState(() {
                          this.valuesecond = value;
                        });
                      },
                    ),
                  ],
                ),

              ],
            ),
            OutlinedButton(
              onPressed: (){

              },
              child: Text("Cancel"),
            ),
            OutlinedButton(
              onPressed: () {
                // Respond to button press
              },
              child: Text("Apply Filter"),
            )
          ],
        )
      ],
    );
  }
}

/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 31/3/21 10:37 AM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 31/3/21 10:37 AM by Kanmalai.
 * /
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckboxWidget extends StatefulWidget {
  final List<CheckboxList> checkList;

  const CheckboxWidget({Key key, this.checkList})
      : super(key: key);

  @override
  _CheckboxWidgetState createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller=TextEditingController();

    return Column(
        children: widget.checkList.map((hobby) {
          return CheckboxListTile(
              value: hobby.isChecked,
              title: Text(hobby.name),
              onChanged: (newValue) {
                setState(() {
                  hobby.isChecked= newValue;
                });
              });
        }).toList());
  }
}
class CheckboxList {
  String name;
  int index;
  bool isChecked;
  CheckboxList({this.name, this.index,this.isChecked});
}
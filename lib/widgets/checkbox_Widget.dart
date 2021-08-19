/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 31/3/21 10:37 AM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 31/3/21 10:37 AM by Kanmalai.
 * /
 */

import 'package:flutter/material.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class CheckboxWidget extends StatefulWidget {
  final List<dynamic> checkList;

  const CheckboxWidget({Key key, this.checkList}) : super(key: key);

  @override
  _CheckboxWidgetState createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  bool isChecked=false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
        children: widget.checkList.map((options) {
      debugPrint("Options: $options");
      var item = options;
      return Align(
        alignment: Alignment(0,-5),
        child: CheckboxListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            value: item['optionCheck'],
            title: TextWidget(
              text: options['optionName'],
              color: darkColor,
              size: 14,
              weight: FontWeight.w400,
            ),
            onChanged: (newValue) {
              setState(() {
                item['optionCheck'] = newValue;
              });
            }),
      );
        }).toList());
  }
}
class CheckboxList {
  String name;
  int index;
  bool isChecked;
  CheckboxList({this.name, this.index,this.isChecked});
}
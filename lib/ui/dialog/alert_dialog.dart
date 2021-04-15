/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 1/4/21 5:40 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 1/4/21 5:40 PM by Kanmalai.
 * /
 */

import 'package:flutter/material.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class AlertDialogWidget extends StatefulWidget {
  final String text;
  final Function onPressed;

  const AlertDialogWidget({Key key, this.text, this.onPressed})
      : super(key: key);
  @override
  _AlertDialogWidgetState createState() => _AlertDialogWidgetState();
}

class _AlertDialogWidgetState extends State<AlertDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Details will be deleted permanently"),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: OutlinedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)))),
                onPressed: widget.onPressed,
                child: TextWidget(
                  text: "Yes, Delete",
                  color: darkColor,
                  weight: FontWeight.w400,
                  size: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: OutlinedButton(
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xff005aa8)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)))),
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: TextWidget(
                  text: "No, Cancel",
                  color: lightColor,
                  weight: FontWeight.w400,
                  size: 18,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

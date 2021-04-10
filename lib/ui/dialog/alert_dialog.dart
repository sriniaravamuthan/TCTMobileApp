/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 1/4/21 5:40 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 1/4/21 5:40 PM by Kanmalai.
 * /
 */

import 'package:flutter/material.dart';

class AlertDialogWidget extends StatefulWidget {
  final String text;
  final Function onPressed;

  const AlertDialogWidget({Key key, this.text, this.onPressed}) : super(key: key);
  @override
  _AlertDialogWidgetState createState() => _AlertDialogWidgetState();
}

class _AlertDialogWidgetState extends State<AlertDialogWidget> {


  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(widget.text +"Details will be deleted permanently"),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlinedButton(
              onPressed: widget.onPressed,
              child: Text("Yes,Delete"),
            ),
            OutlinedButton(
              onPressed: () {
                // Respond to button press
              },
              child: Text("No,Cancel"),
            )
          ],
        )
      ],
    );
  }
}

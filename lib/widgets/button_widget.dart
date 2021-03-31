/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 31/3/21 10:35 AM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 31/3/21 10:35 AM by Kanmalai.
 * /
 */

import 'package:flutter/material.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class ButtonWidget extends StatefulWidget {
  final Function onPressed;
  final String text;
  final int size;
  final Color color;
  final Color txtcolor;
  final double width;

  const ButtonWidget({Key key, this.onPressed, this.text, this.size, this.color, this.txtcolor, this.width}) : super(key: key);

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      child: Material(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        elevation: 6.0,
        color: widget.color,
        clipBehavior: Clip.antiAlias,
        child: Container(
          child: MaterialButton(
            height: 50,
            minWidth: widget.width.toDouble(),
            splashColor: primaryColor,
            padding: EdgeInsets.all(4.0),
            child: TextWidget(
              text: widget.text.toUpperCase(),
              size: widget.size,
              color: widget.txtcolor,
              weight: FontWeight.w600,
            ),
            onPressed: widget.onPressed,
          ),
        ),
      ),
    );
  }
}

/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 31/3/21 10:37 AM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 31/3/21 10:37 AM by Kanmalai.
 * /
 */

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SurveyTextWidget extends StatefulWidget {
  final String text;
  final int size;
  final Color color;
  final FontWeight weight;
  int maxLines =1;

  SurveyTextWidget({Key key,  this.text,  this.size,  this.color,  this.weight, this.maxLines = 1})
      : super(key: key);

  @override
  _SurveyTextWidgetState createState() => _SurveyTextWidgetState();
}

class _SurveyTextWidgetState extends State<SurveyTextWidget> {
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      widget.text,
      maxLines: widget.maxLines,
      textAlign: TextAlign.start,
      style: GoogleFonts.roboto(
          fontSize: widget.size.toDouble(),
          fontStyle: FontStyle.normal,
          color: widget.color,
          fontWeight: widget.weight),
      overflow: TextOverflow.ellipsis,
      // softWrap: true,
      // stepGranularity: 0.1,

    );
  }
}
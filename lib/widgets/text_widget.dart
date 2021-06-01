/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 31/3/21 10:37 AM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 31/3/21 10:37 AM by Kanmalai.
 * /
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatefulWidget {
  final String text;
  final int size;
  final Color color;
  final FontWeight weight;

  const TextWidget({Key key, this.text, this.size, this.color, this.weight})
      : super(key: key);

  @override
  _TextWidgetState createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      maxLines: 3,
      textAlign: TextAlign.start,
      style: GoogleFonts.roboto(
          fontSize: widget.size.toDouble(),
          fontStyle: FontStyle.normal,
          color: widget.color,
          fontWeight: widget.weight),
      overflow: TextOverflow.ellipsis,
      softWrap: true,
    );
  }
}

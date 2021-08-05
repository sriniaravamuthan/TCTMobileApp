/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 31/3/21 10:37 AM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 31/3/21 10:37 AM by Kanmalai.
 * /
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class DropDownWidget extends StatefulWidget {
 final List<String> listItem;

  const DropDownWidget({Key key, this.listItem})
      : super(key: key);

  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller=TextEditingController();

   return Padding(
     padding: const EdgeInsets.all(8.0),
     child: DropdownButtonFormField<String>(
        isExpanded: true,
        autofocus: true,
        decoration: InputDecoration(
            counterText: "",
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius:
              BorderRadius.all(Radius.circular(10.0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.all(Radius.circular(10.0)),
              borderSide:
              BorderSide(color: lightGreyColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.all(Radius.circular(10.0)),
              borderSide:
              BorderSide(color: lightGreyColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.all(Radius.circular(10.0)),
              borderSide:
              BorderSide(color: lightGreyColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.all(Radius.circular(10.0)),
              borderSide:
              BorderSide(color: lightGreyColor),
            ),
            fillColor: lightGreyColor),
        onChanged: (newVal) {
          controller.text = newVal;
          this.setState(() {});
        },
        items: widget.listItem.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: TextWidget(
              text: value,
              color: darkColor,
              weight: FontWeight.w400,
              size: 14,
            ),
          );
        }).toList(),
      ),
   );
  }
}

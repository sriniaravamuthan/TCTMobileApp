/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 31/3/21 10:37 AM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 31/3/21 10:37 AM by Kanmalai.
 * /
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldWidget extends StatefulWidget {
final String valueText;

  const TextFieldWidget({Key key, this.valueText})
      : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller=TextEditingController();

    return Container(
      width: MediaQuery.of(context).size.width/2.5,
      height: MediaQuery.of(context).size.height/7.5,
      child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: TextField(
            controller: controller,
            maxLines: 2,
            keyboardType: TextInputType.text,
            onChanged: (value) {
              setState(() {
                controller.text=value;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
    );
  }
}

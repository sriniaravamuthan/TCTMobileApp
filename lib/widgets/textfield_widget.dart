/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 31/3/21 10:37 AM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 31/3/21 10:37 AM by Kanmalai.
 * /
 */

import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
final String valueText;
final TextEditingController controller;

  const TextFieldWidget({Key key, this.valueText, this.controller})
      : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    // TextEditingController controller=TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 48,
        width: MediaQuery.of(context).size.width/2.5,
        child: TextFormField(
          controller: widget.controller,
          keyboardType: TextInputType.text,
          enableSuggestions: true,
          onSaved: (value) {
            setState(() {
              widget.controller.text = value;
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

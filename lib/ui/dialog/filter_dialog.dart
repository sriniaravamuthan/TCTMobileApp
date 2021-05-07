/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 1/4/21 5:39 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 1/4/21 5:39 PM by Kanmalai.
 * /
 */

import 'package:flutter/material.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/localization/localization.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class FilterDialog extends StatefulWidget {
  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  bool locationfirst = false;
  bool locationsecond = false;
  bool locationthird = false;

  bool genderfirst = false;
  bool gendersecond = false;

  bool villagefirst = false;
  bool villagesecond = false;

  bool lastUpdatefirst = false;
  bool lastUpdatesecond = false;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      title: Row(
        children: [
          TextWidget(
            text: DemoLocalization.of(context).translate('Filter'),
            color: darkColor,
            size: 16,
            weight: FontWeight.w700,
          ),
        ],
      ),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: TextWidget(
                          text: DemoLocalization.of(context)
                              .translate('Location'),
                          color: darkColor,
                          size: 16,
                          weight: FontWeight.w700,
                        ),
                      ),
                      CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.only(left: 20, right: 80),
                        title: const Text('Lalipalayam'),
                        value: this.locationfirst,
                        onChanged: (bool value) {
                          setState(() {
                            this.locationfirst = value;
                          });
                        },
                      ),
                      CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.only(left: 20, right: 80),
                        title: const Text('Lala Pettai'),
                        value: this.locationsecond,
                        onChanged: (bool value) {
                          setState(() {
                            this.locationsecond = value;
                          });
                        },
                      ),
                      CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.only(left: 20, right: 80),
                        title: const Text('Edappalayam'),
                        value: this.locationthird,
                        onChanged: (bool value) {
                          setState(() {
                            this.locationthird = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: TextWidget(
                          text: DemoLocalization.of(context)
                              .translate('Village Code'),
                          color: darkColor,
                          size: 16,
                          weight: FontWeight.w700,
                        ),
                      ),
                      CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.only(left: 20, right: 80),
                        title: const Text('121354'),
                        value: this.villagefirst,
                        onChanged: (bool value) {
                          setState(() {
                            this.villagefirst = value;
                          });
                        },
                      ),
                      CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.only(left: 20, right: 80),
                        title: const Text('6546565'),
                        value: this.villagesecond,
                        onChanged: (bool value) {
                          setState(() {
                            this.villagesecond = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 50.0),
                        child: TextWidget(
                          text:
                              DemoLocalization.of(context).translate('Gender'),
                          color: darkColor,
                          size: 16,
                          weight: FontWeight.w700,
                        ),
                      ),
                      CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.only(left: 50, right: 80),
                        title: const Text('Male'),
                        value: this.genderfirst,
                        onChanged: (bool value) {
                          setState(() {
                            this.genderfirst = value;
                          });
                        },
                      ),
                      CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.only(left: 50, right: 80),
                        title: const Text('Female'),
                        value: this.gendersecond,
                        onChanged: (bool value) {
                          setState(() {
                            this.gendersecond = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: TextWidget(
                          text: DemoLocalization.of(context)
                              .translate('Last Updated'),
                          color: darkColor,
                          size: 16,
                          weight: FontWeight.w700,
                        ),
                      ),
                      CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.only(left: 10, right: 30),
                        title: const Text('5.22PM 21/3/21'),
                        value: this.lastUpdatefirst,
                        onChanged: (bool value) {
                          setState(() {
                            this.lastUpdatefirst = value;
                          });
                        },
                      ),
                      CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.only(left: 10, right: 30),
                        title: const Text('5.22PM 21/3/21'),
                        value: this.lastUpdatesecond,
                        onChanged: (bool value) {
                          setState(() {
                            this.lastUpdatesecond = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: OutlinedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.red)))),
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: TextWidget(
                      text: DemoLocalization.of(context).translate('cancel'),
                      color: darkColor,
                      weight: FontWeight.w400,
                      size: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: OutlinedButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xff005aa8)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.black45)))),
                    onPressed: () {
                      // Respond to button press
                    },
                    child: Row(
                      children: [
                        Icon(Icons.done),
                        SizedBox(
                          width: 10,
                        ),
                        TextWidget(
                          text: DemoLocalization.of(context)
                              .translate('Apply Filter'),
                          color: lightColor,
                          weight: FontWeight.w400,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}

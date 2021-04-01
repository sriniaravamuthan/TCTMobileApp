/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 31/3/21 5:36 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 31/3/21 5:36 PM by Kanmalai.
 * /
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tct_demographics/constants/app_colors.dart';
import 'package:tct_demographics/constants/app_images.dart';
import 'package:tct_demographics/constants/app_strings.dart';
import 'package:tct_demographics/models/tabledata_model.dart';
import 'package:tct_demographics/widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenScreenState createState() => _HomeScreenScreenState();
}

class _HomeScreenScreenState extends State<HomeScreen> {

  List<Result> users;
  @override
  void initState(){
    super.initState();
    users = Result.getUser();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
                onTap: (){

                },
                child: Row(
                  children: [
                    Icon(Icons.language, size: 24,color: darkColor,),
                    SizedBox(width: 10,),
                    Text("English",
                      style: TextStyle(fontSize: 18,color: darkColor),),
                  ],
                )
            ),
            SizedBox(width: 50,),
            InkWell(
                onTap: (){

                },
                child: Row(
                  children: [
                    Text("Senthil Kumar",
                      style: TextStyle(fontSize: 18,color: darkColor),),
                    SizedBox(width: 10,),
                    Container(
                        padding: EdgeInsets.only(left:8.0),
                        height: 30,
                        width: 30,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: new AssetImage(user)
                            )
                        )
                    )
                  ],
                )
            ),

          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imgBG),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:24.0,left: 30.0,right: 30.0,bottom: 24.0),
                        child: TextWidget(
                          text: totalRecords + "(360)",
                          color: darkColor,
                          weight:  FontWeight.w600,
                          size: 24,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right:30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: (){

                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: Colors.black45,
                                    style: BorderStyle.solid,
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.search),
                                      SizedBox(width: 10,),
                                      TextWidget(
                                        text: search,
                                        color: darkColor,
                                        weight:  FontWeight.w800,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 50,),
                            InkWell(
                              onTap: (){

                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: Colors.black45,
                                    style: BorderStyle.solid,
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.filter_list_sharp),
                                      SizedBox(width: 10,),
                                      TextWidget(
                                        text: filter,
                                        color: darkColor,
                                        weight:  FontWeight.w800,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 50,),
                            InkWell(
                              onTap: (){

                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: Colors.black45,
                                    style: BorderStyle.solid,
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.add),
                                      SizedBox(width: 10,),
                                      TextWidget(
                                        text: addNew,
                                        color: darkColor,
                                        weight:  FontWeight.w800,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 1,),
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: AspectRatio(
                      aspectRatio: 24/10,
                      child: DataTable(
                            columns: [
                              DataColumn(label: Text(familyHead)),
                              DataColumn(label: Text(age),numeric: true),
                              DataColumn(label: Text(mobile),numeric: true),
                              DataColumn(label: Text(villageCode),numeric: true),
                              DataColumn(label: Text(zone),numeric: true),
                              DataColumn(label: Text(status)),
                              DataColumn(label: Text(action)),

                            ],
                            rows: users.map((users) =>
                                DataRow(
                                    cells: [
                                      DataCell(
                                        Row(
                                          children: [
                                            Container(
                                                padding: EdgeInsets.only(left:8.0),
                                                height: 30,
                                                width: 30,
                                                decoration: new BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: new DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: new AssetImage(user)
                                                    )
                                                )
                                            ),
                                            SizedBox(width: 10,),
                                            Text(users.familyHead)
                                          ],
                                        )
                                      ),
                                      DataCell(Text(users.age)),
                                      DataCell(Text(users.mobile)),
                                      DataCell(Text(users.villageCode)),
                                      DataCell(Text(users.zone)),
                                      DataCell(Text(users.status)),
                                      DataCell(
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: (){

                                              },
                                              child: Icon(Icons.edit),
                                            ),
                                            SizedBox(width: 20,),
                                            InkWell(
                                              onTap: (){

                                              },
                                              child: Icon(Icons.delete),
                                            )
                                          ],
                                        )
                                      ),
                                    ]
                                )
                            ).toList(),
                          )


                        // child: ListView(
                        //   children:[
                        //     PaginatedDataTable(
                        //       showCheckboxColumn: false,
                        //       sortAscending: true,
                        //         columns: [
                        //           DataColumn(label: Text(familyHead)),
                        //           DataColumn(label: Text(age)),
                        //           DataColumn(label: Text(mobile)),
                        //           DataColumn(label: Text(villageCode)),
                        //           DataColumn(label: Text(zone)),
                        //           DataColumn(label: Text(status)),
                        //           DataColumn(label: Text(action)),
                        //         ],
                        //       source: _DataSource(context),
                        //
                        //   ),
                        //   ]
                        // ),
                      ),
                    ),


                ],
              ),
            ),
          ),
        ),

      ),
    );
  }
}

class _Row {
  _Row(
      this.valueA,
      this.valueB,
      this.valueC,
      this.valueD, this.valueE, this.valueF, this.valueG,
      );

  final String valueA;
  final String valueB;
  final String valueC;
  final String valueD;
  final String valueE;
  final String valueF;
  final int valueG;

  bool selected = false;
}
class _DataSource extends DataTableSource {
  _DataSource(this.context) {
    _rows = <_Row>[
      _Row('Cell A1', 'CellB1', 'CellC1','CellB1', 'CellC1', 'celld1', 2),
      _Row('Cell A1', 'CellB1', 'CellC1','CellB1', 'CellC1', 'celld1', 2),
      _Row('Cell A1', 'CellB1', 'CellC1','CellB1', 'CellC1', 'celld1', 2),
      _Row('Cell A1', 'CellB1', 'CellC1','CellB1', 'CellC1', 'celld1', 2),

    ];
  }

  final BuildContext context;
  List<_Row> _rows;

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return null;
    final row = _rows[index];
    return DataRow.byIndex(
      index: index,
      selected: row.selected,
      onSelectChanged: (value) {
        if (row.selected != value) {
          _selectedCount += value ? 1 : -1;
          assert(_selectedCount >= 0);
          row.selected = value;
          notifyListeners();
        }
      },
      cells: [
        DataCell(Text(row.valueA)),
        DataCell(Text(row.valueB)),
        DataCell(Text(row.valueC)),
        DataCell(Text(row.valueA)),
        DataCell(Text(row.valueB)),
        DataCell(Text(row.valueC)),
        DataCell(Text(row.valueD.toString())),
      ],
    );
  }

  @override
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

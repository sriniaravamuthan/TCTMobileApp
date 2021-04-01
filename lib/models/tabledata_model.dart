/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 1/4/21 2:17 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 1/4/21 2:17 PM by Kanmalai.
 * /
 */

import 'package:tct_demographics/constants/app_images.dart';

class Result {
  String image;
  String familyHead;
  String age;
  String mobile;
  String villageCode;
  String zone;
  String status;

  Result(this.image,this.familyHead, this.age, this.mobile, this.villageCode, this.zone,
      this.status);

  static List<Result> getUser(){
    return <Result>[
      Result(user,"Senthil Kumar", "35", "9898989898", "VLR", "545454", "complete"),
      Result(user,"Senthil Kumar", "35", "9898989898", "VLR", "545454", "complete"),
      Result(user,"Senthil Kumar", "35", "9898989898", "VLR", "545454", "complete"),
      Result(user,"Senthil Kumar", "35", "9898989898", "VLR", "545454", "complete"),
      Result(user,"Senthil Kumar", "35", "9898989898", "VLR", "545454", "complete"),
      Result(user,"Senthil Kumar", "35", "9898989898", "VLR", "545454", "complete"),
      Result(user,"Senthil Kumar", "35", "9898989898", "VLR", "545454", "complete"),
      Result(user,"Senthil Kumar", "35", "9898989898", "VLR", "545454", "complete"),
      Result(user,"Senthil Kumar", "35", "9898989898", "VLR", "545454", "complete"),
      Result(user,"Senthil Kumar", "35", "9898989898", "VLR", "545454", "complete"),


    ];
  }
}

/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 1/4/21 2:17 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 1/4/21 2:17 PM by Kanmalai.
 * /
 */



class Result {
  String familyHead;
  String age;
  String mobile;
  String villageCode;
  String zone;
  String status;

  Result(this.familyHead, this.age, this.mobile, this.villageCode, this.zone,
      this.status);

  static List<Result> getUser() {
    return <Result>[
      Result("Thirumalai Charity Trust", "35", "9898989898", "VLR", "545454",
          "complete"),
      Result("Thirumalai Charity Trust", "35", "9898989898", "VLR", "545454",
          "complete"),
      Result("Thirumalai Charity Trust", "35", "9898989898", "VLR", "545454",
          "complete"),
      Result("Senthil Kumar", "35", "9898989898", "VLR", "545454", "complete"),
      Result("Senthil Kumar", "35", "9898989898", "VLR", "545454", "complete"),
      Result("Senthil Kumar", "35", "9898989898", "VLR", "545454", "complete"),
      Result("Senthil Kumar", "35", "9898989898", "VLR", "545454", "complete"),
      Result("Senthil Kumar", "35", "9898989898", "VLR", "545454", "complete"),
      Result("Senthil Kumar", "35", "9898989898", "VLR", "545454", "complete"),
      Result("Senthil Kumar", "35", "9898989898", "VLR", "545454", "complete"),
      Result("Senthil Kumar", "35", "9898989898", "VLR", "545454", "complete"),
      Result("Senthil Kumar", "35", "9898989898", "VLR", "545454", "complete"),
      Result("Senthil Kumar", "35", "9898989898", "VLR", "545454", "complete"),
    ];
  }
}

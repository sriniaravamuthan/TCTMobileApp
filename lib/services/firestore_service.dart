/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 10/4/21 2:17 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 10/4/21 2:17 PM by Kanmalai.
 * /
 */
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:tct_demographics/models/data_model.dart';

class FireStoreService{

  CollectionReference demographicData = FirebaseFirestore.instance.collection('demographicData');

  Future<DemographicFamily> createFamily(DemographicFamily demographicFamily){

    Map data = {
      "Location": {
        'formNo': demographicFamily.location.formNo,
        'projectCode': demographicFamily.location.projectCode,
        'villagesCode': demographicFamily.location.villagesCode,
        'panchayatNo': demographicFamily.location.panchayatNo,
        'panchayatCode': demographicFamily.location.panchayatCode,
        'villageName': demographicFamily.location.villageName,
        'streetName': demographicFamily.location.streetName,
        'doorNumber': demographicFamily.location.doorNumber,
        'contactPerson': demographicFamily.location.contactPerson,
        'noOfFamilyMembers': demographicFamily.location.noOfFamilyMembers
      },
      "Property" : {
        'statusofHouse': demographicFamily.property.statusofHouse,
        'typeofHouse': demographicFamily.property.statusofHouse,
        'toiletFacility': demographicFamily.property.statusofHouse,
        'ownLand': demographicFamily.property.statusofHouse,
        'wetLandInAcres': demographicFamily.property.statusofHouse,
        'dryLandInAcres': demographicFamily.property.statusofHouse,
        'ownVehicle': demographicFamily.property.statusofHouse,
        'noOfVehicleOwn': demographicFamily.property.statusofHouse,
        'twoWheeler': demographicFamily.property.statusofHouse,
        'threeWheeler': demographicFamily.property.statusofHouse,
        'fourWheeler': demographicFamily.property.statusofHouse,
        'others': demographicFamily.property.statusofHouse,
        'ownLivestocks': demographicFamily.property.statusofHouse,
        'livestockType': demographicFamily.property.statusofHouse,
        'livestockCount': demographicFamily.property.statusofHouse
      },
      "habit": {
        'anyMembersWhoSmoke' : demographicFamily.habits.anyMembersWhoDrink,
        'anyMembersWhoDrink' : demographicFamily.habits.anyMembersWhoDrink,
        'anyMembersWhoUseTobacco' : demographicFamily.habits.anyMembersWhoDrink,
      },
      "familyMembers":[
        {
          "name" : demographicFamily.family[0].name,
          "aadharNumber" : demographicFamily.family[0].aadharNumber,
          "relationship" : demographicFamily.family[0].relationship,
          "gender" : demographicFamily.family[0].gender,
          "dob" : demographicFamily.family[0].dob,
          "age" : demographicFamily.family[0].age,
          "maritalStatus " : demographicFamily.family[0].maritalStatus,
          "bloodGroup" : demographicFamily.family[0].bloodGroup,
          "physicallyChallenge" : demographicFamily.family[0].physicallyChallenge,
          "education" : demographicFamily.family[0].education,
          "occupation" : demographicFamily.family[0].occupation,
          "annualIncome" : demographicFamily.family[0].annualIncome,
          "mobileNumber" : demographicFamily.family[0].mobileNumber,
          "mail" : demographicFamily.family[0].mail,
          "smartphone" : demographicFamily.family[0].smartphone,
          "community" : demographicFamily.family[0].community,
          "caste" : demographicFamily.family[0].caste,
          "photo" : demographicFamily.family[0].photo,
        }
      ]
    };

    return demographicData.add(data)
    .then((value) => debugPrint("addedSuccess"))
    .catchError((error)=>debugPrint("failed to add"));

  }



}

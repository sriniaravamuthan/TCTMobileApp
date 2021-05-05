/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 10/4/21 2:17 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 10/4/21 2:17 PM by Kanmalai.
 * /
 */
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:tct_demographics/models/data_model.dart';

class FireStoreService {
  CollectionReference demographicData =
      FirebaseFirestore.instance.collection('demographicData');
  // Map familyData;
  Future<bool> createFamily(DemographicFamily demographicFamily) {
    Map<String, dynamic> data = {
      "CreatedBy": FirebaseAuth.instance.currentUser.uid,
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
        'contactNumber': demographicFamily.location.contactNumber,
        'noOfFamilyMembers': demographicFamily.location.noOfFamilyMembers
      },
      "Property": {
        'statusofHouse': demographicFamily.property.statusofHouse,
        'typeofHouse': demographicFamily.property.typeofHouse,
        'toiletFacility': demographicFamily.property.toiletFacility,
        'ownLand': demographicFamily.property.ownLand,
        'wetLandInAcres': demographicFamily.property.wetLandInAcres,
        'dryLandInAcres': demographicFamily.property.dryLandInAcres,
        'ownVehicle': demographicFamily.property.ownVehicle,
        'noOfVehicleOwn': demographicFamily.property.noOfVehicleOwn,
        'twoWheeler': demographicFamily.property.twoWheeler,
        'threeWheeler': demographicFamily.property.threeWheeler,
        'fourWheeler': demographicFamily.property.fourWheeler,
        'others': demographicFamily.property.others,
        'ownLivestocks': demographicFamily.property.ownLivestocks,
        'livestockType': demographicFamily.property.livestockType,
        'livestockCount': demographicFamily.property.livestockCount
      },
      "habit": {
        'anyMembersWhoSmoke': demographicFamily.habits.anyMembersWhoSmoke,
        'anyMembersWhoDrink': demographicFamily.habits.anyMembersWhoDrink,
        'anyMembersWhoUseTobacco':
            demographicFamily.habits.anyMembersWhoUseTobacco,
        'isVaccinationDone': demographicFamily.habits.isVaccinationDone,
        'firstDose': demographicFamily.habits.firstDose,
        'secondDose': demographicFamily.habits.secondDose
      },
      "familyMembers": [
        {
          "name": demographicFamily.family[0].name,
          "aadharNumber": demographicFamily.family[0].aadharNumber,
          "relationship": demographicFamily.family[0].relationship,
          "gender": demographicFamily.family[0].gender,
          "dob": demographicFamily.family[0].dob,
          "age": demographicFamily.family[0].age,
          "maritalStatus ": demographicFamily.family[0].maritalStatus,
          "bloodGroup": demographicFamily.family[0].bloodGroup,
          "physicallyChallenge": demographicFamily.family[0].physicallyChallenge,
          "education": demographicFamily.family[0].education,
          "occupation": demographicFamily.family[0].occupation,
          "annualIncome": demographicFamily.family[0].annualIncome,
          "mobileNumber": demographicFamily.family[0].mobileNumber,
          "mail": demographicFamily.family[0].mail,
          "smartphone": demographicFamily.family[0].smartphone,
          "community": demographicFamily.family[0].community,
          "caste": demographicFamily.family[0].caste,
          "photo": demographicFamily.family[0].photo,
          "govtInsurance": demographicFamily.family[0].govtInsurance,
          "privateInsurance": demographicFamily.family[0].privateInsurance,
          "oldPension": demographicFamily.family[0].oldPension,
          "widowedPension": demographicFamily.family[0].widowedPension,
          "retirementPension": demographicFamily.family[0].retirementPension,
        }
      ]
    };

    return demographicData
        .add(data)
        .then((value) => true)
        .catchError((error) => false);
  }
}

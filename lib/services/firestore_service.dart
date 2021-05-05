/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 10/4/21 2:17 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 10/4/21 2:17 PM by Kanmalai.
 * /
 */
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tct_demographics/models/data_model.dart';

class FireStoreService {
  CollectionReference demographicData =
      FirebaseFirestore.instance.collection('demographicData');

  List<Map<String, dynamic>> createFamilyList(
      DemographicFamily demographicFamily) {
    List<Map<String, dynamic>> familyList = [];
    demographicFamily.family.forEach((element) {
      var map = {
        "name": element.name,
        "aadharNumber": element.aadharNumber,
        "relationship": element.relationship,
        "gender": element.gender,
        "dob": element.dob,
        "age": element.age,
        "maritalStatus ": element.maritalStatus,
        "bloodGroup": element.bloodGroup,
        "physicallyChallenge": element.physicallyChallenge,
        "education": element.education,
        "occupation": element.occupation,
        "annualIncome": element.annualIncome,
        "mobileNumber": element.mobileNumber,
        "mail": element.mail,
        "smartphone": element.smartphone,
        "community": element.community,
        "caste": element.caste,
        "photo": element.photo,
        "govtInsurance": element.govtInsurance,
        "privateInsurance": element.privateInsurance,
        "oldPension": element.oldPension,
        "widowedPension": element.widowedPension,
        "retirementPension": element.retirementPension,
      };
      familyList.add(map);
    });
    return familyList;
  }
 String getTime() {
   return new DateTime.now().toString();
 }
 // Map familyData;
  Future<bool> createFamily(DemographicFamily demographicFamily) {
    Map<String, dynamic> data = {
      "CreatedBy": FirebaseAuth.instance.currentUser.uid,
      "createdDate":getTime(),
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
      "familyMembers": createFamilyList(demographicFamily)
    };

    return demographicData
        .add(data)
        .then((value) => true)
        .catchError((error) => false);
  }
}

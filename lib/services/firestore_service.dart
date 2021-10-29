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
        "maritalStatus": element.maritalStatus,
        "pregnantStatus": element.pregnantStatus,
        "pregnantMonth": element.pregnantMonths,
        "bloodGroup": element.bloodGroup,
        "physicallyChallenge": element.physicallyChallenge,
        "physicallyChallenged": element.physical,
        "education": element.education,
        "occupation": element.occupation,
        "annualIncome": element.annualIncome,
        "mobileNumber": element.mobileNumber,
        "mail": element.mail,
        "smartphone": element.smartphone,
        "community": element.community,
        "caste": element.caste,
        "photo": element.photo,
        "positon": element.position,
        "familyId": element.familyId,
        "govtInsurance": element.govtInsurance,
        "privateInsurance": element.privateInsurance,
        "oldPension": element.oldPension,
        "widowedPension": element.widowedPension,
        "retirementPension": element.retirementPension,
        'anyMembersWhoSmoke': element.anyMembersWhoSmoke,
        'anyMembersWhoDrink': element.anyMembersWhoDrink,
        "drinkingUsage": element.drinkingUsage,
        "stoppedBy": element.stoppedBy,
        "noOfYears": element.noOfYears,
        "whenTreatment": element.whenTreatment,
        "whereTreatment": element.whereTreatment,
        'anyMembersWhoUseTobacco': element.anyMembersWhoUseTobacco,
        'memberStatus': element.died,
        'dateOfDeath': element.dateOfDemise,
        'migrate': element.migrate,
        'migrateReason': element.migrateReason,
        'diedUpdateBy': element.diedUpdateBy,
        'diedUpdateDate': element.diedUpdateDate,
        'isVaccinationDone': element.isVaccinationDone,
        'firstDose': element.firstDose,
        'secondDose': element.secondDose,
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
      "createdDate": getTime(),
      "lastUpdateBy": FirebaseAuth.instance.currentUser.uid,
      "lastUpdateDate": getTime(),
      "Location": createLocation(demographicFamily),
      "Property": createProperty(demographicFamily),
      // "habit":createHabit(demographicFamily),
      "familyMembers": createFamilyList(demographicFamily)
    };

    return demographicData
        .add(data)
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> updateFamily(
      DemographicFamily demographicFamily, String documentId) {
    Map<String, dynamic> data = {
      "CreatedBy": FirebaseAuth.instance.currentUser.uid,
      "createdDate": getTime(),
      "lastUpdateBy": FirebaseAuth.instance.currentUser.uid,
      "lastUpdateDate": getTime(),
      "Location": createLocation(demographicFamily),
      "Property": createProperty(demographicFamily),
      // "habit":createHabit(demographicFamily),
      "familyMembers": createFamilyList(demographicFamily)
    };

    return demographicData
        .doc(documentId)
        .update(data)
        .then((value) => true)
        .catchError((error) => false);
  }

  createLocation(DemographicFamily demographicFamily) {
    var map = {
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
      "name": demographicFamily.location.name,
      'noOfFamilyMembers': demographicFamily.location.noOfFamilyMembers
    };
    return map;
  }

  createProperty(DemographicFamily demographicFamily) {
    var map = {
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
      'cow': demographicFamily.property.cow,
      'buffalo': demographicFamily.property.buffalo,
      'bull': demographicFamily.property.bull,
      'hen': demographicFamily.property.hen,
      'goat': demographicFamily.property.goat,
      'sheep': demographicFamily.property.sheep,
      'pig': demographicFamily.property.pig,
      'othersLive': demographicFamily.property.othersLive,
      'livestockCount': demographicFamily.property.livestockCount
    };
    return map;
  }

  createHabit(DemographicFamily demographicFamily) {
    var map = {
      'anyMembersWhoSmoke': demographicFamily.habits.anyMembersWhoSmoke,
      'anyMembersWhoDrink': demographicFamily.habits.anyMembersWhoDrink,
      'anyMembersWhoUseTobacco':
          demographicFamily.habits.anyMembersWhoUseTobacco,
      'isVaccinationDone': demographicFamily.habits.isVaccinationDone,
      'firstDose': demographicFamily.habits.firstDose,
      'secondDose': demographicFamily.habits.secondDose
    };
    return map;
  }
}

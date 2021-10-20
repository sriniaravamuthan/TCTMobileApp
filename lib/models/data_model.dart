/*
 * *
 *  Created by Gayathri Technologies Pvt. Ltd on 10/4/21 4:00 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 10/4/21 4:00 PM by Kanmalai.
 * /
 */

class DemographicFamily {
  String uid = "";
  Location location = new Location();
  Property property = new Property();
  Habits habits = new Habits();
  List<Family> family = [];
  String docId = "";

  DemographicFamily(
      {this.location, this.property, this.habits, this.family, this.uid});

  DemographicFamily.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    property = json['property'] != null
        ? new Property.fromJson(json['property'])
        : null;
    habits =
        json['habits'] != null ? new Habits.fromJson(json['habits']) : null;
    if (json['family'] != null) {
      family = <Family>[];
      json['family'].forEach((v) {
        family.add(new Family.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    if (this.property != null) {
      data['property'] = this.property.toJson();
    }
    if (this.habits != null) {
      data['habits'] = this.habits.toJson();
    }
    if (this.family != null) {
      data['family'] = this.family.map((v) => v.toJson()).toList();
    }
    data['uid'] = this.uid;
    return data;
  }
}

class Location {
  String formNo = "";
  String projectCode = "";
  var villagesCode;
  var panchayatNo;
  var panchayatCode;
  var villageName;
  var maxCount;
  String streetName = "";
  String doorNumber = "";
  String contactPerson = "";
  String noOfFamilyMembers = "";
  String contactNumber = "";
  String name = "";

  Location(
      {this.formNo,
      this.projectCode,
      this.villagesCode,
      this.panchayatNo,
      this.panchayatCode,
      this.maxCount,
      this.villageName,
      this.streetName,
      this.doorNumber,
      this.contactPerson,
      this.noOfFamilyMembers,
      this.contactNumber});

  Location.fromJson(Map<String, dynamic> json) {
    formNo = json['formNo'];
    projectCode = json['projectCode'];
    villagesCode = json['villagesCode'];
    maxCount = json['maxCount'];
    panchayatNo = json['panchayatNo'];
    panchayatCode = json['panchayatCode'];
    villageName = json['villageName '];
    streetName = json['streetName '];
    doorNumber = json['doorNumber '];
    contactPerson = json['contactPerson '];
    contactNumber = json['contactNumber'];
    noOfFamilyMembers = json['noOfFamilyMembers '];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['formNo'] = this.formNo;
    data['projectCode'] = this.projectCode;
    data['villagesCode'] = this.villagesCode;
    data['maxCount'] = this.maxCount;
    data['panchayatNo'] = this.panchayatNo;
    data['panchayatCode'] = this.panchayatCode;
    data['villageName '] = this.villageName;
    data['streetName '] = this.streetName;
    data['doorNumber '] = this.doorNumber;
    data['contactPerson '] = this.contactPerson;
    data['contactNumber'] = this.contactNumber;
    data['noOfFamilyMembers '] = this.noOfFamilyMembers;
    return data;
  }
}

class Property {
  String statusofHouse = "";
  String typeofHouse = "";
  double toiletFacility = 0;
  double ownLand = 0;
  String wetLandInAcres = "";
  String dryLandInAcres = "";
  double ownVehicle = 0;
  String noOfVehicleOwn = "";
  String twoWheeler = "";
  String threeWheeler = "";
  String fourWheeler = "";
  String others = "";
  double ownLivestocks = 0;
  String cow = "";
  String buffalo = "";
  String bull = "";
  String hen = "";
  String pig = "";
  String goat = "";
  String sheep = "";
  String othersLive = "";
  String livestockCount = "";

  Property(
      {this.statusofHouse,
      this.typeofHouse,
      this.toiletFacility,
      this.ownLand,
      this.wetLandInAcres,
      this.dryLandInAcres,
      this.ownVehicle,
      this.noOfVehicleOwn,
      this.twoWheeler,
      this.threeWheeler,
      this.fourWheeler,
      this.others,
      this.ownLivestocks,
      this.cow,
      this.buffalo,
      this.bull,
      this.hen,
      this.pig,
      this.goat,
      this.sheep,
      this.othersLive,
      this.livestockCount});

  Property.fromJson(Map<String, dynamic> json) {
    statusofHouse = json['statusofHouse '];
    typeofHouse = json['typeofHouse '];
    toiletFacility = json['toiletFacility '];
    ownLand = json['ownLand '];
    wetLandInAcres = json['wetLandInAcres '];
    dryLandInAcres = json['dryLandInAcres '];
    ownVehicle = json['ownVehicle '];
    noOfVehicleOwn = json['noOfVehicleOwn'];
    twoWheeler = json['twoWheeler '];
    threeWheeler = json['threeWheeler '];
    fourWheeler = json['fourWheeler '];
    others = json['others  '];
    ownLivestocks = json['ownLivestocks '];
    cow = json['cow   '];
    buffalo = json['buffalo   '];
    bull = json['bull   '];
    hen = json['hen   '];
    goat = json['goat   '];
    sheep = json['sheep   '];
    pig = json['pig   '];
    othersLive = json['othersLive   '];
    livestockCount = json['livestockCount   '];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusofHouse '] = this.statusofHouse;
    data['typeofHouse '] = this.typeofHouse;
    data['toiletFacility '] = this.toiletFacility;
    data['ownLand '] = this.ownLand;
    data['wetLandInAcres '] = this.wetLandInAcres;
    data['dryLandInAcres '] = this.dryLandInAcres;
    data['ownVehicle '] = this.ownVehicle;
    data['noOfVehicleOwn'] = this.noOfVehicleOwn;
    data['twoWheeler '] = this.twoWheeler;
    data['threeWheeler '] = this.threeWheeler;
    data['fourWheeler '] = this.fourWheeler;
    data['others  '] = this.others;
    data['ownLivestocks '] = this.ownLivestocks;
    data['livestockType   '] = this.cow;
    data['livestockType   '] = this.bull;
    data['livestockType   '] = this.buffalo;
    data['livestockType   '] = this.hen;
    data['livestockType   '] = this.goat;
    data['livestockType   '] = this.sheep;
    data['livestockType   '] = this.pig;
    data['livestockType   '] = this.othersLive;
    data['livestockCount   '] = this.livestockCount;
    return data;
  }
}

class Habits {
  double anyMembersWhoSmoke = 0;
  double anyMembersWhoDrink = 0;
  double anyMembersWhoUseTobacco = 0;
  double isVaccinationDone = 0;
  String firstDose;
  String secondDose;

  Habits(
      {this.anyMembersWhoSmoke,
      this.anyMembersWhoDrink,
      this.anyMembersWhoUseTobacco,
      this.isVaccinationDone,
      this.firstDose,
      this.secondDose});

  Habits.fromJson(Map<String, dynamic> json) {
    anyMembersWhoSmoke = json['anyMembersWhoSmoke'];
    anyMembersWhoDrink = json['anyMembersWhoDrink '];
    anyMembersWhoUseTobacco = json['anyMembersWhoUseTobacco'];
    isVaccinationDone = json['isVaccinationDone'];
    firstDose = json['firstDose'];
    secondDose = json['secondDose'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['anyMembersWhoSmoke'] = this.anyMembersWhoSmoke;
    data['anyMembersWhoDrink '] = this.anyMembersWhoDrink;
    data['anyMembersWhoUseTobacco'] = this.anyMembersWhoUseTobacco;
    data['isVaccinationDone'] = this.isVaccinationDone;
    data['firstDose'] = this.firstDose;
    data['secondDose'] = this.secondDose;
    return data;
  }
}

class Family {
  String name = "";
  String position = "";
  String familyId = "";
  String aadharNumber = "";
  String relationship = "";
  String gender = "";
  String dob = "";
  int age = 0;
  String maritalStatus = "";
  double pregnantStatus = 0;
  String pregnantMonths = "";
  String bloodGroup = "";
  double physicallyChallenge = 0;
  String education = "";
  String occupation = "";
  String annualIncome = "";
  String mobileNumber = "";
  String mail = "";
  double smartphone = 0;
  String community = "";
  String caste = "";
  String physical = "";
  String photo = "";
  double govtInsurance = 0;
  double privateInsurance = 0;
  double oldPension = 0;
  double widowedPension = 0;
  double retirementPension = 0;

  double anyMembersWhoSmoke = 0;
  double anyMembersWhoDrink = 0;
  double drinkingUsage = 0;
  double stoppedBy = 0;
  String noOfYears = "";
  String whereTreatment = "";
  String whenTreatment = "";

  double anyMembersWhoUseTobacco = 0;
  double died = 0;
  double migrate = 0;
  String migrateReason = "";
  String diedUpdateBy = "";
  String diedUpdateDate = "";
  double isVaccinationDone = 0;
  String firstDose;
  String secondDose;

  String isExpanded = "Show More"; //  For internal purpose
  Family(
      {this.name,
      this.position,
      this.familyId,
      this.aadharNumber,
      this.relationship,
      this.gender,
      this.dob,
      this.age,
      this.maritalStatus,
      this.pregnantStatus,
      this.pregnantMonths,
      this.bloodGroup,
      this.physicallyChallenge,
      this.education,
      this.occupation,
      this.annualIncome,
      this.mobileNumber,
      this.mail,
      this.smartphone,
      this.community,
      this.caste,
      this.physical,
      this.photo,
      this.govtInsurance,
      this.privateInsurance,
      this.oldPension,
      this.widowedPension,
      this.retirementPension,
      this.anyMembersWhoSmoke,
      this.anyMembersWhoDrink,
      this.drinkingUsage,
      this.stoppedBy,
      this.noOfYears,
      this.whereTreatment,
      this.whenTreatment,
      this.anyMembersWhoUseTobacco,
      this.migrateReason,
      this.diedUpdateBy,
      this.diedUpdateDate,
      this.isVaccinationDone,
      this.firstDose,
      this.secondDose,
      this.isExpanded});

  Family.fromJson(Map<String, dynamic> json) {
    name = json['Name '];
    position = json['position '];
    familyId = json['familyId '];
    aadharNumber = json['aadharNumber '];
    relationship = json['relationship '];
    gender = json['gender '];
    dob = json['dob '];
    age = json['age '];
    maritalStatus = json['maritalStatus '];
    bloodGroup = json['bloodGroup '];
    physicallyChallenge = json['physicallyChallenge'];
    education = json['education '];
    occupation = json['occupation '];
    annualIncome = json['annualIncome  '];
    mobileNumber = json['mobileNumber  '];
    mail = json['mail '];
    smartphone = json['smartphone'];
    community = json['community '];
    caste = json['caste  '];
    physical = json['physical  '];
    photo = json['photo  '];
    anyMembersWhoSmoke = json['anyMembersWhoSmoke'];
    anyMembersWhoDrink = json['anyMembersWhoDrink '];
    anyMembersWhoUseTobacco = json['anyMembersWhoUseTobacco'];
    isVaccinationDone = json['isVaccinationDone'];
    firstDose = json['firstDose'];
    secondDose = json['secondDose'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name '] = this.name;
    data['position '] = this.position;
    data['familyId '] = this.familyId;

    data['aadharNumber '] = this.aadharNumber;
    data['relationship '] = this.relationship;
    data['gender '] = this.gender;
    data['dob '] = this.dob;
    data['age '] = this.age;
    data['maritalStatus '] = this.maritalStatus;
    data['bloodGroup '] = this.bloodGroup;
    data['physicallyChallenge'] = this.physicallyChallenge;
    data['education '] = this.education;
    data['occupation '] = this.occupation;
    data['annualIncome  '] = this.annualIncome;
    data['mobileNumber  '] = this.mobileNumber;
    data['mail '] = this.mail;
    data['smartphone'] = this.smartphone;
    data['community '] = this.community;
    data['caste  '] = this.caste;
    data['physical  '] = this.physical;
    data['photo  '] = this.photo;

    data['anyMembersWhoSmoke'] = this.anyMembersWhoSmoke;
    data['anyMembersWhoDrink '] = this.anyMembersWhoDrink;
    data['anyMembersWhoUseTobacco'] = this.anyMembersWhoUseTobacco;
    data['isVaccinationDone'] = this.isVaccinationDone;
    data['firstDose'] = this.firstDose;
    data['secondDose'] = this.secondDose;
    return data;
  }
}

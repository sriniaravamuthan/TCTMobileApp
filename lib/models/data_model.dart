/*
 * *
 *  Created by Dharmaraj, Kanmalai Technologies Pvt. Ltd on 10/4/21 4:00 PM.
 *  Copyright (c) 2021. All rights reserved.
 *  Last modified 10/4/21 4:00 PM by Kanmalai.
 * /
 */

class DemographicFamily {
  Location location;
  Property property;
  Habits habits;
  List<Family> family;

  DemographicFamily({this.location, this.property, this.habits, this.family});

  DemographicFamily.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    property = json['property'] != null
        ? new Property.fromJson(json['property'])
        : null;
    habits =
    json['habits'] != null ? new Habits.fromJson(json['habits']) : null;
    if (json['family'] != null) {
      family = new List<Family>();
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
    return data;
  }
}

class Location {
  int formNo;
  int projectCode;
  String villagesCode;
  int panchayatNo;
  String panchayatCode;
  String villageName;
  String streetName;
  int doorNumber;
  String contactPerson;
  int noOfFamilyMembers;

  Location(
      {this.formNo,
        this.projectCode,
        this.villagesCode,
        this.panchayatNo,
        this.panchayatCode,
        this.villageName,
        this.streetName,
        this.doorNumber,
        this.contactPerson,
        this.noOfFamilyMembers});

  Location.fromJson(Map<String, dynamic> json) {
    formNo = json['formNo'];
    projectCode = json['projectCode'];
    villagesCode = json['villagesCode'];
    panchayatNo = json['panchayatNo'];
    panchayatCode = json['panchayatCode'];
    villageName = json['villageName '];
    streetName = json['streetName '];
    doorNumber = json['doorNumber '];
    contactPerson = json['contactPerson '];
    noOfFamilyMembers = json['noOfFamilyMembers '];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['formNo'] = this.formNo;
    data['projectCode'] = this.projectCode;
    data['villagesCode'] = this.villagesCode;
    data['panchayatNo'] = this.panchayatNo;
    data['panchayatCode'] = this.panchayatCode;
    data['villageName '] = this.villageName;
    data['streetName '] = this.streetName;
    data['doorNumber '] = this.doorNumber;
    data['contactPerson '] = this.contactPerson;
    data['noOfFamilyMembers '] = this.noOfFamilyMembers;
    return data;
  }
}

class Property {
  String statusofHouse;
  String typeofHouse;
  bool toiletFacility;
  bool ownLand;
  String wetLandInAcres;
  String dryLandInAcres;
  bool ownVehicle;
  String noOfVehicleOwn;
  String twoWheeler;
  String threeWheeler;
  String fourWheeler;
  String others;
  bool ownLivestocks;
  String livestockType;
  String livestockCount;

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
        this.livestockType,
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
    livestockType = json['livestockType   '];
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
    data['livestockType   '] = this.livestockType;
    data['livestockCount   '] = this.livestockCount;
    return data;
  }
}

class Habits {
  bool anyMembersWhoSmoke;
  bool anyMembersWhoDrink;
  bool anyMembersWhoUseTobacco;

  Habits(
      {this.anyMembersWhoSmoke,
        this.anyMembersWhoDrink,
        this.anyMembersWhoUseTobacco});

  Habits.fromJson(Map<String, dynamic> json) {
    anyMembersWhoSmoke = json['anyMembersWhoSmoke'];
    anyMembersWhoDrink = json['anyMembersWhoDrink '];
    anyMembersWhoUseTobacco = json['anyMembersWhoUseTobacco'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['anyMembersWhoSmoke'] = this.anyMembersWhoSmoke;
    data['anyMembersWhoDrink '] = this.anyMembersWhoDrink;
    data['anyMembersWhoUseTobacco'] = this.anyMembersWhoUseTobacco;
    return data;
  }
}

class Family {
  String name;
  int aadharNumber;
  String relationship;
  String gender;
  String dob;
  int age;
  String maritalStatus;
  String bloodGroup;
  bool physicallyChallenge;
  String education;
  String occupation;
  int annualIncome;
  int mobileNumber;
  String mail;
  bool smartphone;
  String community;
  String caste;
  String photo;

  Family(
      {this.name,
        this.aadharNumber,
        this.relationship,
        this.gender,
        this.dob,
        this.age,
        this.maritalStatus,
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
        this.photo});

  Family.fromJson(Map<String, dynamic> json) {
    name = json['Name '];
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
    photo = json['photo  '];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name '] = this.name;
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
    data['photo  '] = this.photo;
    return data;
  }
}
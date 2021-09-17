import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:localstore/localstore.dart';

final firestoreInstance = FirebaseFirestore.instance;
const String collectionVillageCode = "villageCode";
const String collectionVillageName = "villageName";
const String collectionGender = "gender";
const String collectionRelation = "relationshipFamily";
const String mapRelation = "relationShip";
const String collectionEducation = "education";
const String collectionStatusHouse = "statusHouseType";
const String mapStatusHouse = "statusHouse";
const String collectionTypeHouse = "typeHouse";
const String collectionMaritalStatus = "MaritalStatus";
const String collectionBusiness = "business";
const String collectionBloodGroup = "bloodGroup";
const String collectionSection = "section";
const String mapFamilyMembers = "familyMembers";
const String collectionAnnualIncome = "annualIncome";
const String mapAnnualIncome = "income";
const String collectionCount = "DemographicCount";

//Survey app
final db = Localstore.instance;
/*
const String searchCampaignURL = "https://run.mocky.io/v3/a0e2689d-e0a3-4609-8973-5b00222609e8";
*/
const String searchCampaignURL = "http://tctmh.eastus.cloudapp.azure.com:8080/tctsurvey/api/campaign/search";
// const String surveyCampaignURL = "https://run.mocky.io/v3/28e4af66-ec82-4a14-b54a-2e364b2b05c9";
const String surveyCampaignURL = "http://tctmh.eastus.cloudapp.azure.com:8080/tctsurvey/api/campaign/question";
// const String surveySaveCampaignURL = "https://run.mocky.io/v3/417138ce-10e3-47fc-b2a0-eeaa441c9242";
const String surveySaveCampaignURL = "http://tctmh.eastus.cloudapp.azure.com:8080/tctsurvey/api/campaign/answer";
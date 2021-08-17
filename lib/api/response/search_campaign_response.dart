class SearchCampaignResponse {
  String aPIName;
  bool isError;
  Data data;

  SearchCampaignResponse({this.aPIName, this.isError, this.data});

  SearchCampaignResponse.fromJson(Map<String, dynamic> json) {
    aPIName = json['APIName'];
    isError = json['isError'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['APIName'] = this.aPIName;
    data['isError'] = this.isError;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<CampaignList> campaignList;
  String campaignId;
  String campaignName;
  String campaignDescription;
  String objectiveName;
  String campaignPopulation;
  String complete;
  String pending;
  int totalRecords;
  int limit;
  String page;
  int pages;

  Data(
      {this.campaignList,
        this.campaignId,
        this.campaignName,
        this.campaignDescription,
        this.objectiveName,
        this.campaignPopulation,
        this.complete,
        this.pending,
        this.totalRecords,
        this.limit,
        this.page,
        this.pages});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['campaignList'] != null) {
      campaignList = new List<CampaignList>();
      json['campaignList'].forEach((v) {
        campaignList.add(new CampaignList.fromJson(v));
      });
    }
    campaignId = json['campaignId'];
    campaignName = json['campaignName'];
    campaignDescription = json['campaignDescription'];
    objectiveName = json['objectiveName'];
    campaignPopulation = json['campaignPopulation'];
    complete = json['Complete'];
    pending = json['Pending'];
    totalRecords = json['total Records'];
    limit = json['limit'];
    page = json['page'];
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.campaignList != null) {
      data['campaignList'] = this.campaignList.map((v) => v.toJson()).toList();
    }
    data['campaignId'] = this.campaignId;
    data['campaignName'] = this.campaignName;
    data['campaignDescription'] = this.campaignDescription;
    data['objectiveName'] = this.objectiveName;
    data['campaignPopulation'] = this.campaignPopulation;
    data['Complete'] = this.complete;
    data['Pending'] = this.pending;
    data['total Records'] = this.totalRecords;
    data['limit'] = this.limit;
    data['page'] = this.page;
    data['pages'] = this.pages;
    return data;
  }
}

class CampaignList {
  String familyId;
  String familyHeadName;
  String respondentName;
  String mobileNumber;
  String villageCode;
  String status;

  CampaignList(
      {this.familyId,
        this.familyHeadName,
        this.respondentName,
        this.mobileNumber,
        this.villageCode,
        this.status});

  CampaignList.fromJson(Map<String, dynamic> json) {
    familyId = json['familyId'];
    familyHeadName = json['familyHeadName'];
    respondentName = json['respondentName'];
    mobileNumber = json['mobileNumber'];
    villageCode = json['villageCode'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['familyId'] = this.familyId;
    data['familyHeadName'] = this.familyHeadName;
    data['respondentName'] = this.respondentName;
    data['mobileNumber'] = this.mobileNumber;
    data['villageCode'] = this.villageCode;
    data['Status'] = this.status;
    return data;
  }
}
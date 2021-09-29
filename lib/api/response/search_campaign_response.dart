class SearchCampaignResponse {
  List<Data> data;
  String message;
  bool error;
  String apiname;

  SearchCampaignResponse({this.data, this.message, this.error, this.apiname});

  SearchCampaignResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    error = json['error'];
    apiname = json['apiname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['error'] = this.error;
    data['apiname'] = this.apiname;
    return data;
  }
}

class Data {
  String campaignId;
  String campaignName;
  String campaignDescription;
  String objectiveName;
  String campaignPopulation;
  String complete;
  String pending;
  String totalRecords;
  int limit;
  int page;
  int pages;
  List<CampaignList> campaignList;

  Data(
      {this.campaignId,
      this.campaignName,
      this.campaignDescription,
      this.objectiveName,
      this.campaignPopulation,
      this.complete,
      this.pending,
      this.totalRecords,
      this.limit,
      this.page,
      this.pages,
      this.campaignList});

  Data.fromJson(Map<String, dynamic> json) {
    campaignId = json['campaignId'];
    campaignName = json['campaignName'];
    campaignDescription = json['campaignDescription'];
    objectiveName = json['objectiveName'];
    campaignPopulation = json['campaignPopulation'];
    complete = json['complete'];
    pending = json['pending'];
    totalRecords = json['totalRecords'];
    limit = json['limit'];
    page = json['page'];
    pages = json['pages'];
    if (json['campaignList'] != null) {
      campaignList = <CampaignList>[];
      json['campaignList'].forEach((v) {
        campaignList.add(new CampaignList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['campaignId'] = this.campaignId;
    data['campaignName'] = this.campaignName;
    data['campaignDescription'] = this.campaignDescription;
    data['objectiveName'] = this.objectiveName;
    data['campaignPopulation'] = this.campaignPopulation;
    data['complete'] = this.complete;
    data['pending'] = this.pending;
    data['totalRecords'] = this.totalRecords;
    data['limit'] = this.limit;
    data['page'] = this.page;
    data['pages'] = this.pages;
    if (this.campaignList != null) {
      data['campaignList'] = this.campaignList.map((v) => v.toJson()).toList();
    }
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
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['familyId'] = this.familyId;
    data['familyHeadName'] = this.familyHeadName;
    data['respondentName'] = this.respondentName;
    data['mobileNumber'] = this.mobileNumber;
    data['villageCode'] = this.villageCode;
    data['status'] = this.status;
    return data;
  }
}

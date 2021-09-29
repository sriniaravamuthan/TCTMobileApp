class SearchCampaignRequest {
  String campaignID;
  String campaignName;
  String villageCode;
  String languageCode;
  String searchKey;
  int limit;
  int page;

  SearchCampaignRequest(
      {this.campaignID,
      this.campaignName,
      this.villageCode,
      this.languageCode,
      this.searchKey,
      this.limit,
      this.page});
  SearchCampaignRequest.fromJson(Map<String, dynamic> json) {
    campaignID = json['campaignID'];
    campaignName = json['campaignName'];
    villageCode = json['villageCode'];
    languageCode = json['languageCode'];
    searchKey = json['searchKey'];
    limit = json['limit'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['campaignID'] = this.campaignID;
    data['campaignName'] = this.campaignName;
    data['villageCode'] = this.villageCode;
    data['languageCode'] = this.languageCode;
    data['searchKey'] = this.searchKey;
    data['limit'] = this.limit;
    data['page'] = this.page;
    return data;
  }
}

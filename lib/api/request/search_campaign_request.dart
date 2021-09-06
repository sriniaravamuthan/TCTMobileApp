class SearchCampaignRequest {
  String campaignID;
  String campaignName;
  String villageCode;
  String languageCode;
  String searchKey;


  SearchCampaignRequest(
      {this.campaignID,
      this.campaignName,
      this.villageCode,
      this.languageCode,this.searchKey});

  SearchCampaignRequest.fromJson(Map<String, dynamic> json) {
    campaignID = json['campaignID'];
    campaignName = json['campaignName'];
    villageCode = json['villageCode'];
    languageCode = json['languageCode'];
    searchKey = json['searchKey'];
  }
}

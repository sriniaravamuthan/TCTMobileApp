class SearchCampaignRequest {
  String campaignId;
  String campaignName;
  String villageCode;
  String languageCode;
  String searchKey;


  SearchCampaignRequest(
      {this.campaignId,
      this.campaignName,
      this.villageCode,
      this.languageCode,this.searchKey});

  SearchCampaignRequest.fromJson(Map<String, dynamic> json) {
    campaignId = json['campaignId'];
    campaignName = json['campaignName'];
    villageCode = json['villageCode'];
    languageCode = json['languageCode'];
    searchKey = json['searchKey'];
  }
}

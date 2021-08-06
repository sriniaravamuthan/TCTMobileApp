class SurveyQuestionnaireResponse {
  String aPIName;
  bool isError;
  Data data;

  SurveyQuestionnaireResponse({this.aPIName, this.isError, this.data});

  SurveyQuestionnaireResponse.fromJson(Map<String, dynamic> json) {
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
  List<Sections> sections;
  String campaignId;
  String campaignName;
  String campaignDescription;
  String objectiveName;
  String respondentName;

  Data(
      {this.sections,
        this.campaignId,
        this.campaignName,
        this.campaignDescription,
        this.objectiveName,
        this.respondentName});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['sections'] != null) {
      sections = new List<Sections>();
      json['sections'].forEach((v) {
        sections.add(new Sections.fromJson(v));
      });
    }
    campaignId = json['campaignId'];
    campaignName = json['campaignName'];
    campaignDescription = json['campaignDescription:'];
    objectiveName = json['objectiveName'];
    respondentName = json['respondentName:'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sections != null) {
      data['sections'] = this.sections.map((v) => v.toJson()).toList();
    }
    data['campaignId'] = this.campaignId;
    data['campaignName'] = this.campaignName;
    data['campaignDescription:'] = this.campaignDescription;
    data['objectiveName'] = this.objectiveName;
    data['respondentName:'] = this.respondentName;
    return data;
  }
}

class Sections {
  String sectionId;
  String sectionName;
  List<Questions> questions;

  Sections({this.sectionId, this.sectionName, this.questions});

  Sections.fromJson(Map<String, dynamic> json) {
    sectionId = json['sectionId'];
    sectionName = json['sectionName'];
    if (json['questions'] != null) {
      questions = new List<Questions>();
      json['questions'].forEach((v) {
        questions.add(new Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sectionId'] = this.sectionId;
    data['sectionName'] = this.sectionName;
    if (this.questions != null) {
      data['questions'] = this.questions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  String questionName;
  String optionType;
  List<Options> options;
  String questionId;

  Questions(
      {this.questionName, this.optionType, this.options, this.questionId});

  Questions.fromJson(Map<String, dynamic> json) {
    questionName = json['questionName'];
    optionType = json['optionType'];
    if (json['options'] != null) {
      options = new List<Options>();
      json['options'].forEach((v) {
        options.add(new Options.fromJson(v));
      });
    }
    questionId = json['questionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionName'] = this.questionName;
    data['optionType'] = this.optionType;
    if (this.options != null) {
      data['options'] = this.options.map((v) => v.toJson()).toList();
    }
    data['questionId'] = this.questionId;
    return data;
  }
}

class Options {
  String optionId;
  String optionName;

  Options({this.optionId, this.optionName});

  Options.fromJson(Map<String, dynamic> json) {
    optionId = json['optionId'];
    optionName = json['optionName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['optionId'] = this.optionId;
    data['optionName'] = this.optionName;
    return data;
  }
}
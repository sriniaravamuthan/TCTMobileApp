class SurveyQuestionnaireResponse {
  List<Data> data;
  String message;
  bool error;
  String apiname;

  SurveyQuestionnaireResponse(
      {this.data, this.message, this.error, this.apiname});

  SurveyQuestionnaireResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
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
  String respondentName;
  String respondentId;
  List<Sections> sections;

  Data(
      {this.campaignId,
        this.campaignName,
        this.campaignDescription,
        this.objectiveName,
        this.respondentName,
        this.respondentId,
        this.sections});

  Data.fromJson(Map<String, dynamic> json) {
    campaignId = json['campaignId'];
    campaignName = json['campaignName'];
    campaignDescription = json['campaignDescription'];
    objectiveName = json['objectiveName'];
    respondentName = json['respondentName'];
    respondentId = json['respondentId'];
    if (json['sections'] != null) {
      sections = new List<Sections>();
      json['sections'].forEach((v) {
        sections.add(new Sections.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['campaignId'] = this.campaignId;
    data['campaignName'] = this.campaignName;
    data['campaignDescription'] = this.campaignDescription;
    data['objectiveName'] = this.objectiveName;
    data['respondentName'] = this.respondentName;
    data['respondentId'] = this.respondentId;
    if (this.sections != null) {
      data['sections'] = this.sections.map((v) => v.toJson()).toList();
    }
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
  String questionId;
  String questionName;
  String responseType;
  List<Options> options;

  Questions(
      {this.questionId, this.questionName, this.responseType, this.options});

  Questions.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    questionName = json['questionName'];
    responseType = json['responseType'];
    if (json['options'] != null) {
      options = new List<Options>();
      json['options'].forEach((v) {
        options.add(new Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionId'] = this.questionId;
    data['questionName'] = this.questionName;
    data['responseType'] = this.responseType;
    if (this.options != null) {
      data['options'] = this.options.map((v) => v.toJson()).toList();
    }
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
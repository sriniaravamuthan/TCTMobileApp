class SaveSurveyRequest {
  String campaignId;
  String familyId;
  String languageCode;
  List<Sections> sections;

  SaveSurveyRequest(
      {this.campaignId, this.familyId, this.languageCode, this.sections});

  SaveSurveyRequest.fromJson(Map<String, dynamic> json) {
    campaignId = json['campaignId'];
    familyId = json['familyId'];
    languageCode = json['languageCode:'];
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
    data['familyId'] = this.familyId;
    data['languageCode:'] = this.languageCode;
    if (this.sections != null) {
      data['sections'] = this.sections.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sections {
  String sectionId;
  List<Questions> questions;

  Sections({this.sectionId, this.questions});

  Sections.fromJson(Map<String, dynamic> json) {
    sectionId = json['sectionId'];
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
    if (this.questions != null) {
      data['questions'] = this.questions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  String questionId;
  String answerName;
  List<Options> options;

  Questions({this.questionId, this.answerName, this.options});

  Questions.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    answerName = json['answerName'];
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
    data['answerName'] = this.answerName;
    if (this.options != null) {
      data['options'] = this.options.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  String optionId;

  Options({this.optionId});

  Options.fromJson(Map<String, dynamic> json) {
    optionId = json['optionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['optionId'] = this.optionId;
    return data;
  }
}
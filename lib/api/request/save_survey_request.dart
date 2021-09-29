class SaveSurveyRequest {
  String campaignId;
  String objectiveId;
  String familyId;
  String villageCode;
  String languageCode;
  List<Questions> questions;

  SaveSurveyRequest(
      {this.campaignId,
      this.objectiveId,
      this.familyId,
      this.villageCode,
      this.languageCode,
      this.questions});

  SaveSurveyRequest.fromJson(Map<String, dynamic> json) {
    campaignId = json['campaignId'];
    objectiveId = json['objectiveId'];
    familyId = json['familyId'];
    villageCode = json['villageCode'];
    languageCode = json['languageCode'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions.add(new Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['campaignId'] = this.campaignId;
    data['objectiveId'] = this.objectiveId;
    data['familyId'] = this.familyId;
    data['villageCode'] = this.villageCode;
    data['languageCode'] = this.languageCode;
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
      options = <Options>[];
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

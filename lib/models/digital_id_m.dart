class DigitalIDModel {

  String? title = '';
  String? frontImage = '';
  String? backImage = '';
  String? selfieImage = '';
  String? backFaceImage = '';
  List<String>? lsIDCard = [];
  bool? completedSetpUpID = false;

  DigitalIDModel fromDb(Map<String, dynamic> json){
    title = json['title'] ?? title;
    frontImage = json['front'] ?? frontImage;
    backImage = json['back'] ?? backImage;
    selfieImage = json['front_face'] ?? selfieImage;
    backFaceImage = json['back_face'] ?? backFaceImage;
    completedSetpUpID = json['completed'] ?? completedSetpUpID;

    lsIDCard = [
      frontImage!,
      backImage!,
      selfieImage!,
    ];
    return this; 
  }

  Map<String, dynamic> toJson(DigitalIDModel model){
    return {
      'title': model.title,
      'front': model.frontImage,
      'back': model.backImage,
      'front_face': model.selfieImage,
      'back_face': model.backFaceImage,
      'ls_ids': model.lsIDCard,
      'completed': model.completedSetpUpID
    };
  }
  
}
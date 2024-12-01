class UserModel {
  String? token;
  String? description;
  String? email;
  String? phoneNo;

  UserModel({this.token,this.description,this.email,this.phoneNo});

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    phoneNo =json['user']['doctor_mobile'];
    email =json['user']['email'];
    description =json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    return data;
  }
}

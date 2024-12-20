class UserModel {
  String? token;
  String? name;
  String? userId;
  String? email;
  String? phoneNo;

  UserModel({this.token,this.name,this.email,this.phoneNo,this.userId});

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    phoneNo =json['user']['doctor_mobile'];
    userId =json['user']['id'].toString();
    email =json['user']['email'];
    name =json['user']['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    return data;
  }
}

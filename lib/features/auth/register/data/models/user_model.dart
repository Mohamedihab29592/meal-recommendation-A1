class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? image;


  UserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.image,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['uId'] = uId;
    data['image'] = image;

    return data;
  }
}
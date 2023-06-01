class UserModel {
  int id =0;
  String? name;
  String? username;
  String? email;
  String? phone;
  String? website;

  UserModel(
      { required this.id,
      this.name,
      this.username,
      this.email,
      this.phone,
      this.website});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['phone'] = phone;
    data['website'] = website;
    return data;
  }
}

class UserModel {
  String id;
  String name;
  String email;
  String photo;
  String phone;
  String area;
  String college;
  List<String> posts;

  UserModel({this.id, this.name, this.email, this.photo, this.phone, this.area, this.college, this.posts});

  UserModel.fromJson(Map<String, dynamic> json, docID) {
    id = docID;
    name = json['name'];
    email = json['email'];
    photo = json['photo'];
    phone = json['phone'];
    area = json['area'];
    college = json['college'];
    posts = json['posts'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['photo'] = this.photo;
    data['phone'] = this.phone;
    data['posts'] = this.posts;
    data['area'] = this.area;
    data['college'] = this.college;
    return data;
  }
}

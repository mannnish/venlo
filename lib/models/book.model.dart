class BookModel {
  String title;
  String publication;
  String author;
  String ownerId;
  String ownerName;
  String ownerPhone;
  String createdAt;
  int views;
  bool sold;
  String photoUrl;

  BookModel({
    this.title,
    this.publication,
    this.author,
    this.ownerId,
    this.ownerName,
    this.ownerPhone,
    this.createdAt,
    this.views,
    this.sold,
    this.photoUrl,
  });

  BookModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    publication = json['publication'];
    author = json['author'];
    ownerId = json['owner_id'];
    ownerName = json['owner_name'];
    ownerPhone = json['owner_phone'];
    createdAt = json['created_at'];
    views = json['views'];
    sold = json['sold'];
    photoUrl = json['photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['publication'] = this.publication;
    data['author'] = this.author;
    data['owner_id'] = this.ownerId;
    data['owner_name'] = this.ownerName;
    data['owner_phone'] = this.ownerPhone;
    data['created_at'] = this.createdAt;
    data['views'] = this.views;
    data['sold'] = this.sold;
    data['photo_url'] = this.photoUrl;
    return data;
  }
}

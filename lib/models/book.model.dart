import 'package:cloud_firestore/cloud_firestore.dart';

class BookModel {
  String id;
  String title;
  String publication;
  String author;
  String ownerId;
  String ownerName;
  String ownerPhone;
  DateTime createdAt;
  int views;
  bool sold;
  List photoUrl;
  List categories;

  BookModel({
    this.id,
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
    this.categories,
  });

  BookModel.fromJson(Map<String, dynamic> json, id) {
    this.id = id;
    title = json['title'];
    publication = json['publication'];
    author = json['author'];
    ownerId = json['owner_id'];
    ownerName = json['owner_name'];
    ownerPhone = json['owner_phone'];
    Timestamp ts = json['created_at'];
    createdAt = DateTime.fromMicrosecondsSinceEpoch(ts.microsecondsSinceEpoch);
    // createdAt = DateTime.now();
    views = json['views'];
    sold = json['sold'];
    photoUrl = json['photo_url'].cast<String>();
    categories = json['categories'].cast<String>();
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
    data['categories'] = this.categories;
    return data;
  }

  bool doesContain(String query) {
    if (this.title.toLowerCase().contains(query.toLowerCase())) return true;
    if (this.publication.toLowerCase().contains(query.toLowerCase())) return true;
    if (this.author.toLowerCase().contains(query.toLowerCase())) return true;
    if (this.ownerName.toLowerCase().contains(query.toLowerCase())) return true;
    return false;
  }
}

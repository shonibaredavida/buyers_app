class Sellers {
  String? uid;
  String? name;
  String? email;
  String? photoUrl;
  String? status;
  String? ratings;

  Sellers(
      {this.name,
      this.uid,
      this.email,
      this.status,
      this.ratings,
      this.photoUrl});
  Sellers.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uid = json['uid'];
    ratings = json['ratings'];
    email = json['email'];
    photoUrl = json['photoUrl'];
    status = json['status'];
  }
}

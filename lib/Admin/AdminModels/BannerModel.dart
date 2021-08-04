class BannerModel {
  List<String> url;

  BannerModel({this.url});

  Map<String, dynamic> toMap() {
    return {
      'url': List<dynamic>.from(url.map((e) => e)),
    };
  }

  factory BannerModel.fromFirestore(Map<String, dynamic> firestore) {
    if (firestore == null) return null;

    return BannerModel(
      url: List<String>.from(firestore['url'].map((x) => x)),
    );
  }
}

class Pioneer {
  String name;
  String country;
  String language;
  String bio;
  String img;

  Pioneer({
    required this.name,
    required this.country,
    required this.language,
    required this.bio,
    required this.img,
  });

  static Pioneer fromJson(Map<String, dynamic> json) => Pioneer(
    name: json['name'], 
    country: json['country'], 
    language: json['language'],
    bio: json['bio'], 
    img: json['img']);
}

class WANews {
  String title, description, category, experience, payment;

  WANews(
      {required this.title,
      required this.description,
      required this.payment,
      required this.category,
      required this.experience});

  factory WANews.fromJson(Map<String, dynamic> map) {
    return WANews(
        title: map['title'],
        description: map['description'],
        payment: map['payment'],
        category: map['category'],
        experience: map['experience']);
  }
}

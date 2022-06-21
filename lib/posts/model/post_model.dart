class Post {
  late int id;
  late int userId;
  late String title;
  late String body;

  Post({
    this.id = 0,
    this.userId = 0,
    this.body = '',
    this.title = '',
  });

  Post.fromJason(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
    };
  }
}

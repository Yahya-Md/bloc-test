import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../model/post_model.dart';

class PostRepository {
  String scheme = 'https';
  String host = 'jsonplaceholder.typicode.com';
  String postPath = 'posts';
  final Client client;
  PostRepository(this.client);
  Future<List<Post>> getPosts() async {
    try {
      List<Post> posts = [];
      Uri url = Uri(scheme: scheme, host: host, path: postPath);
      Response response = await client.get(url);
      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body);
        for (var item in body) {
          posts.add(Post.fromJason(item));
        }
        return posts;
      } else {
        throw '${response.statusCode}';
      }
    } catch (e) {
      throw FormatException(e.toString());
    }
  }

  Future<Post> getPost(int id) async {
    try {
      Uri url = Uri(scheme: scheme, host: host, path: postPath);
      Response response = await client.get(url);
      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body);
        return Post.fromJason(body);
      } else {
        throw '${response.statusCode}';
      }
    } catch (e) {
      throw FormatException(e.toString());
    }
  }
}

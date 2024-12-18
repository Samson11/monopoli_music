import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:monopoli/models/audio/index.dart';
import 'package:monopoli/models/audio/models.dart';
import 'package:monopoli/models/home/index.dart';
import 'package:monopoli/models/home/top_content.dart';
import 'package:monopoli/models/playlist/index.dart';

const baseURL = 'https://spotify-scraper.p.rapidapi.com/v1';
const headers = {
  'Content-Type': 'application/json',
  'x-rapidapi-key': '2f7b27745bmsh4c535726654ab8fp1cbecbjsnad90f63e6dda',
  // 'a317b8b4c8mshd4dbc5fa0caf658p1335d4jsn5ba5d44faa36',
  // '0dec7e90f4msh1c806f9ede307efp1eeba2jsn9f6cade779d1',
  'x-rapidapi-host': 'spotify-scraper.p.rapidapi.com',
};

class MusicService {
  static Future<ResponseData> search(String query) async {
    var res = await http.get(
      Uri.parse('$baseURL/search?term=$query&type=all'),
      headers: headers,
    );

    var data = jsonDecode(res.body);

    return ResponseData.fromJson(data);
  }

  static Future<AudioApiResponse> getTrackURL(
    String trackId,
  ) async {
    var res = await http.get(
      Uri.parse('$baseURL/track/download?track=$trackId'),
      headers: headers,
    );

    var data = jsonDecode(res.body);
    return AudioApiResponse.fromJson(data);
  }

  static Future<HomeModel> getHome() async {
    var res = await http.get(
      Uri.parse('$baseURL/home'),
      headers: headers,
    );

    var data = jsonDecode(res.body);

    return HomeModel.fromJSON(data);
  }

  static Future<SpotifySection> getTodaysHome() async {
    var res = await http.get(
      Uri.parse('$baseURL/home/section?sectionId=0JQ5DAuChZYPe9iDhh2mJz'),
      headers: headers,
    );

    var data = jsonDecode(res.body);

    return SpotifySection.fromJson(data);
  }

  static Future<SpotifyPlaylist> getPlayList(String id) async {
    var res = await http.get(
      Uri.parse('$baseURL/playlist/contents?playlistId=$id'),
      headers: headers,
    );

    var data = jsonDecode(res.body);
    return SpotifyPlaylist.fromJSON(data);
  }
}

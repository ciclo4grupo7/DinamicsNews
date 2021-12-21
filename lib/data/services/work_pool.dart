import 'dart:convert';
import 'package:dynamics_news/domain/models/wanews.dart';
import 'package:dynamics_news/domain/services/misiontic_interface.dart';
import 'package:http/http.dart' as http;

class WorkPoolService implements MisionTicService {
  final String baseUrl = 'misiontic-2022-uninorte.herokuapp.com';
  //final String apiKey = 'wNLombyTzPIjLjkfp/aohu5b0Xy.iOM.4Sj4Q3.s9Ri9riyE6y5E2';
  final String apiKey = 'OqnT51YiWJYw1SlQsAUXw./W00jjL4a/hhJ9/ZBQJRoig0UXQgScm';

  @override
  Future<List<WANews>> fecthData({int limit = 5, Map? map}) async {
    var queryParameters = {'limit': limit.toString()};
    var uri = Uri.https(baseUrl, '/jobs', queryParameters);
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // We add our service ApiKey to the request headers
        'key': apiKey
      },
    );
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      final List<WANews> jobs = [];
      for (var job in res['jobs']) {
        jobs.add(WANews.fromJson(job));
      }
      return jobs;
    } else {
      throw Exception('Error on request');
    }
  }
}

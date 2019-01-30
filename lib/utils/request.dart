import 'package:youxia/utils/config.dart' as config;
import 'package:http/http.dart' as http;

class Request {
  static String _getDistUrl(url){
    return url.startsWith('http') ? url : config.baseUrl + url;
  }
  static get(url, {Map<String, String> headers}) {
    var distUrl = _getDistUrl(url);
    return http.get(distUrl,headers: headers).then((val) => val.body);
  }

  static post(String url, {Map<String, String> headers}) {
    var distUrl = _getDistUrl(url);
    return http.post(distUrl,headers: headers).then((val) => val.body);
  }
}
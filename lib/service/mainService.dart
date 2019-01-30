import 'package:youxia/utils/request.dart';
import 'package:youxia/pages/main/types/newsItem.dart';

class MainService {
  static Future<NewsData> getNewsData({int pageNo=10,String eid=''}) async {
    return NewsData(await Request.get('https://api3.ali213.net/feedearn/indexdatabynavtest?num=$pageNo&nid=1&eid=${eid.isEmpty?'':eid}'));
  }
}

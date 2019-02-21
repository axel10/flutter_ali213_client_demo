const baseUrl = 'http://192.168.0.5:8080';

class Config {
  static const horizontalPadding = 10.0;
  static const USER_TOKEN_KEY = 'user_token';

  /// 用户的头像字段要存在本地
  static const USER_AVATAR_KEY = 'user_avatar';
  static const double INDEX_APPBAR_HEIGHT = 50;

  static const USER_DATA_KEY = 'user_data';

  //新闻栏目数据key
  static const CATEGORY_CACHE_KEY = 'Data_List<Category>';

  //新闻条目数据。后面跟_$id来作为本地存储的key
  static const NEWS_CACHE_KEY = 'Data_News';

  /// 由于游侠api无法获取是否已经点赞过的数据，所以点赞记录只能存在本地。
  /// likeDict是保存点赞记录的json，通过这个key在SharedPreferences中获得json字符串
  static const LIKE_DICT = 'like_dict';
  static const NEWS_COLLECTION_LIST_KEY = 'news_list';
  static const GUIDE_COLLECTION_LIST_KEY = 'guide_list';

  static const GUIDE_SEARCH_HISTORY_WORD = 'SEARCH_WORD';

  static const GUIDE_APP_ID = '5';
  static const NEWS_APP_ID = '1';

  static const NEWS_SEARCH_HISTORY = 'NEWS_SEARCH_HISTORY';
}

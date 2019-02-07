

const baseUrl = 'http://192.168.0.5:8080';

class Config{
  static const horizontalPadding = 10.0;
  static const USER_TOKEN_KEY = 'user_token';
  /// 用户的头像字段要存在本地
  static const USER_AVATAR_KEY = 'user_avatar';
}

/// 由于游侠api无法获取是否已经点赞过的数据，所以点赞记录只能存在本地。
/// likeDict是保存点赞记录的json，通过这个key在SharedPreferences中获得json字符串
const LIKE_DICT = 'like_dict';
const NEWS_COLLECTION_LIST_KEY = 'news_list';
const GUIDE_COLLECTION_LIST_KEY = 'guide_list';
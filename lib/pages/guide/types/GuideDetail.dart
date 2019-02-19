import 'dart:convert' show json;

class GuideDetail {

  List<GuideArticleListItem> hotgl;
  List<GuideTag> hottagarr;
  List<GuideArticleListItem> newgl;
  List<GuideArticleListItem> yjtwyfyarr;
  List<GuideSection> yjwbptarr;
  List<GuideSection> yjwbygdarr;
  GuideMetadata data;
  GuideImgData gallery;
  VideoGuide videoGuide;
  ImgTextGuide imgTextGuide;
  GuideSection illustration;

  GuideDetail.fromParams({this.hotgl, this.hottagarr, this.newgl, this.yjtwyfyarr, this.yjwbptarr, this.yjwbygdarr, this.data, this.gallery, this.videoGuide, this.imgTextGuide, this.illustration});

  factory GuideDetail(jsonStr) => jsonStr == null ? null : jsonStr is String ? new GuideDetail.fromJson(json.decode(jsonStr)) : new GuideDetail.fromJson(jsonStr);

  GuideDetail.fromJson(jsonRes) {
    hotgl = jsonRes['hotgl'] == null ? null : [];

    for (var hotglItem in hotgl == null ? [] : jsonRes['hotgl']){
      hotgl.add(hotglItem == null ? null : new GuideArticleListItem.fromJson(hotglItem));
    }

    hottagarr = jsonRes['hottagarr'] == null ? null : [];

    for (var hottagarrItem in hottagarr == null ? [] : jsonRes['hottagarr']){
      hottagarr.add(hottagarrItem == null ? null : new GuideTag.fromJson(hottagarrItem));
    }

    newgl = jsonRes['newgl'] == null ? null : [];

    for (var newglItem in newgl == null ? [] : jsonRes['newgl']){
      newgl.add(newglItem == null ? null : new GuideArticleListItem.fromJson(newglItem));
    }

    yjtwyfyarr = jsonRes['yjtwyfyarr'] == null ? null : [];

    for (var yjtwyfyarrItem in yjtwyfyarr == null ? [] : jsonRes['yjtwyfyarr']){
      yjtwyfyarr.add(yjtwyfyarrItem == null ? null : new GuideArticleListItem.fromJson(yjtwyfyarrItem));
    }

    yjwbptarr = jsonRes['yjwbptarr'] == null ? null : [];

    for (var yjwbptarrItem in yjwbptarr == null ? [] : jsonRes['yjwbptarr']){
      yjwbptarr.add(yjwbptarrItem == null ? null : new GuideSection.fromJson(yjwbptarrItem));
    }

    yjwbygdarr = jsonRes['yjwbygdarr'] == null ? null : [];

    for (var yjwbygdarrItem in yjwbygdarr == null ? [] : jsonRes['yjwbygdarr']){
      yjwbygdarr.add(yjwbygdarrItem == null ? null : new GuideSection.fromJson(yjwbygdarrItem));
    }

    data = jsonRes['data'] == null ? null : new GuideMetadata.fromJson(jsonRes['data']);
    gallery = jsonRes['ejtwzxarr'] == null ? null : new GuideImgData.fromJson(jsonRes['ejtwzxarr']);
    videoGuide = jsonRes['splcarr'] == null ? null : new VideoGuide.fromJson(jsonRes['splcarr']);
    imgTextGuide = jsonRes['twlcarr'] == null ? null : new ImgTextGuide.fromJson(jsonRes['twlcarr']);
    illustration = jsonRes['yjtwzygdarr'] == null ? null : new GuideSection.fromJson(jsonRes['yjtwzygdarr']);
  }

  @override
  String toString() {
    return '{"hotgl": $hotgl,"hottagarr": $hottagarr,"newgl": $newgl,"yjtwyfyarr": $yjtwyfyarr,"yjwbptarr": $yjwbptarr,"yjwbygdarr": $yjwbygdarr,"data": $data,"ejtwzxarr": $gallery,"splcarr": $videoGuide,"twlcarr": $imgTextGuide,"yjtwzygdarr": $illustration}';
  }
}

class GuideSection {

  int oid;
  String id;
  String mkname;
  List<GuideInlineItem> mkdata;

  GuideSection.fromParams({this.oid, this.id, this.mkname, this.mkdata});

  GuideSection.fromJson(jsonRes) {
    oid = jsonRes['oid'];
    id = jsonRes['id'];
    mkname = jsonRes['mkname'];
    mkdata = jsonRes['mkdata'] == null ? null : [];

    for (var mkdataItem in mkdata == null ? [] : jsonRes['mkdata']){
      mkdata.add(mkdataItem == null ? null : new GuideInlineItem.fromJson(mkdataItem));
    }
  }

  @override
  String toString() {
    return '{"oid": $oid,"id": ${id != null?'${json.encode(id)}':'null'},"mkname": ${mkname != null?'${json.encode(mkname)}':'null'},"mkdata": $mkdata}';
  }
}

class GuideArticleListItem {
  dynamic id;
  String pic;
  String title;
  String addtime;

  GuideArticleListItem.fromParams({this.id, this.pic, this.title,this.addtime});

  GuideArticleListItem.fromJson(jsonRes) {
    id = jsonRes['id'];
    pic = jsonRes['pic'];
    title = jsonRes['title'];
    addtime = jsonRes['addtime'];
  }
/*  @override
  String toString() {
    return '{"id": ${id != null?'${json.encode(id)}':'null'},"pic": ${pic != null?'${json.encode(pic)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'}}';
  }*/
}

class ImgTextGuide {

  String id;
  List<GuideArticleListItem> list;

  ImgTextGuide.fromParams({this.id, this.list});

  ImgTextGuide.fromJson(jsonRes) {
    id = jsonRes['id'];
    list = jsonRes['fengzhang'] == null ? null : [];

    for (var fengzhangItem in list == null ? [] : jsonRes['fengzhang']){
      list.add(fengzhangItem == null ? null : new GuideArticleListItem.fromJson(fengzhangItem));
    }
  }

  @override
  String toString() {
    return '{"id": ${id != null?'${json.encode(id)}':'null'},"fengzhang": $list}';
  }
}

class VideoGuide {
  String mkname;
  List<GuideArticleListItem> list;

  VideoGuide.fromParams({this.mkname, this.list});

  VideoGuide.fromJson(jsonRes) {
    mkname = jsonRes['mkname'];
    list = jsonRes['con'] == null ? null : [];

    for (var conItem in list == null ? [] : jsonRes['con']){
      list.add(conItem == null ? null : new GuideArticleListItem.fromJson(conItem));
    }
  }

  @override
  String toString() {
    return '{"mkname": ${mkname != null?'${json.encode(mkname)}':'null'},"con": $list}';
  }
}

class GuideImgData {

  String mkname;
  List<GuideImgGroup> mkdata;
  List<GuideImgItem> allMkdata=[];

  GuideImgData.fromParams({this.mkname, this.mkdata});

  GuideImgData.fromJson(jsonRes) {
    mkname = jsonRes['mkname'];
    mkdata = jsonRes['mkdata'] == null ? null : [];

    for (var mkdataItem in mkdata == null ? [] : jsonRes['mkdata']){
      GuideImgGroup dist = mkdataItem == null ? null : new GuideImgGroup.fromJson(mkdataItem);
      mkdata.add(dist);
      allMkdata.addAll(dist.children);
    }
  }

  @override
  String toString() {
    return '{"mkname": ${mkname != null?'${json.encode(mkname)}':'null'},"mkdata": $mkdata}';
  }
}

class GuideImgGroup {

  String id;
  String pic;
  String title;
  List<GuideImgItem> children;

  GuideImgGroup.fromParams({this.id, this.pic, this.title, this.children});

  GuideImgGroup.fromJson(jsonRes) {
    id = jsonRes['id'];
    pic = jsonRes['pic'];
    title = jsonRes['title'];
    children = jsonRes['children'] == null ? null : [];

    for (var childrenItem in children == null ? [] : jsonRes['children']){
      children.add(childrenItem == null ? null : new GuideImgItem.fromJson(childrenItem));
    }
  }

  @override
  String toString() {
    return '{"id": ${id != null?'${json.encode(id)}':'null'},"pic": ${pic != null?'${json.encode(pic)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"children": $children}';
  }
}

class GuideImgItem {

  String id;
  String pic;
  String title;

  GuideImgItem.fromParams({this.id, this.pic, this.title});

  GuideImgItem.fromJson(jsonRes) {
    id = jsonRes['id'];
    pic = jsonRes['pic'];
    title = jsonRes['title'];
  }

  @override
  String toString() {
    return '{"id": ${id != null?'${json.encode(id)}':'null'},"pic": ${pic != null?'${json.encode(pic)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'}}';
  }
}

class GuideMetadata {

  String bannerpic;
  String content;
  String id;
  String keyword;
  String name;
  String odayid;
  String seo_keyword;
  String seo_title;

  GuideMetadata.fromParams({this.bannerpic, this.content, this.id, this.keyword, this.name, this.odayid, this.seo_keyword, this.seo_title});

  GuideMetadata.fromJson(jsonRes) {
    bannerpic = jsonRes['bannerpic'];
    content = jsonRes['content'];
    id = jsonRes['id'];
    keyword = jsonRes['keyword'];
    name = jsonRes['name'];
    odayid = jsonRes['odayid'];
    seo_keyword = jsonRes['seo_keyword'];
    seo_title = jsonRes['seo_title'];
  }

  @override
  String toString() {
    return '{"bannerpic": ${bannerpic != null?'${json.encode(bannerpic)}':'null'},"content": ${content != null?'${json.encode(content)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"keyword": ${keyword != null?'${json.encode(keyword)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"odayid": ${odayid != null?'${json.encode(odayid)}':'null'},"seo_keyword": ${seo_keyword != null?'${json.encode(seo_keyword)}':'null'},"seo_title": ${seo_title != null?'${json.encode(seo_title)}':'null'}}';
  }
}


class GuideInlineItem {

  String id;
  String pic;
  String title;

  GuideInlineItem.fromParams({this.id, this.pic, this.title});

  GuideInlineItem.fromJson(jsonRes) {
    id = jsonRes['id'];
    pic = jsonRes['pic'];
    title = jsonRes['title'];
  }

  @override
  String toString() {
    return '{"id": ${id != null?'${json.encode(id)}':'null'},"pic": ${pic != null?'${json.encode(pic)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'}}';
  }
}

class GuideTag {
  String oid;
  String id;
  String title;

  GuideTag.fromParams({this.oid, this.id, this.title});

  GuideTag.fromJson(jsonRes) {
    oid = jsonRes['oid'].toString();
    id = jsonRes['id'];
    title = jsonRes['title'];
  }

  @override
  String toString() {
    return '{"oid": $oid,"id": ${id != null?'${json.encode(id)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'}}';
  }
}


import 'dart:convert' show json;

class Categorys {

  List<Category> list;

  Categorys.fromParams({this.list});

  factory Categorys(jsonStr) => jsonStr == null ? null : jsonStr is String ? new Categorys.fromJson(json.decode(jsonStr)) : new Categorys.fromJson(jsonStr);

  Categorys.fromJson(jsonRes) {
    list = jsonRes == null ? null : [];

    for (var listItem in list == null ? [] : list){
      list.add(listItem == null ? null : new Category.fromJson(listItem));
    }
  }

  @override
  String toString() {
    return '{"json_list": $list}';
  }
}

class Category {

  String cid;
  String id;
  String isshow;
  String joggle;
  String modelid;
  String name;

  Category.fromParams({this.cid, this.id, this.isshow, this.joggle, this.modelid, this.name});

  Category.fromJson(jsonRes) {
    cid = jsonRes['cid'];
    id = jsonRes['id'];
    isshow = jsonRes['isshow'];
    joggle = jsonRes['joggle'];
    modelid = jsonRes['modelid'];
    name = jsonRes['name'];
  }

  @override
  String toString() {
    return '{"cid": ${cid != null?'${json.encode(cid)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"isshow": ${isshow != null?'${json.encode(isshow)}':'null'},"joggle": ${joggle != null?'${json.encode(joggle)}':'null'},"modelid": ${modelid != null?'${json.encode(modelid)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'}}';
  }
}


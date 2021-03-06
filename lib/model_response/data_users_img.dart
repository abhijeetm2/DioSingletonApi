/// page : 1
/// per_page : 6
/// total : 12
/// total_pages : 2
/// data : [{"id":1,"email":"george.bluth@reqres.in","first_name":"George","last_name":"Bluth","avatar":"https://reqres.in/img/faces/1-image.jpg"},{"id":2,"email":"janet.weaver@reqres.in","first_name":"Janet","last_name":"Weaver","avatar":"https://reqres.in/img/faces/2-image.jpg"},{"id":3,"email":"emma.wong@reqres.in","first_name":"Emma","last_name":"Wong","avatar":"https://reqres.in/img/faces/3-image.jpg"},{"id":4,"email":"eve.holt@reqres.in","first_name":"Eve","last_name":"Holt","avatar":"https://reqres.in/img/faces/4-image.jpg"},{"id":5,"email":"charles.morris@reqres.in","first_name":"Charles","last_name":"Morris","avatar":"https://reqres.in/img/faces/5-image.jpg"},{"id":6,"email":"tracey.ramos@reqres.in","first_name":"Tracey","last_name":"Ramos","avatar":"https://reqres.in/img/faces/6-image.jpg"}]
/// support : {"url":"https://reqres.in/#support-heading","text":"To keep ReqRes free, contributions towards server costs are appreciated!"}

class DataUsersImg {
  int? _page;
  int? _perPage;
  int? _total;
  int? _totalPages;
  List<Data>? _data;
  Support? _support;

  int? get page => _page;
  int? get perPage => _perPage;
  int? get total => _total;
  int? get totalPages => _totalPages;
  List<Data>? get data => _data;
  Support? get support => _support;

  DataUsersImg({
      int? page,
      int? perPage,
      int? total,
      int? totalPages,
      List<Data>? data,
      Support? support}){
    _page = page;
    _perPage = perPage;
    _total = total;
    _totalPages = totalPages;
    _data = data;
    _support = support;
}

  DataUsersImg.fromJson(dynamic json) {
    _page = json["page"];
    _perPage = json["per_page"];
    _total = json["total"];
    _totalPages = json["total_pages"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _support = json["support"] != null ? Support.fromJson(json["support"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["page"] = _page;
    map["per_page"] = _perPage;
    map["total"] = _total;
    map["total_pages"] = _totalPages;
    if (_data != null) {
      map["data"] = _data?.map((v) => v.toJson()).toList();
    }
    if (_support != null) {
      map["support"] = _support?.toJson();
    }
    return map;
  }

}

/// url : "https://reqres.in/#support-heading"
/// text : "To keep ReqRes free, contributions towards server costs are appreciated!"

class Support {
  String? _url;
  String? _text;

  String? get url => _url;
  String? get text => _text;

  Support({
      String? url,
      String? text}){
    _url = url;
    _text = text;
}

  Support.fromJson(dynamic json) {
    _url = json["url"];
    _text = json["text"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["url"] = _url;
    map["text"] = _text;
    return map;
  }

}

/// id : 1
/// email : "george.bluth@reqres.in"
/// first_name : "George"
/// last_name : "Bluth"
/// avatar : "https://reqres.in/img/faces/1-image.jpg"

class Data {
  int? _id;
  String? _email;
  String? _firstName;
  String? _lastName;
  String? _avatar;

  int? get id => _id;
  String? get email => _email;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get avatar => _avatar;

  Data({
      int? id,
      String? email,
      String? firstName,
      String? lastName,
      String? avatar}){
    _id = id;
    _email = email;
    _firstName = firstName;
    _lastName = lastName;
    _avatar = avatar;
}

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _email = json["email"];
    _firstName = json["first_name"];
    _lastName = json["last_name"];
    _avatar = json["avatar"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["email"] = _email;
    map["first_name"] = _firstName;
    map["last_name"] = _lastName;
    map["avatar"] = _avatar;
    return map;
  }

}
class Note {

  int id;
  String title;
  String content;
  String createDate;
  String updateDate;

  Note({this.id, this.title, this.content, this.createDate, this.updateDate});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['title'] = title;
    map['content'] = content;
    map['createDate'] = createDate;
    map['updateDate'] = updateDate;
    return map;
  }

  Note.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.content = map['content'];
    this.createDate = map['createDate'];
    this.updateDate = map['updateDate'];
  }

}
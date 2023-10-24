class NovelInfo {
  late String bookId;
  late String bookName;
  late  String imgUrl;
  late String authorId;
  late  String authorName;
  late  String chapterNum;
  late List<String> tag;


  NovelInfo.fromJson(Map<String, dynamic> json) {
    bookId = json['bookId'];
    bookName = json['bookName'];
    imgUrl = json['imgUrl'];
    authorId = json['authorId'];
    authorName = json['authorName'];
    chapterNum = json['chapterNum'];
    tag = json['tag'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookId'] = this.bookId;
    data['bookName'] = this.bookName;
    data['imgUrl'] = this.imgUrl;
    data['authorId'] = this.authorId;
    data['authorName'] = this.authorName;
    data['chapterNum'] = this.chapterNum;
    data['tag'] = this.tag;
    return data;
  }
}


class ChapterList {
  late String chapterId;
  late String chapterName;
  late String wordCount;
  late String shortContUrlSuffix;
  late String contUrlSuffix;


  ChapterList.fromJson(Map<String, dynamic> json) {
    chapterId = json['chapterId'];
    chapterName = json['chapterName'];
    wordCount = json['wordCount'];
    shortContUrlSuffix = json['shortContUrlSuffix'];
    contUrlSuffix = json['contUrlSuffix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chapterId'] = this.chapterId;
    data['chapterName'] = this.chapterName;
    data['wordCount'] = this.wordCount;
    data['shortContUrlSuffix'] = this.shortContUrlSuffix;
    data['contUrlSuffix'] = this.contUrlSuffix;
    return data;
  }
}
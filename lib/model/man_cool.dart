
class ManCool {
  late List<Items> items;

  ManCool.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  late String actionType;
  late String bid;
  late String bookName;
  late String bookCover;
  late String author;
  late String desc;
  late List<String> tags;
  late String price;
  late String wordCount;
  late String chargeMode;
  late String readFeatureOpt;
  late bool cache;


  Items.fromJson(Map<String, dynamic> json) {
    actionType = json['actionType'];
    bid = json['bid'];
    bookName = json['bookName'];
    bookCover = json['bookCover'];
    author = json['author'];
    desc = json['desc'];
    tags = json['tags'].cast<String>();
    price = json['price'];
    wordCount = json['wordCount'];
    chargeMode = json['chargeMode'];
    readFeatureOpt = json['readFeatureOpt'];
    cache = json['cache'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['actionType'] = this.actionType;
    data['bid'] = this.bid;
    data['bookName'] = this.bookName;
    data['bookCover'] = this.bookCover;
    data['author'] = this.author;
    data['desc'] = this.desc;
    data['tags'] = this.tags;
    data['price'] = this.price;
    data['wordCount'] = this.wordCount;
    data['chargeMode'] = this.chargeMode;
    data['readFeatureOpt'] = this.readFeatureOpt;
    data['cache'] = this.cache;
    return data;
  }
}
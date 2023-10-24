class ReaderManager {
  static ReaderManager instance = ReaderManager();

  String content='';

   String getContent() {
    return content;
  }

  void setConent(var data) {
    content=data;
  }
}

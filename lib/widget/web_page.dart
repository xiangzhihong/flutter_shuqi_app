import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {
  final String url;
  final String? title;

  WebPage({required this.url, this.title});

  @override
  WebPageState createState() => WebPageState();
}

class WebPageState extends State<WebPage> {
  WebViewController? controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(widget.title ?? '', style: const TextStyle(color: Colors.black87)),
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
        ),
      ),
      body: WebViewWidget(controller: controller!),
    );
  }
}

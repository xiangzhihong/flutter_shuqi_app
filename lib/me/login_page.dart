import 'package:flutter/material.dart';
import 'package:flutter_shuji_app/widget/web_page.dart';
import 'dart:async';
import '../public.dart';
import '../widget/code_button.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State {
  TextEditingController phoneEditer = TextEditingController();
  TextEditingController codeEditer = TextEditingController();
  int coldDownSeconds = 0;
  Timer? timer;
  bool isSelected = true;

  Future fetchSmsCode() async {
    if (phoneEditer.text.isEmpty) {
      // Toast.show('请输入手机号');
      return;
    }
    try {
      setState(() {
        coldDownSeconds = 60;
      });
      coldDown();
    } catch (e) {
      print(e.toString());
    }
  }

  login() async {
    var phone = phoneEditer.text;
    var code = codeEditer.text;

    try {
      var response = await Request.post(action: 'login', params: {
        'phone': phone,
        'code': code,
      });
      UserManager.instance.login(response);
      Navigator.pop(context);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  coldDown() {
    timer = Timer(Duration(seconds: 1), () {
      setState(() {
        --coldDownSeconds;
      });

      coldDown();
    });
  }

  Widget buildPhone() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        controller: phoneEditer,
        keyboardType: TextInputType.phone,
        style: TextStyle(fontSize: 14, color: Color(0xFF333333)),
        decoration: const InputDecoration(
          hintText: '请输入手机号',
          hintStyle: TextStyle(color: Color(0xFF888888)),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget buildCode() {
    return Container(
      padding: EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: codeEditer,
              keyboardType: TextInputType.phone,
              style: TextStyle(fontSize: 14, color: Color(0xFF333333)),
              decoration: const InputDecoration(
                hintText: '请输入短信验证码',
                hintStyle: TextStyle(color: Color(0xFF888888)),
                border: InputBorder.none,
              ),
            ),
          ),
          Container(color: Color(0xffdae3f2), width: 1, height: 40),
          Theme(
            data: ThemeData(primaryColor: Color(0xFF23B38E)),
            child: CodeButton(
              onPressed: fetchSmsCode,
              coldDownSeconds: coldDownSeconds,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBody() {
    return Column(
      children: <Widget>[
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildPhone(),
              SizedBox(height: 10),
              buildCode(),
              SizedBox(height: 10),
              buildAgree(),
              SizedBox(height: 25),
              buildBtn(),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '登录',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          child: Image.asset('assets/img/back_gray.png'),
          onTap: (){
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: buildBody(),
    );
  }

  buildBtn() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color(0xFF23B38E),
      ),
      height: 44,
      child: TextButton(
        onPressed: login,
        child: const Text(
          '登录',
          style: TextStyle(fontSize: 16, color: Color(0xffffffff)),
        ),
      ),
    );
  }

  buildAgree() {
    return Container(
      child: Row(
        children: [
          Container(
            height: 22,
            width: 22,
            child: RoundCheckBox(
              isChecked: isSelected,
              onTap: (selected) {
                setState(() {
                  isSelected = !isSelected;
                });
              },
            ),
          ),
          SizedBox(width: 5),
          GestureDetector(
            child: const Text(
              '同意《书旗用户服务协议》和《隐私服务协议》',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return WebPage(
                    url: 'https://terms.alicdn.com/legal-agreement/terms/suit_bu1_other/suit_bu1_other202009181421_79060.html',
                    title: '书旗服务协议',);
              }));
            },
          ),
        ],
      ),
    );
  }
}

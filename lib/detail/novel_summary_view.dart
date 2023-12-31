import 'package:flutter/material.dart';

class NovelSummaryView extends StatelessWidget {
  final String summary;
  final bool isUnfold;
  final VoidCallback onPressed;

  NovelSummaryView(this.summary, this.isUnfold, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: <Widget>[
                Text(
                  summary,
                  maxLines: isUnfold ? null : 3,
                  style: TextStyle(fontSize: 14),
                ),
                Image.asset('assets/img/detail_fold_bg.png'),
                Image.asset(isUnfold ? 'assets/img/detail_up.png' : 'assets/img/detail_down.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

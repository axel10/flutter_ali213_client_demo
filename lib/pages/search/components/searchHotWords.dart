import 'package:flutter/material.dart';
import 'package:youxia/pages/search/type/SearchHotWord.dart';
import 'package:youxia/utils/config.dart';
import 'package:youxia/utils/utils.dart';

class SearchHotWords extends StatelessWidget {
  final List<Word> hotWords;
  final void Function(String title) handleSearchSubmit;

  const SearchHotWords(
      {Key key, @required this.hotWords, @required this.handleSearchSubmit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget createHotWordTag(String title) {
      return InkWell(
        onTap: () {
          handleSearchSubmit(title);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          color: MyColors.backgroundGray,
          child: Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Config.horizontalPadding, vertical: 10),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: hotWords.map((word) {
                    return createHotWordTag(word.title);
                  }).toList(),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

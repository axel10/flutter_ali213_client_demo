import 'package:flutter/material.dart';
import 'package:youxia/utils/utils.dart';

class SearchHistory extends StatelessWidget {
  final List<String> searchHistoryList;
  final void Function() clearSearchHistory;
  final void Function(String word) handleSearchSubmit;

  const SearchHistory(
      {Key key,
      @required this.searchHistoryList,
      @required this.clearSearchHistory,
      @required this.handleSearchSubmit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            children: [
              Column(
                children: searchHistoryList.map((item) {
                  return InkWell(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Row(
                        children: <Widget>[
                          Text(
                            item,
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      handleSearchSubmit(item);
                    },
                  );
                }).toList(),
              ),
              searchHistoryList.length > 0
                  ? InkWell(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: Text('清除搜索历史'),
                        ),
                        decoration: BoxDecoration(
                            color: MyColors.backgroundGray,
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      onTap: clearSearchHistory,
                    )
                  : Utils.getEmptyContainer()
            ],
          ),
        ),
      ],
    );
  }
}

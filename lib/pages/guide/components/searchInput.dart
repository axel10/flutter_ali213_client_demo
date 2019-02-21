import 'package:flutter/material.dart';
import 'package:youxia/utils/utils.dart';

class SearchInputWidget extends StatefulWidget {
  final String hintText;
  final GestureTapCallback onTap;
  final bool enabled;
  final Border border;
  final Color color;
  final Widget leftArea;
  final Widget rightArea;
  final TextEditingController controller;
  final void Function(String word) onChanged;
  final Widget cleanIcon;
  final void Function(String word) onSubmitted;

  SearchInputWidget(
      {@required this.hintText,
      this.onTap,
      this.enabled = true,
      this.border,
      this.color,
      this.onChanged,
      this.leftArea,
      this.rightArea,
      this.onSubmitted,
      this.controller,
      this.cleanIcon});

  @override
  State<StatefulWidget> createState() {
    return SearchInputWidgetState();
  }
}

class SearchInputWidgetState extends State<SearchInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: widget.color,
//            border: Border.all(width: 1, color: Colors.grey),
          border: widget.border,
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          widget.leftArea == null ? Utils.getEmptyContainer() : widget.leftArea,
          Expanded(
            child: TextField(
              controller: widget.controller,
              onTap: widget.onTap,
              enabled: widget.enabled,
              onChanged: (str) {
                if (widget.onChanged != null) {
                  widget.onChanged(str);
                }
                setState(() {});
              },
              onSubmitted: widget.onSubmitted,
              decoration: InputDecoration(
                  hintText: widget.hintText,
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 5, vertical: 8)),
            ),
          ),
          widget.cleanIcon == null || widget.controller.text.isEmpty
              ? Utils.getEmptyContainer()
              : Container(
                  margin: EdgeInsets.only(right: 10),
                  child: InkWell(
                    child: widget.cleanIcon,
                    onTap: () {
                      widget.controller.clear();
                      setState(() {});
                    },
                  ),
                ),
          widget.rightArea == null
              ? Utils.getEmptyContainer()
              : widget.rightArea
/*            Icon(
              Icons.search,
              color: Colors.grey,
              size: 18,
            )*/
        ],
      ),
    );
  }
}

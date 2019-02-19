import 'package:flutter/material.dart';
import 'package:youxia/utils/utils.dart';

class SearchInput extends StatelessWidget {
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

  SearchInput(
      {@required this.hintText,
      this.onTap,
      this.enabled = true,
      this.border,
      this.color,
      this.onChanged,
      this.leftArea,
      this.rightArea,
      this.onSubmitted,
      this.controller, this.cleanIcon});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: color,
//            border: Border.all(width: 1, color: Colors.grey),
            border: border,
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            leftArea == null ? Utils.getEmptyContainer() : leftArea,
            Expanded(
              child: TextField(
                controller: controller,
                enabled: enabled,
                onChanged: onChanged,
                onSubmitted: onSubmitted,
                decoration: InputDecoration(
                    hintText: hintText,
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 8)),
              ),
            ),

            cleanIcon==null||controller.text.isEmpty? Utils.getEmptyContainer() :Container(
              margin: EdgeInsets.only(right: 10),
              child: InkWell(
                child: cleanIcon,
                onTap: (){
                  controller.clear();
                },
              ),
            ),

            rightArea == null ? Utils.getEmptyContainer() : rightArea
/*            Icon(
              Icons.search,
              color: Colors.grey,
              size: 18,
            )*/
          ],
        ),
      ),
    );
  }
}

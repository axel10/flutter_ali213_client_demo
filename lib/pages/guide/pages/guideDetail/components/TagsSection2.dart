import 'package:flutter/material.dart';
import 'package:youxia/pages/guide/pages/guideDetail/components/guidePageViewIndicatorWidget.dart';
import 'package:youxia/pages/guide/types/GuideDetail.dart';
import 'package:youxia/utils/config.dart';
import 'package:youxia/utils/utils.dart';

///转换为有状态组件
class TagsSectionWidget extends StatefulWidget {
  final List<List<GuideTag>> _tagGroups;
  final String currentId;
  final void Function(GuideTag tag) onTagTap;
  final count;

  TagsSectionWidget({Key key,
    List<GuideTag> tags,
    this.currentId,
    this.onTagTap,
    this.count = 12})
      : _tagGroups = Utils.groupData<GuideTag>(tags, count),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TagsSectionWidgetState();
  }
}

class TagsSectionWidgetState extends State<TagsSectionWidget> {
  PageController _pageViewController;

  @override
  void initState() {
    super.initState();
    _pageViewController = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: Config.horizontalPadding),
              child: GuidePageViewIndicatorWidget(
                height: 150,
                children: widget._tagGroups.map((tags) {
                  return GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    primary: true,
                    shrinkWrap: true,
                    childAspectRatio: 3,
                    mainAxisSpacing: 10,
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    children: tags.map((tag) {
                      return InkWell(
                        onTap: () {
                          if (widget.onTagTap != null) {
                            widget.onTagTap(tag);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color:
                              widget.currentId != tag.id ? Colors.white : Colors.red,
                              border: Border.all(color: Colors.red, width: 1)),
                          child: Center(
                            child: Text(
                              tag.title,
                              style: TextStyle(
                                  color: widget.currentId != tag.id
                                      ? Colors.red
                                      : Colors.white),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }).toList(),
                pageCount: widget._tagGroups.length,
                pageViewController: _pageViewController,
              )
              ),
        )
      ],
    );
  }
}

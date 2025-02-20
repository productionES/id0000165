import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import '../ui-elemnts/tab_bar.dart';
import '../pages/home/sub_tab_home.dart';
import '../models/page.dart';

List<Page> _allPages = <Page>[
  Page(icon: Icons.explore, text: 'Tharpa Publications', category: 'category-name'),
  Page(icon: Icons.insert_chart, text: 'Gueshe Kelsang', category: 'category-name'),
  Page(icon: Icons.category, text: 'Kadampa Buddhism', category: 'category-name'),
  Page(icon: Icons.stars, text: 'A Vision of World Peace', category: 'category-name'),

  Page(
      icon: Icons.directions_bus,
      text: 'Early Access',
      category: 'category-name'),
];

class AudioTab extends StatefulWidget {
  AudioTab({this.scrollController});

  final ScrollController scrollController;

  @override
  _AudioTabState createState() => _AudioTabState();
}

class _AudioTabState extends State<AudioTab> with SingleTickerProviderStateMixin {
  TabController _controller;

  Key _key = new PageStorageKey({});
  double _offset = 0.0;
  double _newOffset = 0.0;

  void _scrollListener() {
    if (widget.scrollController.position.extentAfter == 0.0) {
      _newOffset = 25.0;
      if (Platform.isIOS) {
        _newOffset = 35.0;
      }
    } else {
      _newOffset = 0.0;
    }
    setState(() {
      _offset = _newOffset;
    });
  }

  @override
  void initState() {
    _controller = new TabController(vsync: this, length: _allPages.length);
    widget.scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  Widget build(BuildContext context) {
    final List<Widget> tabChildernPages = <Widget>[];
    _allPages.forEach((Page page) => tabChildernPages.add(HomeSubTab()));

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: _offset),
          decoration: BoxDecoration(color: Colors.blue),
        ),
        TabBarWidget(_controller, _allPages),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(0.0),
            child: TabBarView(
              key: _key,
              controller: _controller,
              physics: NeverScrollableScrollPhysics(),
              children: tabChildernPages,
            ),
          ),
        ),
      ],
    );
  }
}

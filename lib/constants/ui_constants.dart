import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone/features/tweet/widget/tweet_list.dart';
import 'package:twitter_clone/theme/pallete.dart';

import 'assets_constant.dart';

class UIConstants {
  static AppBar appBar() {
    return AppBar(
      centerTitle: true,
      title: SvgPicture.asset(
        AssetsConstants.twitterLogo,
        color: Pallete.blueColor,
        height: 30,
      ),
    );
  }

  static const List<Widget> bottomTabBarPages = [
    TweetList(),
    Text("Bottom 2"),
    Text("Bottom 3"),
  ];
}

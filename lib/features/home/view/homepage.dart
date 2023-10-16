import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone/constants/assets_constant.dart';
import 'package:twitter_clone/constants/ui_constants.dart';
import 'package:twitter_clone/theme/pallete.dart';

import '../../tweet/views/create_tweet.dart';

class Homepage extends StatefulWidget {
  // Route for the homepage
  static route() => MaterialPageRoute(
        builder: (context) => const Homepage(),
      );

  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _pageIndex = 0;

  final appBar = UIConstants.appBar();

  void onPageChanged(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  onCreateTweet() {
    Navigator.push(context, CreateTweet.route());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      drawer: Drawer(),
      body: IndexedStack(
        index: _pageIndex,
        children: UIConstants.bottomTabBarPages,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onCreateTweet,
        child: const Icon(
          Icons.add,
          color: Pallete.whiteColor,
          size: 28,
        ),
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Pallete.backgroundColor,
        currentIndex: _pageIndex,
        onTap: onPageChanged,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _pageIndex == 0
                  ? AssetsConstants.homeFilledIcon
                  : AssetsConstants.homeOutlinedIcon,
              color: Pallete.whiteColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetsConstants.searchIcon,
              color: Pallete.whiteColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _pageIndex == 2
                  ? AssetsConstants.commentIcon
                  : AssetsConstants.emojiIcon,
              color: Pallete.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}

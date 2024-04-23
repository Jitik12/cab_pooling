import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:swift_street/constants/colors.dart';
import 'package:swift_street/Views/login_child1.dart';
import 'package:swift_street/Views/login_child2.dart';
import 'package:swift_street/page_indicator.dart';
import 'package:swift_street/services/auth/auth_exceptions.dart';
import 'package:swift_street/services/auth/auth_service.dart';
import 'dart:developer' as devtools;

import 'package:swift_street/services/auth/auth_user.dart';

import 'googleSignInButton.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _handlePageViewChanged(int currentPageIndex) {
    _tabController.index = currentPageIndex;
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: blueColor,
          leading: const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Image(
              image: AssetImage("assets/images/logo.png"),
              height: 30,
            ),
          ),
          title: Text(
            'CarPool',
            style: GoogleFonts.poppins(
              color: blackColor,
              fontWeight: FontWeight.w500,
              fontSize: 30,
            ),
          ),
        ),
        floatingActionButton: googleSignInButton(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            PageView(
              /// [PageView.scrollDirection] defaults to [Axis.horizontal].
              /// Use [Axis.vertical] to scroll vertically.
              controller: _pageViewController,
              onPageChanged: _handlePageViewChanged,
              children: const <Widget>[
                LoginChildOne(),
                LoginChildTwo(),
              ],
            ),
            Positioned(
              bottom: 150,
              child: PageIndicator(
                tabController: _tabController,
                currentPageIndex: _currentPageIndex,
                onUpdateCurrentPageIndex: _updateCurrentPageIndex,
              ),
            ),
          ],
        ));
  }
}

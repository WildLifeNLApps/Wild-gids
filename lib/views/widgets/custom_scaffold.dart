// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wildgids/config/theme/custom_colors.dart';
import 'package:wildgids/config/theme/custom_theme.dart';
import 'package:wildgids/config/theme/size_setter.dart';
import 'package:wildgids/views/home/home.dart';
import 'package:wildgids/views/profile/profile.dart';

class CustomScaffold extends StatefulWidget {
  CustomScaffold({
    super.key,
    required this.body,
    this.isAuthenticated = false,
    required this.selectedIndex,
    this.appBarTitle,
    this.appBackgroundColor = CustomColors.dark,
    this.appBarLeading,
    this.actions,
    this.appBarBackgroundColor = Colors.transparent,
    this.automaticallyImplyLeading = false,
    this.systemOverlayStyle = SystemUiOverlayStyle.light,
    this.extendBehindAppBar = false,
    this.appBar,
    this.floatingActionButton,
    this.drawer,
    this.useAppBar = true,
    this.bottomSafeArea = true,
    this.topSafeArea = true,
    this.floatingActionButtonLocation,
  });

  final Widget body;
  final bool isAuthenticated;
  final int selectedIndex;
  final Widget? appBarTitle;
  final Widget? appBarLeading;
  final List<Widget>? actions;
  final Color appBarBackgroundColor;
  final Color appBackgroundColor;
  final bool automaticallyImplyLeading;
  final SystemUiOverlayStyle systemOverlayStyle;
  final bool extendBehindAppBar;
  final AppBar? appBar;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final bool useAppBar;
  final bool bottomSafeArea;
  final bool topSafeArea;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  int _selectedIndex = 0;

  // Create pages list with the HomePage and ProfilePage
  final List<Widget> pages = [
    const HomePage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !widget.useAppBar
          ? null
          : widget.appBar ??
              AppBar(
                title: widget.appBarTitle,
                backgroundColor: widget.appBarBackgroundColor,
                titleTextStyle:
                    CustomTheme(context).themeData.textTheme.headlineMedium,
                toolbarHeight: Platform.isIOS ? 55 : 85,
                centerTitle: true,
                elevation: 0,
                leading: widget.appBarLeading,
                actions: widget.actions,
                leadingWidth: 40 + SizeSetter.getHorizontalScreenPadding(),
                systemOverlayStyle: widget.systemOverlayStyle,
                automaticallyImplyLeading: widget.automaticallyImplyLeading,
                iconTheme: const IconThemeData(color: CustomColors.light),
              ),
      bottomNavigationBar: widget.isAuthenticated
          ? const SizedBox()
          : BottomNavigationBar(
              currentIndex: _selectedIndex,
              backgroundColor: Colors.white,
              selectedIconTheme: const IconThemeData(color: Colors.black),
              selectedItemColor: Colors.black,
              unselectedIconTheme: const IconThemeData(color: Colors.grey),
              unselectedItemColor: Colors.grey,
              onTap: _onItemTapped,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
      body: SafeArea(
        top: widget.topSafeArea,
        bottom: widget.bottomSafeArea,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeSetter.getHorizontalScreenPadding()),
          child: IndexedStack(
            index: _selectedIndex,
            children: widget.isAuthenticated ? [widget.body] : pages,
          ),
        ),
      ),
    );
  }
}

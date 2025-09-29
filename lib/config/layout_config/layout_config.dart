import 'package:flutter/material.dart';

class LayoutConfig extends StatelessWidget {
  final Widget child;
  final String appBarTitle;
  final int currentIndex;
  const LayoutConfig({
  super.key,
  required this.child,
  required this.appBarTitle,
  required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
            appBar: AppBar(
              title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text(appBarTitle),
              ],
            ),
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: Theme.of(context).colorScheme.onSurface, // line color
              height: 1.0,
            ),
           ),
           ),
          body: child,
          bottomNavigationBar:Container(
        decoration:  BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Theme.of(context).colorScheme.onSurface,  // Border color
              width: 1.0,          // Border thickness
            ),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          selectedItemColor: Theme.of(context).colorScheme.onPrimary,
          unselectedItemColor: Theme.of(context).colorScheme.onSurface,
          currentIndex: currentIndex,
          onTap: null,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.timeline_rounded),
              label: "TIMELINE",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pets),
              label: "POKEMON",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: "CHAT",
            ),
          ],
        ),
      ),
    ));
  }
}
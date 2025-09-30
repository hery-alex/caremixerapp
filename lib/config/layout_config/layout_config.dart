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
              color: Theme.of(context).colorScheme.onSurface,
              height: 1.0,
            ),
           ),
           ),
          body: child,
          bottomNavigationBar:Container(
        decoration:  BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Theme.of(context).colorScheme.onSurface,  
              width: 1.0,         
            ),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          selectedItemColor: Theme.of(context).colorScheme.onPrimary,
          unselectedItemColor: Theme.of(context).colorScheme.onSurface,
          currentIndex: currentIndex,
          onTap: (index){
            if(index != currentIndex){
            switch(index){
              case 0: 
               Navigator.of(context).pushNamed('/timeline');
              case 1: 
               Navigator.of(context).pushNamed('/pokemon');
              case 2: 
               Navigator.of(context).pushNamed('/chat');
            }
            }
          },
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
import 'package:caremixer_test/part_1_timelinelist/timelinelist_UI.dart';
import 'package:flutter/material.dart';


abstract class RouteConfig{
   Widget checkPath(RouteSettings settings);
}

class RoutesConfiguration implements RouteConfig{

  
   @override
     Widget checkPath(RouteSettings settings){
     switch(settings.name!){
      case '/part1':
        return  const TimelinelistUi();
      default : 
        return const SizedBox();    
    }

  }

  
 static Route<dynamic>? onGenerateRoute(
    RouteSettings settings,
  ) {
    return PageRouteBuilder(
       pageBuilder: (context,animation1, animation2){
         return RoutesConfiguration().checkPath(settings);
       },
       transitionsBuilder: (_,anim,__,child){
           const begin = Offset(1.0, 0.0);
           const end = Offset.zero;
           const curve = Curves.ease;
  
           var tween =  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  
           return SlideTransition(
             position: anim.drive(tween),
             child: child,
           );
       }
    );
  }
}
import 'package:caremixer_test/part_1_timelinelist/timeline_view/timelinelist_view.dart';
import 'package:caremixer_test/part_2_api_integration/pokemon_api_view/pokemon_view.dart';
import 'package:caremixer_test/part_2_api_integration/pokemon_api_view_model/pokemon_api_state.dart';
import 'package:caremixer_test/part_2_api_integration/pokemon_api_view_model/pokemon_api_view_model.dart';
import 'package:caremixer_test/part_3_chat/chat_provider/chat_provider.dart';
import 'package:caremixer_test/part_3_chat/chat_view/chat_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


abstract class RouteConfig{
   Widget checkPath(RouteSettings settings);
}

class RoutesConfiguration implements RouteConfig{

  
   @override
     Widget checkPath(RouteSettings settings){
     switch(settings.name!){
      case '/timeline':
        return   TimelineView();
      case '/pokemon':
        return   BlocProvider(
              create: (_) => PokemonApiViewModel()..add(LoadPokemons()),
              child:PokemonApiView());   
      case '/chat':
        return  ChatProvider(child: ChatView()); 
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
          return FadeTransition(
            opacity: anim,
            child: child,
          );
       }
    );
  }
}
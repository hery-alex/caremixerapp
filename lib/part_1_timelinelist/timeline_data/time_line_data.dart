import 'dart:convert';
import 'package:caremixer_test/part_1_timelinelist/timeline_model/timeline_model.dart';
import 'package:flutter/services.dart';

abstract class DataRepository{
  Future<List<TimelineItem>> getTimelineFromJsom();
}


class JsonRepository extends DataRepository{
 
 @override
 Future<List<TimelineItem>> getTimelineFromJsom() async{

  try{
      final String timelineList = await rootBundle.loadString('assets/jsonData.json');
      final  data = await json.decode(timelineList);
      final List<dynamic> jsonList = data['timelineItems'];
      List<TimelineItem> parsedData = jsonList.map((element)=> TimelineItem.fromJson(element)).toList();
      return parsedData;
 }catch(e){
      throw Exception('Cannot get timelineItems $e'); 
  }

}

}


class TimelineItem {
  final String? timelineItemType;
  final String? timelineItemTitle;
  final DateTime? timelineItemTimestamp;
  final String? timelineItemMessage;

  TimelineItem({
    required this.timelineItemType,
    required this.timelineItemTitle,
    required this.timelineItemTimestamp,
    required this.timelineItemMessage,
  });

   TimelineItem.fromJson(Map<String, dynamic> json) :
      timelineItemType = json['timelineItemType'],
      timelineItemTitle = json['timelineItemTitle'],
      timelineItemTimestamp = DateTime.parse(json['timelineItemTimestamp']),
      timelineItemMessage = json['timelineItemMessage'];

   Map<String,dynamic> tojson(){
   final Map<String,dynamic> data =  <String,dynamic>{};
   data['timelineItemType'] = timelineItemType;
   data['timelineItemTitle'] = timelineItemTitle;
   data['timelineItemTimestamp'] = timelineItemTimestamp;
   data['timelineItemMessage'] = timelineItemMessage;
   return data;
  }

   TimelineItem copyWith({
    final String? timelineItemType,
    final String? timelineItemTitle,
    final DateTime? timelineItemTimestamp,
    final String? timelineItemMessage
  }){
    return TimelineItem(
      timelineItemType: timelineItemType ?? this.timelineItemType,
      timelineItemTitle : timelineItemTitle ?? this.timelineItemTitle,
      timelineItemTimestamp : timelineItemTimestamp ?? this.timelineItemTimestamp,
      timelineItemMessage : timelineItemMessage ?? this.timelineItemMessage,
    );
  }

    @override
  int get hashCode => Object.hash(
    timelineItemType, 
    timelineItemTitle,
    timelineItemTimestamp,
    timelineItemMessage);

  @override
    bool operator ==(Object other)=> 
    other is TimelineItem && 
    timelineItemType == other.timelineItemType && 
    timelineItemTitle == other.timelineItemTitle && 
    timelineItemTimestamp == other.timelineItemTimestamp && 
    timelineItemMessage == other.timelineItemMessage;  
}
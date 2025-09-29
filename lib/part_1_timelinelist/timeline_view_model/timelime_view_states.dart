import 'package:caremixer_test/part_1_timelinelist/timeline_model/timeline_model.dart';

abstract class TimelineState {
   List<Object?> get timelineItemsList => [];
}

class TimelineInitial extends TimelineState {}

class TimelineLoading extends TimelineState {}

class TimelineLoaded extends TimelineState {
  final List<TimelineItem> items;
  TimelineLoaded(this.items);

  @override
  List<Object?> get timelineItemsList => items;
}

class TimelineError extends TimelineState {
  final String message;
  TimelineError(this.message);

  @override
  List<Object?> get timelineItemsList => [message];
}


abstract class TimelineEvent {}

class LoadTimeline extends TimelineEvent {}
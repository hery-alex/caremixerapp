import 'package:caremixer_test/part_1_timelinelist/timeline_data/time_line_data.dart';
import 'package:caremixer_test/part_1_timelinelist/timeline_model/timeline_model.dart';
import 'package:caremixer_test/part_1_timelinelist/timeline_view_model/timelime_view_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class TimelineViewModel extends Bloc<TimelineEvent, TimelineState> {

   TimelineViewModel() : super(TimelineInitial()) {
    on<LoadTimeline>((event, emit) async {
      emit(TimelineLoading());
      try {
        final DataRepository repository = JsonRepository();
        List<TimelineItem> result = await repository.getTimelineFromJsom();
        emit(TimelineLoaded(result));
      } catch (e) {
        emit(TimelineError(e.toString()));
      }
    });
  }
  
}
import 'package:caremixer_test/part_1_timelinelist/timeline_view/timeline_widgets/timeline_widget.dart';
import 'package:caremixer_test/part_1_timelinelist/timeline_view_model/timelime_view_states.dart';
import 'package:caremixer_test/part_1_timelinelist/timeline_view_model/timeline_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimelineView extends StatelessWidget {
  const TimelineView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (_) => TimelineViewModel()..add(LoadTimeline()),
      child:SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Timeline"),
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
          body: BlocBuilder<TimelineViewModel, TimelineState>(
            builder: (context, state) {
              if (state is TimelineLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TimelineLoaded) {
                return SingleChildScrollView(
                  child: Column(
                  children:[
                    const SizedBox(height: 10,),
                     ...List.generate(
                      state.items.length,
                      (index) => TimelineTile(
                        timelineItem: state.items[index], 
                        showTimeline: state.items.length - 1  == index ? false : true, 
                        isProgressed: state.items.length - 1  == index ? false : true,)
                    )
                   ]
                  ),
                );
              } else if (state is TimelineError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox();
            },
          ),
            ),
      ));
  }
}
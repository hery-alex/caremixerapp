import 'package:caremixer_test/part_1_timelinelist/timeline_model/timeline_model.dart';
import 'package:caremixer_test/part_1_timelinelist/timeline_view/timeline_widgets/dashed_line_painter.dart';
import 'package:caremixer_test/part_1_timelinelist/timeline_view/timeline_widgets/timeline_radio_switch.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimelineTile extends StatelessWidget{
  final bool isProgressed;
  final TimelineItem timelineItem;
  final bool showTimeline;

 const TimelineTile({super.key, required this.timelineItem, required this.showTimeline,required this.isProgressed});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TimelineIconSection(
            isProgressed: isProgressed,
            showTimeline: showTimeline,
          ),
          Expanded(
              child: Container(
                padding: EdgeInsets.only(left:10,right: 10,bottom: 10),
                child: TimelineBodySectionContent(timelineItem: timelineItem),
              ),
            ),
        ],
      ),
    );
  }
}

class TimelineIconSection extends StatelessWidget {
  final bool isProgressed;
  final bool showTimeline;

 const TimelineIconSection({super.key, required this.isProgressed, required this.showTimeline});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 6,right: 6),
      child: Column(
        children: [
          TimelineRadioSwitch(value: isProgressed),
          if (showTimeline)
            Expanded(
              child: CustomPaint(
                size: const Size(2, double.infinity), // Ensure it takes full height
                painter: DashedLinePainter(lineColour: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
        ],
      ),
    );
  }
}



class TimelineBodySectionContent extends StatelessWidget {
  final TimelineItem timelineItem;

  const TimelineBodySectionContent({super.key, required this.timelineItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left:8,right: 8, top: 8),
      decoration: BoxDecoration(
        color: timelineItem.timelineItemType == "NOTES" ? 
         Theme.of(context).colorScheme.secondary : 
          Theme.of(context).colorScheme.primary ,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
            BoxShadow(
              color:Theme.of(context).colorScheme.onSurface
                  .withAlpha((255 * 0.34).round()),
              blurRadius: 10,
            ),
            BoxShadow(
              color:Theme.of(context).colorScheme.onSurface
                  .withAlpha((255 * 0.15).round()),
              blurRadius: 5,
            ),
          ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (timelineItem.timelineItemTitle != null) ...[
            Row(
              spacing: 6,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  timelineItem.timelineItemType == "NOTES" ? 
                  Icons.note_rounded :
                  Icons.message_rounded, 
                  size: 25,
                 color: Theme.of(context).colorScheme.onPrimary,
                ),
                Expanded(
                  child: Text(
                    timelineItem.timelineItemTitle!,
                    style:Theme.of(context).primaryTextTheme.headlineSmall,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
          ],
          if (timelineItem.timelineItemTimestamp != null) ...[
            Text(
              DateFormat('EEEE, d MMM yyyy').format(timelineItem.timelineItemTimestamp!),
              style: Theme.of(context).primaryTextTheme.titleMedium,
            ),
            SizedBox(height: 6),
          ],
          if (timelineItem.timelineItemMessage != null) ...[
            SizedBox(height: 6),
            Text(
              timelineItem.timelineItemMessage!,
              style: Theme.of(context).primaryTextTheme.bodyLarge,
            ),
          ],
           SizedBox(height: 10),
        ],
      ),
    );
  }
}
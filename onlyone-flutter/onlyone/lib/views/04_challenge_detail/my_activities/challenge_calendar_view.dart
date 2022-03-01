// 04_책린지상세_나의 활동_캘린더
import 'dart:collection';

import 'package:flutter/material.dart';

//import 'package:intl/date_symbol_data_local.dart';
import 'package:onlyone/Core/color_theme.dart';
import 'package:onlyone/models/challenge_response.dart';
import 'package:onlyone/models/feed_response.dart';
import 'package:table_calendar/table_calendar.dart';

// Example holidays
/*
final Map<DateTime, List> _holidays = {
  DateTime(2020, 1, 1): ['New Year\'s Day'],
  DateTime(2020, 1, 6): ['Epiphany'],
  DateTime(2020, 2, 14): ['Valentine\'s Day'],
  DateTime(2020, 4, 21): ['Easter Sunday'],
  DateTime(2020, 4, 22): ['Easter Monday'],
};
*/

class ChallengeCalendarView extends StatefulWidget {
  final ChallengeResponse challenge;

  const ChallengeCalendarView(this.challenge);
  @override
  _ChallengeCalendarViewState createState() =>
      _ChallengeCalendarViewState(challenge);
}

class _ChallengeCalendarViewState extends State<ChallengeCalendarView> {
  final ChallengeResponse challenge;

  CalendarFormat _calendarFormat = CalendarFormat.month;
  Map<DateTime, FeedResponse> _eventMap = {};
  DateTime _focusedDay = DateTime.now();
  DateTime _lastDay = DateTime.now();
  DateTime? _selectedDay;

  _ChallengeCalendarViewState(this.challenge) {
    challenge.feeds.forEach((feed) {
      _eventMap[feed.createDate] = feed;
    });
  }

  @override
  Widget build(BuildContext context) {
    _lastDay = DateTime(
      challenge.endDate.year,
      challenge.endDate.month,
      challenge.endDate.day,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: TableCalendar(
        availableCalendarFormats: const {CalendarFormat.month: ''},
        firstDay: DateTime(
          challenge.startDate.year,
          challenge.startDate.month - 1,
          1,
        ),
        calendarBuilders: calendarBuilder(),
        lastDay: _lastDay,
        focusedDay: _focusedDay.isBefore(_lastDay) ? _focusedDay : _lastDay,
        rangeStartDay: challenge.startDate,
        rangeEndDay: challenge.endDate,
        calendarFormat: _calendarFormat,
        eventLoader: _getEventsForDay,
        calendarStyle: CalendarStyle(
          markersMaxCount: 1,
          markerSizeScale: 1,
          markersAnchor: 1,
          rangeHighlightColor: ColorTheme.gray300,
          rangeStartTextStyle: TextStyle(color: ColorTheme.gray900),
          rangeStartDecoration: const BoxDecoration(
            // 시작날이 인증날일 경우의 로직 추가 필요
            // image: const DecorationImage(
            //   image: ExactAssetImage("images/btn_calender_check.png"),
            //   fit: BoxFit.cover,
            // ),

            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: ColorTheme.gray300,
            // shape: BoxShape.circle,
          ),
          rangeEndTextStyle: TextStyle(color: ColorTheme.gray900),
          rangeEndDecoration: const BoxDecoration(
            // 시작날이 인증날일 경우의 로직 추가 필요
            // image: const DecorationImage(
            //   image: ExactAssetImage("images/btn_calender_check.png"),
            //   fit: BoxFit.cover,
            // ),

            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: ColorTheme.gray300,
            // shape: BoxShape.circle,
          ),
          markerDecoration: const BoxDecoration(
            image: const DecorationImage(
              image: ExactAssetImage("images/btn_calender_check.png"),
              fit: BoxFit.cover,
            ),
            color: ColorTheme.gray300,
            shape: BoxShape.circle,
          ),
          outsideDaysVisible: false,
        ),
        selectedDayPredicate: (day) {
          // Use `selectedDayPredicate` to determine which day is currently selected.
          // If this returns true, then `day` will be marked as selected.

          // Using `isSameDay` is recommended to disregard
          // the time-part of compared DateTime objects.
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            // Call `setState()` when updating the selected day
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          }
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            // Call `setState()` when updating calendar format
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          // No need to call `setState()` here
          _focusedDay = focusedDay;
        },
      ),
    );
  }

  List<FeedResponse> _getEventsForDay(DateTime day) {
    var feed = _eventMap[day];
    return (feed == null) ? [] : [feed!];
  }
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kNow = DateTime.now();
final kFirstDay = DateTime(kNow.year, kNow.month - 3, kNow.day);
final kLastDay = DateTime(kNow.year, kNow.month + 3, kNow.day);

CalendarBuilders calendarBuilder() {
  return CalendarBuilders(
    selectedBuilder: (context, date, _) {
      return null;
      // return DaisyWidget().buildCalendarDay(
      //     day: date.day.toString(), backColor: DaisyColors.main4Color);
    },
    todayBuilder: (context, date, _) {
      return null;
    },
    markerBuilder: (context, date, events) {
      if (events.isNotEmpty) {
        return Container(color: Colors.yellow, height: 20, width: 20);
      }
      return null;
    },
  );
}

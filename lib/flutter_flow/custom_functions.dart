import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

String? apiimagestring(String imgUri) {
  String cleanWixImageUrl(String imageUrl) {
    String cleanedImageUrl = imageUrl.replaceFirst('wix:image://v1/', '');
    cleanedImageUrl = cleanedImageUrl.split('#').first;
    cleanedImageUrl = cleanedImageUrl
        .split('/')
        .first; // Add this line to remove the second parameter
    return 'https://static.wixstatic.com/media/' + cleanedImageUrl;
  }

  String imageUrl = imgUri;
  String cleanedImageUrl = cleanWixImageUrl(imageUrl);
  return cleanedImageUrl;
}

List<dynamic>? blogfilter(
  dynamic posts,
  String? category,
) {
  return posts
      .where((posts) =>
          posts['categories'] != null && posts['categories'].contains(category))
      .toList();
  final apiResponse = json.decode(
      posts.body); // Assuming you already have the API response JSON decoded
  final filteredPosts = blogfilter(category, apiResponse);
}

String? filterJsonData(dynamic items) {
  for (var item in items!) {
    if (item['snippet']['liveBroadcastContent'] == 'live') {
      var videoId = item['id']['videoId'];
      return videoId;
    }
  }
  return null;
}

ShowsRecord? currentShowCopy(List<ShowsRecord> shows) {
  final currentDay = DateTime.now().weekday;
  ShowsRecord? curShow;

  int _convertToDateTime(String day) {
    switch (day.toLowerCase()) {
      case 'monday':
        return DateTime.monday;
      case 'tuesday':
        return DateTime.tuesday;
      case 'wednesday':
        return DateTime.wednesday;
      case 'thursday':
        return DateTime.thursday;
      case 'friday':
        return DateTime.friday;
      case 'saturday':
        return DateTime.saturday;
      case 'sunday':
        return DateTime.sunday;
      default:
        return DateTime.monday; // Default to Monday
    }
  }

  int _convertToTimeOfDay(String time) {
    final timeSplit = time.split(':');
    final hour = int.parse(timeSplit[0]);
    final minuteSplit = timeSplit[1].split(' ');
    final minute = int.parse(minuteSplit[0]);

    if (time.contains('PM') || time.contains('pm')) {
      return (hour % 12 + 12) * 60 + minute;
    } else {
      return hour % 12 * 60 + minute;
    }
  }

  for (final show in shows) {
    for (final showDayAndTime in show.showDayAndTime) {
      final day = _convertToDateTime(showDayAndTime.showDay);
      if (day == currentDay) {
        // Convert showTimes to TimeOfDay object
        final showStartTime = _convertToTimeOfDay(showDayAndTime
            .showStartTime); // Corrected from showTime to showTimes
        final showEndTime = _convertToTimeOfDay(
            showDayAndTime.showEndTime); // Corrected from showTime to showTimes
        // Get the current time
        final currentTime = DateTime.now().hour * 60 + DateTime.now().minute;

        // Compare the hours
        if (showStartTime <= currentTime && currentTime <= showEndTime) {
          curShow = show;
          return show;
        }
      }
    }
  }
  return curShow;
}

List<ShowsRecord>? currentShow(List<ShowsRecord> shows) {
  final currentDay = DateTime.now().weekday;
  List<ShowsRecord> currentShows = [];

  int _convertToDateTime(String day) {
    switch (day.toLowerCase()) {
      case 'monday':
        return DateTime.monday;
      case 'tuesday':
        return DateTime.tuesday;
      case 'wednesday':
        return DateTime.wednesday;
      case 'thursday':
        return DateTime.thursday;
      case 'friday':
        return DateTime.friday;
      case 'saturday':
        return DateTime.saturday;
      case 'sunday':
        return DateTime.sunday;
      default:
        return DateTime.monday; // Default to Monday
    }
  }

  for (final show in shows) {
    for (final showDay in show.showDayAndTime) {
      final day = _convertToDateTime(showDay.showDay);
      if (day == currentDay) {
        currentShows.add(show);
      }
    }
  }

  if (currentShows.isNotEmpty) {
    return currentShows;
  } else {
    return null;
  }
}

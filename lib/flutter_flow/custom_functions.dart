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

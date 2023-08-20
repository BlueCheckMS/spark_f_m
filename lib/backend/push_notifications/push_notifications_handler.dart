import 'dart:async';
import 'dart:convert';

import 'serialization_util.dart';
import '../backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../index.dart';
import '../../main.dart';

final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    if (_handledMessageIds.contains(message.messageId)) {
      return;
    }
    _handledMessageIds.add(message.messageId);

    if (mounted) {
      setState(() => _loading = true);
    }
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final parametersBuilder = parametersBuilderMap[initialPageName];
      if (parametersBuilder != null) {
        final parameterData = await parametersBuilder(initialParameterData);
        context.pushNamed(
          initialPageName,
          pathParameters: parameterData.pathParameters,
          extra: parameterData.extra,
        );
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    handleOpenedPushNotification();
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Center(
          child: SizedBox(
            width: 50.0,
            height: 50.0,
            child: SpinKitDualRing(
              color: Color(0xFFEB4323),
              size: 50.0,
            ),
          ),
        )
      : widget.child;
}

class ParameterData {
  const ParameterData(
      {this.requiredParams = const {}, this.allParams = const {}});
  final Map<String, String?> requiredParams;
  final Map<String, dynamic> allParams;

  Map<String, String> get pathParameters => Map.fromEntries(
        requiredParams.entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
  Map<String, dynamic> get extra => Map.fromEntries(
        allParams.entries.where((e) => e.value != null),
      );

  static Future<ParameterData> Function(Map<String, dynamic>) none() =>
      (data) async => ParameterData();
}

final parametersBuilderMap =
    <String, Future<ParameterData> Function(Map<String, dynamic>)>{
  'SignInDemo': ParameterData.none(),
  'SignUpDemo': ParameterData.none(),
  'BrowseDemo': ParameterData.none(),
  'NewsFeedDemo': ParameterData.none(),
  'SparkTVDemo': ParameterData.none(),
  'LiveRadioTabDemo': ParameterData.none(),
  'SongListPage': (data) async => ParameterData(
        allParams: {
          'playlist': await getDocumentParameter<PlaylistRecord>(
              data, 'playlist', PlaylistRecord.fromSnapshot),
          'music': await getDocumentParameter<AlbumRecord>(
              data, 'music', AlbumRecord.fromSnapshot),
          'singleSong': await getDocumentParameter<SongsRecord>(
              data, 'singleSong', SongsRecord.fromSnapshot),
        },
      ),
  'ViewAllArtist': (data) async => ParameterData(
        allParams: {},
      ),
  'MusicStreamDemo': (data) async => ParameterData(
        allParams: {
          'album': await getDocumentParameter<AlbumRecord>(
              data, 'album', AlbumRecord.fromSnapshot),
          'songIndex': getParameter<int>(data, 'songIndex'),
        },
      ),
  'ArtistProfileDemo': (data) async => ParameterData(
        allParams: {
          'artistDoc': await getDocumentParameter<ArtistRecord>(
              data, 'artistDoc', ArtistRecord.fromSnapshot),
        },
      ),
  'NewsStoryDemo': (data) async => ParameterData(
        allParams: {},
      ),
  'PodcasPage': (data) async => ParameterData(
        allParams: {
          'podcastDoc': await getDocumentParameter<PodcastRecord>(
              data, 'podcastDoc', PodcastRecord.fromSnapshot),
        },
      ),
  'AboutUs': ParameterData.none(),
  'Advertise': ParameterData.none(),
  'ViewAllPodcast': (data) async => ParameterData(
        allParams: {},
      ),
  'ViewAllAlbum': (data) async => ParameterData(
        allParams: {},
      ),
  'EditProfile': ParameterData.none(),
  'chatPage': (data) async => ParameterData(
        allParams: {
          'chatUser': await getDocumentParameter<UsersRecord>(
              data, 'chatUser', UsersRecord.fromSnapshot),
          'chatRef': getParameter<DocumentReference>(data, 'chatRef'),
        },
      ),
  'ViewAllPlaylist': (data) async => ParameterData(
        allParams: {},
      ),
  'chatsCopy': ParameterData.none(),
  'videoPage': (data) async => ParameterData(
        allParams: {
          'videoId': getParameter<String>(data, 'videoId'),
          'videoTitle': getParameter<String>(data, 'videoTitle'),
          'videoDiscription': getParameter<String>(data, 'videoDiscription'),
        },
      ),
};

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}

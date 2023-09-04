import 'dart:convert';
import 'dart:typed_data';

import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class TwitchTokenValidationCall {
  static Future<ApiCallResponse> call({
    String? clientId = 'yjdulm4mbkq6cn4h6tdnavhw0y10i7',
    String? clientSecret = '0jhdr85ckbg9no1pk6nuh5dbv6is79',
    String? grantType = 'client_credentials',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'twitch token validation',
      apiUrl: 'https://id.twitch.tv/oauth2/token',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'OAuth dl5vuoje2udtygx781emkxx4vbinlr',
      },
      params: {
        'client_id': clientId,
        'client_secret': clientSecret,
        'grant_type': grantType,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic appAccessToken(dynamic response) => getJsonField(
        response,
        r'''$.app.acces.token''',
      );
}

class SparkFMTWitchRadioClipsCall {
  static Future<ApiCallResponse> call({
    String? userId = '697915438',
    String? broadcasterId = '697915438',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'sparkFMTWitchRadioClips',
      apiUrl: 'https://api.twitch.tv/helix/clips',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer 6jm1fvt0db1grx94yr37jygxpdr3oq',
        'Client-Id': 'yjdulm4mbkq6cn4h6tdnavhw0y10i7',
      },
      params: {
        'user_id': userId,
        'broadcaster_id': broadcasterId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic sparkFMClips(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
  static dynamic streamThumbnail(dynamic response) => getJsonField(
        response,
        r'''$.data..thumbnail_url''',
      );
}

class SparkFMYoutubeCall {
  static Future<ApiCallResponse> call({
    String? part = 'snippet',
    String? q = 'Spark FM Network',
    String? key = 'AIzaSyDz9BDIDT-OOa3BTeYT48abIt8f79K0boc',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'sparkFMYoutube',
      apiUrl: 'https://www.googleapis.com/youtube/v3/search',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'part': part,
        'q': q,
        'key': key,
        'maxResults': 50,
        'channelld': "UCDU6t3K4JWih1zXJgWN3_hQ",
        'type': 'video',
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic sparkFMvideoID(dynamic response) => getJsonField(
        response,
        r'''$.items[:].id.videoId''',
        true,
      );
  static dynamic sparkFMVideoTitle(dynamic response) => getJsonField(
        response,
        r'''$.items[:].snippet.title''',
        true,
      );
  static dynamic thumbnail(dynamic response) => getJsonField(
        response,
        r'''$.items[:].snippet.thumbnails.default.url''',
        true,
      );
  static dynamic channeltitle(dynamic response) => getJsonField(
        response,
        r'''$.items[:].snippet.channelTitle''',
        true,
      );
  static dynamic video(dynamic response) => getJsonField(
        response,
        r'''$.items[:].snippet''',
        true,
      );
  static dynamic channelLive(dynamic response) => getJsonField(
        response,
        r'''$.items[0]..liveBroadcastContent''',
      );
  static dynamic channalvideos(dynamic response) => getJsonField(
        response,
        r'''$.items[1:]''',
        true,
      );
  static dynamic liveId(dynamic response) => getJsonField(
        response,
        r'''$.items[1]..videoId''',
      );
}

class SparkFMYoutubeCopyCall {
  static Future<ApiCallResponse> call({
    String? part = 'snippet',
    String? q = 'Spark FM Network',
    String? key = 'AIzaSyDz9BDIDT-OOa3BTeYT48abIt8f79K0boc',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'sparkFMYoutube Copy',
      apiUrl: 'https://www.googleapis.com/youtube/v3/search',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'part': part,
        'q': q,
        'key': key,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic sparkFMvideoID(dynamic response) => getJsonField(
        response,
        r'''$.items[:].id.videoId''',
      );
  static dynamic sparkFMVideoTitle(dynamic response) => getJsonField(
        response,
        r'''$.items[:].snippet.title''',
      );
  static dynamic thumbnail(dynamic response) => getJsonField(
        response,
        r'''$.items[:].snippet.thumbnails.default.url''',
      );
  static dynamic channeltitle(dynamic response) => getJsonField(
        response,
        r'''$.items[:].snippet.channelTitle''',
      );
  static dynamic video(dynamic response) => getJsonField(
        response,
        r'''$.items[:].snippet''',
      );
  static dynamic channel(dynamic response) => getJsonField(
        response,
        r'''$.items''',
      );
}

class SparkFmBlogCall {
  static Future<ApiCallResponse> call({
    String? url = 'url',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'Spark Fm Blog',
      apiUrl: 'https://www.sparkfmonline.com/_functions/blogPost',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: true,
    );
  }

  static dynamic postTitle(dynamic response) => getJsonField(
        response,
        r'''$.posts[:].title''',
        true,
      );
  static dynamic postExerpt(dynamic response) => getJsonField(
        response,
        r'''$.posts[:].excerpt''',
        true,
      );
  static dynamic postCover(dynamic response) => getJsonField(
        response,
        r'''$.posts[:].coverMedia.image.url''',
        true,
      );
  static dynamic posts(dynamic response) => getJsonField(
        response,
        r'''$.posts''',
        true,
      );
  static dynamic postSlug(dynamic response) => getJsonField(
        response,
        r'''$.posts[:].slug''',
        true,
      );
  static dynamic contenttext(dynamic response) => getJsonField(
        response,
        r'''$.posts[:].contentText''',
        true,
      );
  static dynamic plainContent(dynamic response) => getJsonField(
        response,
        r'''$.posts[:].plainContent''',
        true,
      );
  static dynamic cat(dynamic response) => getJsonField(
        response,
        r'''$.posts[:].categories''',
        true,
      );
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}

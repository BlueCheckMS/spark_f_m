import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/request_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LiveRadioTabDemoModel extends FlutterFlowModel {
  ///  Local state fields for this page.

  double test = 60.0;

  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  /// Query cache managers for this widget.

  final _nowPlayingShowManager = StreamRequestManager<List<ShowsRecord>>();
  Stream<List<ShowsRecord>> nowPlayingShow({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<ShowsRecord>> Function() requestFn,
  }) =>
      _nowPlayingShowManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearNowPlayingShowCache() => _nowPlayingShowManager.clear();
  void clearNowPlayingShowCacheKey(String? uniqueKey) =>
      _nowPlayingShowManager.clearRequest(uniqueKey);

  final _showListManager = StreamRequestManager<List<ShowsRecord>>();
  Stream<List<ShowsRecord>> showList({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<ShowsRecord>> Function() requestFn,
  }) =>
      _showListManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearShowListCache() => _showListManager.clear();
  void clearShowListCacheKey(String? uniqueKey) =>
      _showListManager.clearRequest(uniqueKey);

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    tabBarController?.dispose();

    /// Dispose query cache managers for this widget.

    clearNowPlayingShowCache();

    clearShowListCache();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}

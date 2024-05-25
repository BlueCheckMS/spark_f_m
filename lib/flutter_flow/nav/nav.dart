import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';

import '../../auth/base_auth_user_provider.dart';
import '../../backend/push_notifications/push_notifications_handler.dart'
    show PushNotificationsHandler;
import '/index.dart';
import '/main.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/flutter_flow_util.dart';
export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey =
    GlobalKey<NavigatorState>(debugLabel: 'LiveRadioTabDemo');
final _shellNavigatorBKey =
    GlobalKey<NavigatorState>(debugLabel: 'NewsFeedDemo');
final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'BrowseDemo');
final _shellNavigatorDdKey =
    GlobalKey<NavigatorState>(debugLabel: 'SparkTVDemo');
final _shellNavigatorEKey = GlobalKey<NavigatorState>(debugLabel: 'AboutUs');
final _shellNavigatoreeKey =
    GlobalKey<NavigatorState>(debugLabel: 'NewsStoryDemo');

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, state) => _RouteErrorBuilder(
        state: state,
        child: appStateNotifier.loggedIn
            ? LiveRadioTabDemoWidget()
            : SignInDemoWidget(),
      ),
      routes: [
        GoRoute(
            redirect: (context, state) {
              if (!appStateNotifier.loggedIn) {
                return '/signInDemo';
              } else {
                return '/liveRadioTabDemo';
              }
            },
            name: '_initialize',
            path: '/',
            builder: (
              context,
              _,
            ) =>
                SignInDemoWidget()),
        GoRoute(
          name: 'SignInDemo',
          path: '/signInDemo',
          builder: (context, params) => SignInDemoWidget(),
        ),
        GoRoute(
          name: 'SignUpDemo',
          path: '/signUpDemo',
          builder: (context, params) => SignUpDemoWidget(),
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return MainPage(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              navigatorKey: _shellNavigatorAKey,
              routes: [
                GoRoute(
                  name: 'LiveRadioTabDemo',
                  path: '/liveRadioTabDemo',
                  builder: (context, state) => appStateNotifier.loggedIn
                      ? LiveRadioTabDemoWidget()
                      : SignInDemoWidget(),
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _shellNavigatorBKey,
              routes: [
                FFRoute(
                  name: 'NewsFeedDemo',
                  path: '/newsFeedDemo',
                  builder: (context, params) => NewsFeedDemoWidget(),
                  routes: [
                    FFRoute(
                      name: 'NewsStoryDemo',
                      path: 'newsStoryDemo',
                      builder: (context, params) => NewsStoryDemoWidget(
                        post: params.getParam('post', ParamType.JSON),
                      ),
                    ),
                  ].map((r) => r.toRoute(appStateNotifier)).toList(),
                ),
              ].map((r) => r.toRoute(appStateNotifier)).toList(),
            ),
            StatefulShellBranch(
              navigatorKey: _shellNavigatorCKey,
              routes: [
                FFRoute(
                  name: 'BrowseDemo',
                  path: '/browseDemo',
                  builder: (context, params) => BrowseDemoWidget(),
                  routes: [
                    FFRoute(
                      name: 'ViewAllArtist',
                      path: 'viewAllArtist',
                      asyncParams: {
                        'artist':
                            getDocList(['Artist'], ArtistRecord.fromSnapshot),
                      },
                      builder: (context, params) => ViewAllArtistWidget(
                        artist: params.getParam<ArtistRecord>(
                            'artist', ParamType.Document, true),
                      ),
                      routes: [
                        FFRoute(
                          name: 'ArtistProfileDemo',
                          path: 'artistProfileDemo',
                          asyncParams: {
                            'artistDoc':
                                getDoc(['Artist'], ArtistRecord.fromSnapshot),
                          },
                          builder: (context, params) => ArtistProfileDemoWidget(
                            artistDoc: params.getParam(
                                'artistDoc', ParamType.Document),
                          ),
                        ),
                        FFRoute(
                          name: 'SongListPage',
                          path: 'songListPage',
                          asyncParams: {
                            'playlist': getDoc(
                                ['playlist'], PlaylistRecord.fromSnapshot),
                            'music':
                                getDoc(['Album'], AlbumRecord.fromSnapshot),
                            'singleSong':
                                getDoc(['songs'], SongsRecord.fromSnapshot),
                            'podcast':
                                getDoc(['podcast'], PodcastRecord.fromSnapshot),
                          },
                          builder: (context, params) => SongListPageWidget(
                            playlist:
                                params.getParam('playlist', ParamType.Document),
                            music: params.getParam('music', ParamType.Document),
                            singleSong: params.getParam(
                                'singleSong', ParamType.Document),
                            podcast:
                                params.getParam('podcast', ParamType.Document),
                          ),
                        ),
                      ].map((r) => r.toRoute(appStateNotifier)).toList(),
                    ),
                    FFRoute(
                      name: 'ViewAllAlbum',
                      path: 'viewAllAlbum',
                      asyncParams: {
                        'music':
                            getDocList(['Album'], AlbumRecord.fromSnapshot),
                      },
                      builder: (context, params) => ViewAllAlbumWidget(
                        music: params.getParam<AlbumRecord>(
                            'music', ParamType.Document, true),
                      ),
                    ),
                    FFRoute(
                      name: 'ViewAllPlaylist',
                      path: 'viewAllPlaylist',
                      asyncParams: {
                        'playlist': getDocList(
                            ['playlist'], PlaylistRecord.fromSnapshot),
                      },
                      builder: (context, params) => ViewAllPlaylistWidget(
                        playlist: params.getParam<PlaylistRecord>(
                            'playlist', ParamType.Document, true),
                      ),
                    ),
                    FFRoute(
                      name: 'ViewAllPodcast',
                      path: 'viewAllPodcast',
                      asyncParams: {
                        'podcast':
                            getDocList(['podcast'], PodcastRecord.fromSnapshot),
                      },
                      builder: (context, params) => ViewAllPodcastWidget(
                        podcast: params.getParam<PodcastRecord>(
                            'podcast', ParamType.Document, true),
                      ),
                    ),
                  ].map((r) => r.toRoute(appStateNotifier)).toList(),
                ),
              ].map((r) => r.toRoute(appStateNotifier)).toList(),
            ),
            StatefulShellBranch(
                routes: [
                  FFRoute(
                    name: 'SparkTVDemo',
                    path: '/sparkTVDemo',
                    builder: (context, params) => SparkTVDemoWidget(),
                    routes: [
                      FFRoute(
                        name: 'videoPage',
                        path: 'videoPage',
                        builder: (context, params) => VideoPageWidget(
                          videoId: params.getParam('videoId', ParamType.String),
                          videoTitle:
                              params.getParam('videoTitle', ParamType.String),
                          videoDiscription: params.getParam(
                              'videoDiscription', ParamType.String),
                        ),
                      )
                    ].map((r) => r.toRoute(appStateNotifier)).toList(),
                  ),
                ].map((r) => r.toRoute(appStateNotifier)).toList(),
                navigatorKey: _shellNavigatorDdKey),
            StatefulShellBranch(
                routes: [
                  FFRoute(
                    name: 'AboutUs',
                    path: '/aboutUs',
                    builder: (context, params) => AboutUsWidget(),
                  ),
                ].map((r) => r.toRoute(appStateNotifier)).toList(),
                navigatorKey: _shellNavigatorEKey),
            StatefulShellBranch(
                routes: [
              FFRoute(
                name: 'EditProfile',
                path: '/editProfile',
                builder: (context, params) => EditProfileWidget(),
              ),
            ].map((r) => r.toRoute(appStateNotifier)).toList()),
            StatefulShellBranch(
                routes: [
              FFRoute(
                  name: 'Advertise',
                  path: '/advertise',
                  builder: (context, params) => AdvertiseWidget()),
            ].map((r) => r.toRoute(appStateNotifier)).toList()),
            StatefulShellBranch(
                routes: [
              FFRoute(
                  name: 'Chat2Main',
                  path: '/chat2Main',
                  builder: (context, params) => Chat2MainWidget(),
                  routes: [
                    FFRoute(
                      name: 'Chat2Details',
                      path: 'chat2Details',
                      asyncParams: {
                        'chatUser': getDoc(['users'], UsersRecord.fromSnapshot),
                      },
                      builder: (context, params) => Chat2DetailsWidget(
                        chatRef: params.getParam('chatRef',
                            ParamType.DocumentReference, false, ['chats']),
                      ),
                    ),
                    FFRoute(
                      name: 'chat2Invite',
                      path: 'chat2Invite',
                      builder: (context, params) => Chat2InviteUsersWidget(
                        chatRef: params.getParam('chatRef',
                            ParamType.DocumentReference, false, ['chats']),
                      ),
                    )
                  ].map((r) => r.toRoute(appStateNotifier)).toList()),
            ].map((r) => r.toRoute(appStateNotifier)).toList()),
          ],
        ),
      ],
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.extraMap.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, [
    bool isList = false,
    List<String>? collectionNamePath,
  ]) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(param, type, isList,
        collectionNamePath: collectionNamePath);
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.location);
            return '/signInDemo';
          }
          return null;
        },
        pageBuilder: (context, state) {
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
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
              : PushNotificationsHandler(child: page);

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder: PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).transitionsBuilder,
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class _RouteErrorBuilder extends StatefulWidget {
  const _RouteErrorBuilder({
    Key? key,
    required this.state,
    required this.child,
  }) : super(key: key);

  final GoRouterState state;
  final Widget child;

  @override
  State<_RouteErrorBuilder> createState() => _RouteErrorBuilderState();
}

class _RouteErrorBuilderState extends State<_RouteErrorBuilder> {
  @override
  void initState() {
    super.initState();
    // Handle erroneous links from Firebase Dynamic Links.
    if (widget.state.location.startsWith('/link?request_ip_version')) {
      SchedulerBinding.instance.addPostFrameCallback((_) => context.go('/'));
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

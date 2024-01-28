import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:spark_f_m/flutter_flow/flutter_flow_widgets.dart';
import 'package:spark_f_m/song_screen/song_screen.dart';
import 'auth/firebase_auth/firebase_user_provider.dart';
import 'auth/firebase_auth/auth_util.dart';

import 'backend/push_notifications/push_notifications_util.dart';
import 'backend/firebase/firebase_config.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'flutter_flow/nav/nav.dart';
import 'index.dart';

Future<void> main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await initFirebase();

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  ThemeMode _themeMode = ThemeMode.system;

  late Stream<BaseAuthUser> userStream;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;

  final authUserSub = authenticatedUserStream.listen((_) {});
  final fcmTokenSub = fcmTokenUserStream.listen((_) {});

  @override
  void initState() {
    super.initState();
    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
    userStream = sparkFMFirebaseUserStream()
      ..listen((user) => _appStateNotifier.update(user));
    jwtTokenStream.listen((_) {});
    Future.delayed(
      Duration(milliseconds: 1000),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
  }

  @override
  void dispose() {
    authUserSub.cancel();
    fcmTokenSub.cancel();
    super.dispose();
  }

  void setLocale(String language) {
    setState(() => _locale = createLocale(language));
  }

  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'SparkFM',
      localizationsDelegates: [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
      ],
      theme: ThemeData(
        brightness: Brightness.light,
        scrollbarTheme: ScrollbarThemeData(),
      ),
      themeMode: _themeMode,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey<String>('mainPage'));

  final StatefulNavigationShell navigationShell;

  _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return NavigatorBar(
        body: navigationShell,
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _goBranch,
      );
    });
  }
}

//   return NavigatorBar(

// Widget build(BuildContext context) {
//       body: navigationShell,
//       selectedIndex: navigationShell.currentIndex,
//       onDestinationSelected: _goBranch);
// }

class NavigatorBar extends StatefulWidget {
  const NavigatorBar({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  State<NavigatorBar> createState() => _NavigatorState();
}

class _NavigatorState extends State<NavigatorBar>
    with TickerProviderStateMixin<NavigatorBar> {
  static const List<Destination> allDestinations = <Destination>[
    Destination(0, 'Home', Icons.online_prediction, LiveRadioTabDemoWidget()),
    Destination(1, 'News Feed', Icons.newspaper, NewsFeedDemoWidget()),
    Destination(2, 'Browse', FontAwesomeIcons.music, BrowseDemoWidget()),
    Destination(3, 'Spark TV', Icons.ondemand_video, SparkTVDemoWidget()),
    Destination(4, 'About Us', Icons.bolt, AboutUsWidget()),
  ];

  late final List<GlobalKey<NavigatorState>> navigatorKeys;
  late final List<GlobalKey> destinationKeys;
  late int selectedIndex;
  late final List<Widget> destinationViews;

  @override
  void initState() {
    super.initState();
    navigatorKeys = List<GlobalKey<NavigatorState>>.generate(
            allDestinations.length, (int index) => GlobalKey<NavigatorState>())
        .toList();
    selectedIndex = 0;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Consumer<FFAppState>(
        builder: (context, appState, _) {
          final currentRoute = GoRouter.of(context).location;
          print(currentRoute);
          // Now you can conditionally render or modify your UI based on the route
          bool hideNavigationBar = currentRoute == '/liveRadioTabDemo';
          if (!AppStateNotifier.instance.loggedIn) {
            if (!appState.audioPlayer.playing) {
              appState.audioPlayer.stop();
            }
          }
          return Scaffold(
              floatingActionButton: Visibility(
                  visible: !appState.isLive,
                  child: FFButtonWidget(
                    onPressed: () async {
                      setState(() {
                        FFAppState().audioMetaList(
                          live: true,
                        );
                      });
                    },
                    text: 'Listen Live',
                    options: FFButtonOptions(
                      height: 40,
                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: FlutterFlowTheme.of(context).secondary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                              ),
                      elevation: 3,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  )),
              body: SafeArea(top: false, child: widget.body),
              bottomNavigationBar: hideNavigationBar &&
                      !AppStateNotifier.instance.loggedIn
                  ? null
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Visibility(
                          visible: appState.audioPlayer.audioSource != null,
                          child: AudioPlayerWidget(
                            titleTextStyle:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                            playbackDurationTextStyle:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF9D9D9D),
                                      fontSize: 12,
                                    ),
                            fillColor: Color.fromARGB(255, 238, 238, 238),
                            playbackButtonColor:
                                FlutterFlowTheme.of(context).secondaryColor,
                            activeTrackColor: Color(0xFFEB4323),
                            elevation: 4,
                            width: double.infinity,
                            height: 100,
                          ),
                        ),
                        NavigationBar(
                          selectedIndex: widget.selectedIndex,
                          onDestinationSelected: widget.onDestinationSelected,
                          destinations:
                              allDestinations.map((Destination destination) {
                            return NavigationDestination(
                              icon: Icon(destination.icon,
                                  color: Color(0xFFEB4323)),
                              label: destination.title,
                            );
                          }).toList(),
                          indicatorColor: Color(0xffeee811),
                        ),
                      ],
                    ));
        },
      );
}

class Destination {
  const Destination(this.index, this.title, this.icon, this.child);
  final int index;
  final String title;
  final IconData icon;
  final Widget? child;
}

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spark_f_m/song_screen/song_screen.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'index.dart';
import 'live_radio_tab_demo/live_radio_tab_demo_widget.dart';
export 'live_radio_tab_demo/live_radio_tab_demo_model.dart';

/// Flutter code sample for [NavigationBar] with nested [Navigator] destinations.

class Root extends StatefulWidget {
  const Root({super.key, String? destination});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> with TickerProviderStateMixin<Root> {
  static const List<Destination> allDestinations = <Destination>[
    Destination(0, 'Home', Icons.online_prediction,
        LiveRadioTabDemoWidget()),
    Destination(1, 'News Feed', Icons.newspaper, NewsFeedDemoWidget()),
    Destination(2, 'Browse', FontAwesomeIcons.music, BrowseDemoWidget()),
    Destination(3, 'Spark TV', Icons.ondemand_video, SparkTVDemoWidget()),
    Destination(4, 'About Us', Icons.bolt, AboutUsWidget()),
  ];

  late final List<GlobalKey<NavigatorState>> navigatorKeys;
  late final List<GlobalKey> destinationKeys;

  late final List<Widget> destinationViews;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    navigatorKeys = List<GlobalKey<NavigatorState>>.generate(
            allDestinations.length, (int index) => GlobalKey<NavigatorState>())
        .toList();
    destinationViews = allDestinations.map((destination) {
      return DestinationView(
        destination: destination,
        navigatorKey: navigatorKeys[destination.index],
      );
    }).toList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Consumer<FFAppState>(
        builder: (context, appState, _) {
          return WillPopScope(
            onWillPop: () async {
              final NavigatorState navigator =
                  navigatorKeys[selectedIndex].currentState!;
              if (!navigator.canPop()) {
                return true;
              }
              navigator.pop();
              return false;
            },
            child: Scaffold(
                body: SafeArea(
                  top: false,
                  child: Stack(
                    fit: StackFit.expand,
                    children: allDestinations.map((Destination destination) {
                      final int index = destination.index;
                      final Widget view = destinationViews[index];
                      if (index == selectedIndex) {
                        return Offstage(offstage: false, child: view);
                      } else {
                        return Offstage(child: view);
                      }
                    }).toList(),
                  ),
                ),
                bottomNavigationBar: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (appState.audioPlayer.isPlaying.value == true && appState.audioPlayer.stopped == false)
                    GestureDetector(
                      onTap: () => Navigator.push(context,
                      PageTransition(child: LargeAssetAudioPlayer(), type: PageTransitionType.bottomToTop)),
                      child: Hero(
                        transitionOnUserGestures: true,
                          tag: 'largeAudioPlayer',
                          child: AssetAudioPlayer(
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
                          )),
                    ),
                    NavigationBar(
                      selectedIndex: selectedIndex,
                      onDestinationSelected: (int index) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      destinations:
                          allDestinations.map((Destination destination) {
                        return NavigationDestination(
                          icon:
                              Icon(destination.icon, color: Color(0xFFEB4323)),
                          label: destination.title,
                        );
                        
                      }).toList(),
                      indicatorColor: Color(0xffeee811),
                    ),
                  ],
                )),
          );
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

class RootPage extends StatelessWidget {
  const RootPage({
    super.key,
    required this.destination,
  });

  final Destination destination;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: destination.child,
    ));
  }
}

class DestinationView extends StatefulWidget {
  const DestinationView({
    super.key,
    required this.destination,
    required this.navigatorKey,
  });

  final Destination destination;
  final Key navigatorKey;

  @override
  State<DestinationView> createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget.navigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (
            BuildContext context,
          ) {
            switch (settings.name) {
              case '/':
                return RootPage(destination: widget.destination);
              case '/LiveRadioTabDemo':
                return LiveRadioTabDemoWidget();
              case '/NewsFeedDemo':
                return NewsFeedDemoWidget();
              case '/BrowseDemo':
                return BrowseDemoWidget();
              case '/SparkTVDemo':
                return SparkTVDemoWidget();
              case '/AboutUs':
                return AboutUsWidget();
              case 'NewsStoryDemo':
                final Map<String, dynamic> params =
                    settings.arguments as Map<String, dynamic>;
                final dynamic postJsonString = params['post'];
                final dynamic post = jsonDecode(postJsonString);
                return NewsStoryDemoWidget(post: post);
              case 'SongListPage':
                final args = settings.arguments as Map<String, dynamic>;
                final dynamic playlist = args['playlist'];
                final dynamic music = args['music'];
                final dynamic singleSong = args['singleSong'];
                final dynamic podcast = args['podcast'];
                return SongListPageWidget(
                    playlist: playlist,
                    music: music,
                    singleSong: singleSong,
                    podcast: podcast);
              case 'PodcasPage':
                final args = settings.arguments as Map<String, dynamic>;
                final dynamic podcast = args['podcastDoc'];
                return PodcasPageWidget(
                  podcastDoc: podcast,
                );
              case 'ViewAllArtist':
                final args = settings.arguments as Map<String, dynamic>;
                final dynamic artists = args['artist'];
                return ViewAllArtistWidget(artist: artists);
              case 'ArtistProfileDemo':
                final args = settings.arguments as Map<String, dynamic>;
                final dynamic artist = args['artistDoc'];
                return ArtistProfileDemoWidget(artistDoc: artist);
                case 'LargeAssetAudioPlayer' :
                return LargeAssetAudioPlayer();
                case 'ViewAllPodcast' :
              final args = settings.arguments as Map<String, dynamic>;
              final dynamic podcasts = args['podcast'];
              return ViewAllPodcastWidget(podcast: podcasts);
              case 'ViewAllAlbum' :
              final args = settings.arguments as Map<String, dynamic>;
               final dynamic music = args['music'];
               return ViewAllAlbumWidget(music: music);
               case 'ViewAllPlaylist' :
               final args = settings.arguments as Map<String, dynamic>;
               final dynamic playlist = args['playlist'];
               return ViewAllPlaylistWidget(playlist: playlist);
               case 'Advertise' : 
               return AdvertiseWidget();
               case 'EditProfile' :
               return EditProfileWidget();
               case 'chatPage' :
               final args = settings.arguments as Map<String, dynamic>;
               final dynamic chatRef = args['chatRef'];
               final dynamic chatUser = args['chatUser'];
               return ChatPageWidget(chatRef: chatRef, chatUser: chatUser,);
               case 'chatsCopy' :
               return ChatsCopyWidget();
               case 'videoPage' : 
               final args = settings.arguments as Map<String, dynamic>;
               final dynamic videoId = args['videoId'];
               final dynamic videoTitle = args['videoTitle'];
               final dynamic videoDiscription = args['videoDiscription'];
               return VideoPageWidget(videoId: videoId, videoTitle: videoTitle, videoDiscription: videoDiscription);
            }
            assert(false);
            return const SizedBox();
          },
        );
      },
    );
  }
}

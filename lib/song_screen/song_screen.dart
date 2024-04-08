import 'dart:async';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import '../app_state.dart';
import '../flutter_flow/flutter_flow_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterFlowTheme.initialize();

  FFAppState(); // Initialize FFAppState
}

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget({
    required this.titleTextStyle,
    required this.playbackDurationTextStyle,
    required this.fillColor,
    required this.playbackButtonColor,
    required this.activeTrackColor,
    required this.elevation,
    required this.height,
    required this.width,
  });

  final TextStyle titleTextStyle;
  final TextStyle playbackDurationTextStyle;
  final Color fillColor;
  final Color playbackButtonColor;
  final Color activeTrackColor;
  final double elevation;
  final double height;
  final double width;

  @override
  __AudioPlayerWidgetState createState() => __AudioPlayerWidgetState();
}

class PositionData {
  const PositionData(
    this.position,
    this.bufferedPosition,
    this.duration,
  );
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
}

class __AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayer _audioPlayer;
  Stream<PositionData> _positionDataStream() =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _audioPlayer.positionStream,
        _audioPlayer.bufferedPositionStream,
        _audioPlayer.durationStream,
        (position, bufferedPosition, duration) => PositionData(
          position,
          bufferedPosition,
          duration ?? Duration.zero,
        ),
      );

  bool mini = true;
  late double height;
  @override
  void initState() {
    super.initState();
    _audioPlayer = FFAppState().audioPlayer;

    _init();
  }

  Future<void> _init() async {
    await _audioPlayer.setLoopMode(LoopMode.all);
  }

  @override
  void dispose() {
    // if (_subscribedRoute) {
    //   routeObserver.unsubscribe(this);
    // }
    if (FFAppState().AudioPlayerMeta.children.isEmpty) {
      _audioPlayer.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          mini = !mini;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: !mini,
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          mini = !mini;
                        });
                      },
                      icon: const Icon(Icons.keyboard_arrow_down))
                ],
              ),
            ),
          ),
          AnimatedContainer(
            decoration: BoxDecoration(
              color: mini ? Color(0xffeee811) : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
                  offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )
              ],
            ),
            duration: Duration(milliseconds: 250),
            height: mini
                ? MediaQuery.sizeOf(context).height * .07
                : MediaQuery.sizeOf(context).height * .762,
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder<SequenceState?>(
                    stream: _audioPlayer.sequenceStateStream,
                    builder: (context, snapshot) {
                      final state = snapshot.data;
                      if (state?.sequence.isEmpty ?? true) {
                        return const SizedBox();
                      }
                      final metaData = state?.currentSource?.tag;
                      return Consumer<FFAppState>(
                          builder: (context, ffAppState, _) => MediaMetaData(
                                imageurl: metaData.artUri.toString(),
                                title: metaData.title,
                                artist: metaData.artist.toString(),
                                mini: mini,
                                live: ffAppState.isLive,
                                audioPlayer: ffAppState.audioPlayer,
                              ));
                    },
                  ),
                  Consumer<FFAppState>(builder: (context, appState, _) {
                    if ((!appState.isLive && !mini))
                      return StreamBuilder<PositionData>(
                        stream: _positionDataStream(),
                        builder: (context, snapshot) {
                          final positionData = snapshot.data;
                          return ProgressBar(
                            barHeight: 8,
                            baseBarColor: const Color(0xFFC9D0D5),
                            progressBarColor: Color(0xFFEB4323),
                            thumbColor: Color(0xFFEB4323),
                            timeLabelTextStyle: TextStyle(
                              color: Color(0xFFEB4323),
                              fontWeight: FontWeight.w600,
                            ),
                            progress: positionData?.position ?? Duration.zero,
                            buffered:
                                positionData?.bufferedPosition ?? Duration.zero,
                            total: positionData?.duration ?? Duration.zero,
                            onSeek: _audioPlayer.seek,
                          );
                        },
                      );
                    return SizedBox();
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MediaMetaData extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  MediaMetaData(
      {super.key,
      required this.imageurl,
      required this.title,
      required this.artist,
      required this.mini,
      required this.live,
      required this.audioPlayer});

  final String imageurl;
  final String title;
  final String artist;
  final AudioPlayer audioPlayer;
  bool mini;
  bool live;

  @override
  Widget build(BuildContext context) {
    Timer.periodic(Duration(seconds: 2), (timer) {
      if (_scrollController.hasClients) {
        double maxScrollExtent = _scrollController.position.maxScrollExtent;
        double currentPosition = _scrollController.position.pixels;

        if (currentPosition < maxScrollExtent) {
          // Scroll to the end
          _scrollController.animateTo(
            maxScrollExtent,
            duration: Duration(milliseconds: 3000),
            curve: Curves.easeInOut,
          );
        } else {
          // Scroll back to the beginning
          _scrollController.animateTo(
            0.0,
            duration: Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
          );
        }
      }
    });
    Timer.periodic(Duration(seconds: 3), (timer) {
      if (_scrollController2.hasClients) {
        double maxScrollExtent = _scrollController2.position.maxScrollExtent;
        double currentPosition = _scrollController2.position.pixels;

        if (currentPosition < maxScrollExtent) {
          // Scroll to the end
          _scrollController2.animateTo(
            maxScrollExtent,
            duration: Duration(milliseconds: 3000),
            curve: Curves.easeInOut,
          );
        } else {
          // Scroll back to the beginning
          _scrollController2.animateTo(
            0.0,
            duration: Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
          );
        }
      }
    });
    return mini
        ? Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 15, 0),
                  child: live
                      ? CircleAvatar(
                          backgroundImage: AssetImage(imageurl),
                          radius: 20,
                        )
                      : CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(imageurl),
                          radius: 20,
                        ),
                ),
                Flexible(
                    child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        child: Container(
                          height: 22,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        controller: _scrollController2,
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        child: Container(
                          height: 22,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                artist,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(100, 0, 0, 0),
                  child: Consumer<FFAppState>(
                      builder: (context, appState, _) => Controls(
                            audioPlayer: audioPlayer,
                            live: appState.isLive,
                            mini: mini,
                          )),
                )
              ],
            ),
          )
        : Column(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(2, 4),
                        blurRadius: 4),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: live
                      ? Image.asset(imageurl,
                          height: 300, width: 300, fit: BoxFit.cover)
                      : CachedNetworkImage(
                          imageUrl: imageurl,
                          height: 300,
                          width: 300,
                          fit: BoxFit.cover),
                ),
              ),
              Text(
                artist,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Text(
                title,
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Consumer<FFAppState>(
                  builder: (context, appState, _) => Controls(
                        audioPlayer: audioPlayer,
                        live: appState.isLive,
                        mini: mini,
                      ))
            ],
          );
  }
}

class Controls extends StatelessWidget {
  const Controls(
      {super.key,
      required this.audioPlayer,
      required this.live,
      required this.mini});
  final AudioPlayer audioPlayer;
  final bool live;
  final bool mini;

  @override
  Widget build(BuildContext context) {
    if (!mini) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
              visible: !live,
              child: IconButton(
                onPressed: audioPlayer.seekToPrevious,
                icon: const Icon(Icons.skip_previous_rounded),
                color: Color(0xFFEB4323),
                iconSize: 80,
              )),
          StreamBuilder<PlayerState>(
              stream: audioPlayer.playerStateStream,
              builder: ((context, snapshot) {
                final playerState = snapshot.data;
                final processingState = playerState?.processingState;
                final playing = playerState?.playing;
                if (!(playing ?? false)) {
                  return IconButton(
                    onPressed: audioPlayer.play,
                    icon: const Icon(Icons.play_arrow_rounded),
                    iconSize: 80,
                    color: Color(0xFFEB4323),
                  );
                } else if (processingState != ProcessingState.completed) {
                  return IconButton(
                    onPressed: audioPlayer.pause,
                    icon: const Icon(Icons.pause_rounded),
                    iconSize: 80,
                    color: Color(0xFFEB4323),
                  );
                }
                return const Icon(
                  Icons.play_arrow_rounded,
                  size: 80,
                  color: Color(0xFFEB4323),
                );
              })),
          Visibility(
              visible: !live,
              child: IconButton(
                onPressed: audioPlayer.seekToNext,
                icon: const Icon(Icons.skip_next_rounded),
                color: Color(0xFFEB4323),
                iconSize: 80,
              ))
        ],
      );
    }
    return StreamBuilder<PlayerState>(
        stream: audioPlayer.playerStateStream,
        builder: ((context, snapshot) {
          final playerState = snapshot.data;
          final processingState = playerState?.processingState;
          final playing = playerState?.playing;
          if (!(playing ?? false)) {
            return IconButton(
              onPressed: audioPlayer.play,
              icon: const Icon(Icons.play_arrow_rounded),
              iconSize: 40,
              color: Color(0xFFEB4323),
            );
          } else if (processingState != ProcessingState.completed) {
            return IconButton(
              onPressed: audioPlayer.pause,
              icon: const Icon(Icons.pause_rounded),
              iconSize: 40,
              color: Color(0xFFEB4323),
            );
          }
          return const Icon(
            Icons.play_arrow_rounded,
            size: 40,
            color: Color(0xFFEB4323),
          );
        }));
  }
}

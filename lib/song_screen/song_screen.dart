import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../flutter_flow/flutter_flow_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterFlowTheme.initialize();

  FFAppState(); // Initialize FFAppState
}

class AssetAudioPlayer extends StatefulWidget {
  const AssetAudioPlayer({
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
  __AssetAudioPlayerState createState() => __AssetAudioPlayerState();
}

class __AssetAudioPlayerState extends State<AssetAudioPlayer> {
  bool mini = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // if (_subscribedRoute) {
    //   routeObserver.unsubscribe(this);
    // }
    FFAppState().audioPlayer;
    super.dispose();
  }

  Duration currentPosition(RealtimePlayingInfos infos) => infos.currentPosition;
  Duration duration(RealtimePlayingInfos infos) => infos.duration;

  String playbackStateText(RealtimePlayingInfos infos) {
    final currentPositionString = durationToString(currentPosition(infos));
    final durationString = durationToString(duration(infos));
    return '$currentPositionString/$durationString';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FFAppState>(builder: (context, ffAppState, _) {
      return ffAppState.audioPlayer.builderRealtimePlayingInfos(
          builder: (context, infos) => PlayerBuilder.isPlaying(
              player: ffAppState.audioPlayer,
              builder: (context, isPlaying) {
                final childWidget = GestureDetector(
                  child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                      child: Container(
                        height: MediaQuery.sizeOf(context).height * .07,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(ffAppState.audioPlayer
                                  .getCurrentAudioImage?.path as String),
                              radius: 20,
                            ),
                            Text(
                              ffAppState.audioPlayer.getCurrentAudioTitle,
                              style: widget.titleTextStyle,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(34),
                              child: Material(
                                color: Colors.transparent,
                                child: IconButton(
                                  onPressed: () async {
                                    await ffAppState.audioPlayer.playOrPause();
                                  },
                                  icon: Icon(
                                    (ffAppState.audioPlayer.isPlaying.value)
                                        ? Icons.pause_circle_filled_rounded
                                        : Icons.play_circle_fill_rounded,
                                    color: widget.playbackButtonColor,
                                    size: 34,
                                  ),
                                  iconSize: 34,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                );
                return Material(
                    color: Colors.white,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: childWidget);
              }));
    });
  }
}

class LargeAssetAudioPlayer extends StatefulWidget {
  @override
  __LargeAssetAudioPlayerState createState() => __LargeAssetAudioPlayerState();
}

class __LargeAssetAudioPlayerState extends State<LargeAssetAudioPlayer> {
  bool mini = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // if (_subscribedRoute) {
    //   routeObserver.unsubscribe(this);
    // }
    FFAppState().audioPlayer;
    super.dispose();
  }

  Duration currentPosition(RealtimePlayingInfos infos) => infos.currentPosition;
  Duration duration(RealtimePlayingInfos infos) => infos.duration;

  String playbackStateText(RealtimePlayingInfos infos) {
    final currentPositionString = durationToString(currentPosition(infos));
    final durationString = durationToString(duration(infos));
    return '$currentPositionString/$durationString';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FFAppState>(builder: (context, ffAppState, _) {
      return ffAppState.audioPlayer.builderRealtimePlayingInfos(
          builder: (context, infos) => PlayerBuilder.isPlaying(
              player: ffAppState.audioPlayer,
              builder: (context, isPlaying) {
                final childWidget =
                Scaffold(body: Hero(
                  tag: 'largeAudioPlayer',
                  child: Container(
                    height: MediaQuery.sizeOf(context).height * 1,
                    child: Column(
                      children: [
                         Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(20, 90, 0, 100),
                                child: Container(
                                  child: Row(children: [
                                    GestureDetector(
                                        onTap: () => Navigator.of(context).pop(context),
                                        child: Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 50,
                                          )),
                                  ]),
                                )),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            
                            Column(
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      ffAppState.audioPlayer.getCurrentAudioImage
                                          ?.path as String,
                                      height: 400,
                                    ),
                                    Text(
                                      ffAppState.audioPlayer.getCurrentAudioTitle,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    Text(
                                      playbackStateText(infos),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF9D9D9D),
                                            fontSize: 12,
                                          ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ClipRRect(
                                        child: Material(
                                      child: IconButton(
                                        onPressed: () async {
                                          ffAppState.audioPlayer.toggleShuffle();
                                        },
                                        icon: Icon(Icons.shuffle),
                                      ),
                                    )),
                                    ClipRRect(
                                        child: Material(
                                      child: IconButton(
                                        onPressed: () async {
                                          ffAppState.audioPlayer.previous();
                                        },
                                        icon: Icon(Icons.skip_previous_rounded),
                                      ),
                                    )),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(34),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: IconButton(
                                          onPressed: () async {
                                            ffAppState.audioPlayer.playOrPause();
                                          },
                                          icon: Icon(
                                            (isPlaying)
                                                ? Icons.pause_circle_filled_rounded
                                                : Icons.play_circle_fill_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryColor,
                                            size: 50,
                                          ),
                                          iconSize: 50,
                                        ),
                                      ),
                                    ),
                                    ClipRRect(
                                        child: Material(
                                      child: IconButton(
                                        icon: Icon(Icons.skip_next_rounded),
                                        onPressed: () async {
                                          ffAppState.audioPlayer.next();
                                        },
                                      ),
                                    )),
                                    ClipRRect(
                                        child: Material(
                                      child: IconButton(
                                        icon: Icon(Icons.repeat),
                                        onPressed: () {},
                                      ),
                                    )),
                                  ],
                                ),
                                PositionSeekWidget(
                                  currentPosition: currentPosition(infos),
                                  duration: duration(infos),
                                  seekTo: (to) {
                                    ffAppState.audioPlayer.seek(to);
                                  },
                                  activeTrackColor: Color(0xFFEB4323),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ) ,);
                

                return Material(
                    color: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: childWidget);
              }));
    });
  }
}

class LiveAssetAudioPlayer extends StatefulWidget {
  const LiveAssetAudioPlayer({
    required this.audio,
    required this.titleTextStyle,
    required this.playbackDurationTextStyle,
    required this.fillColor,
    required this.playbackButtonColor,
    required this.activeTrackColor,
    required this.elevation,
    required this.height,
    required this.image,
    required this.width,
  });

  final Audio audio;
  final TextStyle titleTextStyle;
  final TextStyle playbackDurationTextStyle;
  final Color fillColor;
  final Color playbackButtonColor;
  final Color activeTrackColor;
  final double elevation;
  final double height;
  final Image image;
  final double width;

  @override
  _LiveAssetAudioPlayerState createState() => _LiveAssetAudioPlayerState();
}

class _LiveAssetAudioPlayerState extends State<LiveAssetAudioPlayer> {
  AssetsAudioPlayer player = new AssetsAudioPlayer();

  late AssetsAudioPlayer _liveAssetsAudioPlayer;
  bool mini = true;
  @override
  void initState() {
    super.initState();
    openPlayer();
  }

  Future openPlayer() async {
    if (_liveAssetsAudioPlayer.playlist != null) {
      _liveAssetsAudioPlayer.playlist!.replaceAt(0, (oldAudio) => widget.audio);
    } else {
      await _liveAssetsAudioPlayer.open(
        Playlist(audios: [widget.audio]),
        showNotification: true,
        autoStart: false,
        playInBackground: PlayInBackground.enabled,
      );
      // _largeAssetsAudioPlayer.next();
      // _largeAssetsAudioPlayer.previous();
      // _largeAssetsAudioPlayer.playlistPlayAtIndex(1);
    }
  }

  @override
  void dispose() {
    _liveAssetsAudioPlayer.dispose();
    super.dispose();
  }

  Duration currentPosition(RealtimePlayingInfos infos) => infos.currentPosition;
  Duration duration(RealtimePlayingInfos infos) => infos.duration;

  String playbackStateText(RealtimePlayingInfos infos) {
    final currentPositionString = durationToString(currentPosition(infos));
    final durationString = durationToString(duration(infos));
    return '$currentPositionString/$durationString';
  }

  @override
  Widget build(BuildContext context) =>
      _liveAssetsAudioPlayer.builderRealtimePlayingInfos(
          builder: (context, infos) => PlayerBuilder.isPlaying(
              player: _liveAssetsAudioPlayer,
              builder: (context, isPlaying) {
                final childWidget = GestureDetector(
                  onTap: () {
                    setState(() {
                      mini = !mini;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    height: mini ? 70 : 742,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: widget.fillColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(15, 10, 0, 0),
                      child: mini
                          ? Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/LOVE_IN_MUSIC_(1).png',
                                  height: 50,
                                ),
                                Text(
                                  widget.audio.metas.title ?? 'Audio Title',
                                  style: widget.titleTextStyle,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(34),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: IconButton(
                                      onPressed:
                                          _liveAssetsAudioPlayer.playOrPause,
                                      icon: Icon(
                                        (isPlaying)
                                            ? Icons.pause_circle_filled_rounded
                                            : Icons.play_circle_fill_rounded,
                                        color: widget.playbackButtonColor,
                                        size: 34,
                                      ),
                                      iconSize: 34,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      15, 10, 15, 10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/LOVE_IN_MUSIC_(1).png',
                                        height: 400,
                                      ),
                                      Text(
                                        widget.audio.metas.title ??
                                            'Audio Title',
                                        style: widget.titleTextStyle,
                                      ),
                                      Text(
                                        playbackStateText(infos),
                                        style: widget.playbackDurationTextStyle,
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ClipRRect(
                                        child: Material(
                                      child: IconButton(
                                        onPressed: () {
                                          player.shuffle;
                                        },
                                        icon: Icon(Icons.shuffle),
                                      ),
                                    )),
                                    ClipRRect(
                                        child: Material(
                                      child: IconButton(
                                        onPressed: () {
                                          player.loopMode;
                                        },
                                        icon: Icon(Icons.skip_previous_rounded),
                                      ),
                                    )),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(34),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: IconButton(
                                          onPressed: _liveAssetsAudioPlayer
                                              .playOrPause,
                                          icon: Icon(
                                            (isPlaying)
                                                ? Icons
                                                    .pause_circle_filled_rounded
                                                : Icons
                                                    .play_circle_fill_rounded,
                                            color: widget.playbackButtonColor,
                                            size: 50,
                                          ),
                                          iconSize: 50,
                                        ),
                                      ),
                                    ),
                                    ClipRRect(
                                        child: Material(
                                      child: IconButton(
                                        icon: Icon(Icons.skip_next_rounded),
                                        onPressed: () {},
                                      ),
                                    )),
                                    ClipRRect(
                                        child: Material(
                                      child: IconButton(
                                        icon: Icon(Icons.repeat),
                                        onPressed: () {},
                                      ),
                                    )),
                                  ],
                                ),
                                PositionSeekWidget(
                                  currentPosition: currentPosition(infos),
                                  duration: duration(infos),
                                  seekTo: (to) {
                                    _liveAssetsAudioPlayer.seek(to);
                                  },
                                  activeTrackColor: widget.activeTrackColor,
                                ),
                              ],
                            ),
                    ),
                  ),
                );
                return Material(
                    color: Color.fromARGB(210, 230, 153, 82),
                    elevation: widget.elevation,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: childWidget);
              }));
}

class PositionSeekWidget extends StatefulWidget {
  const PositionSeekWidget({
    required this.currentPosition,
    required this.duration,
    required this.seekTo,
    required this.activeTrackColor,
  });

  final Duration currentPosition;
  final Duration duration;
  final Function(Duration) seekTo;
  final Color activeTrackColor;

  @override
  _PositionSeekWidgetState createState() => _PositionSeekWidgetState();
}

class _PositionSeekWidgetState extends State<PositionSeekWidget> {
  late Duration _visibleValue;
  bool listenOnlyUserInteraction = false;
  double get percent => widget.duration.inMilliseconds == 0
      ? 0
      : _visibleValue.inMilliseconds / widget.duration.inMilliseconds;

  @override
  void initState() {
    super.initState();
    _visibleValue = widget.currentPosition;
  }

  @override
  void didUpdateWidget(PositionSeekWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listenOnlyUserInteraction) {
      _visibleValue = widget.currentPosition;
    }
  }

  @override
  Widget build(BuildContext context) => SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor: widget.activeTrackColor,
          inactiveTrackColor: const Color(0xFFC9D0D5),
          trackShape: const FlutterFlowRoundedRectSliderTrackShape(),
          trackHeight: 6.0,
          thumbShape: SliderComponentShape.noThumb,
          overlayColor: const Color(0xFF57636C).withAlpha(32),
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 12.0),
        ),
        child: Slider(
          min: 0,
          max: widget.duration.inMilliseconds.toDouble(),
          value: math.min(1.0, percent) *
              widget.duration.inMilliseconds.toDouble(),
          onChangeEnd: (newValue) => setState(() {
            listenOnlyUserInteraction = false;
            widget.seekTo(_visibleValue);
          }),
          onChangeStart: (_) =>
              setState(() => listenOnlyUserInteraction = true),
          onChanged: (newValue) => setState(
              () => _visibleValue = Duration(milliseconds: newValue.floor())),
        ),
      );
}

String durationToString(Duration duration) {
  String twoDigits(int n) => (n >= 10) ? '$n' : '0$n';

  final twoDigitMinutes =
      twoDigits(duration.inMinutes.remainder(Duration.minutesPerHour).toInt());
  final twoDigitSeconds = twoDigits(
      duration.inSeconds.remainder(Duration.secondsPerMinute).toInt());
  return '$twoDigitMinutes:$twoDigitSeconds';
}

class FlutterFlowRoundedRectSliderTrackShape extends SliderTrackShape
    with BaseSliderTrackShape {
  /// Create a slider track that draws two rectangles with rounded outer edges.
  const FlutterFlowRoundedRectSliderTrackShape();

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool? isEnabled,
    bool? isDiscrete,
    required TextDirection textDirection,
    double additionalActiveTrackHeight = 0,
  }) {
    assert(sliderTheme.disabledActiveTrackColor != null);
    assert(sliderTheme.disabledInactiveTrackColor != null);
    assert(sliderTheme.activeTrackColor != null);
    assert(sliderTheme.inactiveTrackColor != null);
    assert(sliderTheme.thumbShape != null);
    // If the slider [SliderThemeData.trackHeight] is less than or equal to 0,
    // then it makes no difference whether the track is painted or not,
    // therefore the painting  can be a no-op.
    if (sliderTheme.trackHeight == null || sliderTheme.trackHeight! <= 0) {
      return;
    }

    // Assign the track segment paints, which are leading: active and
    // trailing: inactive.
    final ColorTween activeTrackColorTween = ColorTween(
        begin: sliderTheme.disabledActiveTrackColor,
        end: sliderTheme.activeTrackColor);
    final ColorTween inactiveTrackColorTween = ColorTween(
        begin: sliderTheme.disabledInactiveTrackColor,
        end: sliderTheme.inactiveTrackColor);
    final Paint activePaint = Paint()
      ..color = activeTrackColorTween.evaluate(enableAnimation)!;
    final Paint inactivePaint = Paint()
      ..color = inactiveTrackColorTween.evaluate(enableAnimation)!;
    final Paint leftTrackPaint = activePaint;
    final Paint rightTrackPaint = inactivePaint;

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled ?? false,
      isDiscrete: isDiscrete ?? false,
    );
    const Radius trackRadius = Radius.circular(2.0);
    const Radius activeTrackRadius = Radius.circular(2.0);

    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        thumbCenter.dx - activeTrackRadius.x,
        trackRect.top,
        trackRect.right,
        trackRect.bottom,
        topRight: trackRadius,
        bottomRight: trackRadius,
        topLeft: activeTrackRadius,
        bottomLeft: activeTrackRadius,
      ),
      rightTrackPaint,
    );
    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        trackRect.left,
        trackRect.top - (additionalActiveTrackHeight / 2),
        thumbCenter.dx,
        trackRect.bottom + (additionalActiveTrackHeight / 2),
        topLeft: activeTrackRadius,
        bottomLeft: activeTrackRadius,
        topRight: trackRadius,
        bottomRight: trackRadius,
      ),
      leftTrackPaint,
    );
  }
}

String generateRandomAlphaNumericString() {
  const chars = 'abcdefghijklmnopqrstuvwxyz1234567890';
  return String.fromCharCodes(Iterable.generate(
      8, (_) => chars.codeUnits[math.Random().nextInt(chars.length)]));
}

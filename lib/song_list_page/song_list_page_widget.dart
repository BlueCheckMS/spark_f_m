import 'package:assets_audio_player/assets_audio_player.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'song_list_page_model.dart';
export 'song_list_page_model.dart';

class SongListPageWidget extends StatefulWidget {
  const SongListPageWidget({
    Key? key,
    this.playlist,
    this.music,
    this.singleSong,
    this.podcast,
  }) : super(key: key);

  final PlaylistRecord? playlist;
  final AlbumRecord? music;
  final SongsRecord? singleSong;
  final PodcastRecord? podcast;

  @override
  _SongListPageWidgetState createState() => _SongListPageWidgetState();
}

class AudioPlayerManager {
  static final AudioPlayerManager _instance = AudioPlayerManager._();
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();

  factory AudioPlayerManager() {
    return _instance;
  }

  AssetsAudioPlayer get player => _assetsAudioPlayer;

  AudioPlayerManager._();
}
class _SongListPageWidgetState extends State<SongListPageWidget> {
  late SongListPageModel _model;
  final AudioPlayerManager _audioPlayerManager = AudioPlayerManager();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SongListPageModel());
  
  }
  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<List<SongsRecord>>(
      stream: querySongsRecord(
        queryBuilder: (songsRecord) =>
            songsRecord.where('album', isEqualTo: widget.music?.reference),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBtnText,
            body: Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: SpinKitDualRing(
                  color: Color(0xFFEB4323),
                  size: 50,
                ),
              ),
            ),
          );
        }
        List<SongsRecord> songListPageSongsRecordList = snapshot.data!;
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBtnText,
            appBar: valueOrDefault<bool>(
              widget.podcast == null,
              false,
            )
                ? AppBar(
                    backgroundColor: FlutterFlowTheme.of(context).primary,
                    automaticallyImplyLeading: false,
                    leading: FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30,
                      borderWidth: 1,
                      buttonSize: 60,
                      icon: Icon(
                        Icons.arrow_back,
                        color: Color(0xFFEB4323),
                        size: 30,
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                    ),
                    title: Text(
                      'Start Listening',
                      style:
                          FlutterFlowTheme.of(context).headlineMedium.override(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 16,
                              ),
                    ),
                    actions: [],
                    centerTitle: true,
                    elevation: 2,
                  )
                : null,
            body: Builder(
              builder: (context) {
                if (widget.music != null) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      StreamBuilder<AlbumRecord>(
                        stream:
                            AlbumRecord.getDocument(widget.music!.reference),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: SpinKitDualRing(
                                  color: Color(0xFFEB4323),
                                  size: 50,
                                ),
                              ),
                            );
                          }
                          final containerAlbumRecord = snapshot.data!;
                          return Container(
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: MediaQuery.sizeOf(context).width,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEEEEEE),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Stack(
                                          children: [
                                            Image.asset(
                                              'assets/images/White_Digital_UI_Beauty_Brand_Instagram_Reel.png',
                                              width: MediaQuery.sizeOf(context)
                                                  .width,
                                              height: 320,
                                              fit: BoxFit.cover,
                                            ),
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 50, 0, 0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    valueOrDefault<String>(
                                                      widget.playlist
                                                          ?.playlistImage,
                                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/spark-f-m-2-k3szws/assets/3e0pw8rz460f/Untitled_design_(4).png',
                                                    ),
                                                    width: 200,
                                                    height: 200,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              decoration: BoxDecoration(),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 10, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 10, 0, 0),
                                              child: Text(
                                                valueOrDefault<String>(
                                                  widget.music?.albumTitle,
                                                  'title',
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 16,
                                                          lineHeight: 3,
                                                        ),
                                              ),
                                            ),
                                            StreamBuilder<ArtistRecord>(
                                              stream: ArtistRecord.getDocument(
                                                  widget.music!.artist!),
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 50,
                                                      height: 50,
                                                      child: SpinKitDualRing(
                                                        color:
                                                            Color(0xFFEB4323),
                                                        size: 50,
                                                      ),
                                                    ),
                                                  );
                                                }
                                                final textArtistRecord =
                                                    snapshot.data!;
                                                return Text(
                                                  textArtistRecord.artistName,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            StreamBuilder<ArtistRecord>(
                              stream: ArtistRecord.getDocument(
                                  widget.music!.artist!),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: SpinKitDualRing(
                                        color: Color(0xFFEB4323),
                                        size: 50,
                                      ),
                                    ),
                                  );
                                }
                                final containerArtistRecord = snapshot.data!;
                                return Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          FlutterFlowIconButton(
                                            borderColor: Colors.white,
                                            borderRadius: 30,
                                            borderWidth: 1,
                                            buttonSize: 60,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryBtnText,
                                            icon: Icon(
                                              Icons.shuffle_on,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                              size: 30,
                                            ),
                                            onPressed: () {
                                              print('IconButton pressed ...');
                                            },
                                          ),
                                          FlutterFlowIconButton(
                                            borderColor: Colors.transparent,
                                            borderRadius: 30,
                                            borderWidth: 1,
                                            buttonSize: 60,
                                            icon: Icon(
                                              Icons.play_circle_fill,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                              size: 30,
                                            ),
                                            onPressed: () async {
                                               await FFAppState().audioMetaList(
                                                               artist: containerArtistRecord
                                                                        .artistName,
                                                                       album: widget.music!.reference,
                                                                 songs: widget.music?.songs
                                                                        .toList(),
                                                                   assetsAudioPlayer: _audioPlayerManager.player,
                                                                  index:  0);
                                            },
                                          ),
                                        ],
                                      ),
                                      Builder(
                                        builder: (context) {
                                          final songslist =
                                              songListPageSongsRecordList
                                                  .toList();
                                          if (songslist.isEmpty) {
                                            return Image.asset(
                                              'assets/images/LOVE_IN_MUSIC_(13).png',
                                            );
                                          }
                                          return ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: songslist.length,
                                            itemBuilder:
                                                (context, songslistIndex) {
                                              final songslistItem =
                                                  songslist[songslistIndex];
                                              return StreamBuilder<SongsRecord>(
                                                stream: SongsRecord.getDocument(
                                                    songslistItem.reference),
                                                builder: (context, snapshot) {
                                                  // Customize what your widget looks like when it's loading.
                                                  if (!snapshot.hasData) {
                                                    return Center(
                                                      child: SizedBox(
                                                        width: 50,
                                                        height: 50,
                                                        child: SpinKitDualRing(
                                                          color:
                                                              Color(0xFFEB4323),
                                                          size: 50,
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                  final containerSongsRecord =
                                                      snapshot.data!;
                                                  return InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                      onTap: () async {
                                                        await FFAppState().audioMetaList(
                                                                artist:
                                                                      containerArtistRecord
                                                                          .artistName,
                                                                        album:  widget.music!.reference,
                                                                  songs:    widget.music?.songs
                                                                          .toList(),
                                                                  assetsAudioPlayer: _audioPlayerManager.player,
                                                                   index: songslistIndex);
                                                      },
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                              context)
                                                          .width,
                                                      height: 115,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryBtnText,
                                                      ),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      20,
                                                                      0,
                                                                      10,
                                                                      10),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBtnText,
                                                                ),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Image
                                                                        .network(
                                                                      widget
                                                                          .music!
                                                                          .albumCover,
                                                                      width:
                                                                          100,
                                                                      height:
                                                                          100,
                                                                      fit: BoxFit
                                                                          .fitWidth,
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            15,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              containerSongsRecord.songName,
                                                                              textAlign: TextAlign.start,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Poppins',
                                                                                    color: FlutterFlowTheme.of(context).secondary,
                                                                                  ),
                                                                            ),
                                                                            Align(
                                                                              alignment: AlignmentDirectional(0, 0),
                                                                              child: Text(
                                                                                widget.music!.albumTitle,
                                                                                textAlign: TextAlign.start,
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Poppins',
                                                                                      fontSize: 12,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                            StreamBuilder<ArtistRecord>(
                                                                              stream: ArtistRecord.getDocument(widget.music!.artist!),
                                                                              builder: (context, snapshot) {
                                                                                // Customize what your widget looks like when it's loading.
                                                                                if (!snapshot.hasData) {
                                                                                  return Center(
                                                                                    child: SizedBox(
                                                                                      width: 50,
                                                                                      height: 50,
                                                                                      child: SpinKitDualRing(
                                                                                        color: Color(0xFFEB4323),
                                                                                        size: 50,
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                }
                                                                                final textArtistRecord = snapshot.data!;
                                                                                return Text(
                                                                                  textArtistRecord.artistName,
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: 'Poppins',
                                                                                        color: Color(0xFF575757),
                                                                                        fontSize: 12,
                                                                                        fontWeight: FontWeight.normal,
                                                                                      ),
                                                                                );
                                                                              },
                                                                            ),
                                                                            Text(
                                                                              'Exclusively on Spark FM. ',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Poppins',
                                                                                    fontSize: 10,
                                                                                    fontWeight: FontWeight.normal,
                                                                                  ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (widget.playlist != null) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: MediaQuery.sizeOf(context).width,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Stack(
                                      children: [
                                        Image.asset(
                                          'assets/images/White_Digital_UI_Beauty_Brand_Instagram_Reel.png',
                                          width:
                                              MediaQuery.sizeOf(context).width,
                                          height: 320,
                                          fit: BoxFit.cover,
                                        ),
                                        Align(
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 50, 0, 0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                valueOrDefault<String>(
                                                  widget
                                                      .playlist?.playlistImage,
                                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/spark-f-m-2-k3szws/assets/3e0pw8rz460f/Untitled_design_(4).png',
                                                ),
                                                width: 200,
                                                height: 200,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                decoration: BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 10, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 10, 0, 0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    widget.playlist?.playlistName,
                                                    'n/a',
                                                  ),
                                                  style:
                                                      FlutterFlowTheme.of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily: 'Poppins',
                                                            fontSize: 16,
                                                            lineHeight: 3,
                                                          ),
                                                ),
                                              ),
                                              Text(
                                                valueOrDefault<String>(
                                                  widget
                                                      .playlist?.playlistCreator,
                                                  'creater',
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        FlutterFlowIconButton(
                                          borderColor: Colors.transparent,
                                          borderRadius: 30,
                                          borderWidth: 1,
                                          buttonSize: 60,
                                          fillColor: FlutterFlowTheme.of(context)
                                              .primaryBtnText,
                                          icon: Icon(
                                            Icons.shuffle_on,
                                            color: FlutterFlowTheme.of(context)
                                                .secondary,
                                            size: 30,
                                          ),
                                          onPressed: () {
                                            print('IconButton pressed ...');
                                          },
                                        ),
                                        FlutterFlowIconButton(
                                          borderColor: Colors.transparent,
                                          borderRadius: 30,
                                          borderWidth: 1,
                                          buttonSize: 60,
                                          icon: Icon(
                                            Icons.play_circle_fill,
                                            color: FlutterFlowTheme.of(context)
                                                .secondary,
                                            size: 30,
                                          ),
                                          onPressed: () async {
                                            await FFAppState().audioMetaList(
                                                                  artist:widget.playlist!.playlistCreator,  
                                                                   playlist: widget.playlist!.reference ,
                                                                  songs: widget
                                                                        .playlist!
                                                                        .playlistSongs
                                                                        .toList(),
                                                                  assetsAudioPlayer: _audioPlayerManager.player,
                                                                 index: 0);

                                          },
                                          
                                        ),
                                      ],
                                    ),
                                    Builder(
                                      builder: (context) {
                                        final playListSongs = widget
                                                .playlist?.playlistSongs
                                                ?.toList() ??
                                            [];
                                        if (playListSongs.isEmpty) {
                                          return Image.asset(
                                            'assets/images/No_media_to_display._Come_back_later_for_more!.png',
                                          );
                                        }
                                        return ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: playListSongs.length,
                                          itemBuilder:
                                              (context, playListSongsIndex) {
                                            final playListSongsItem =
                                                playListSongs[playListSongsIndex];
                                            return StreamBuilder<SongsRecord>(
                                              stream: SongsRecord.getDocument(
                                                  playListSongsItem),
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 50,
                                                      height: 50,
                                                      child: SpinKitDualRing(
                                                        color: Color(0xFFEB4323),
                                                        size: 50,
                                                      ),
                                                    ),
                                                  );
                                                }
                                                final containerSongsRecord =
                                                    snapshot.data!;
                                                return Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                          .width,
                                                  height: 115,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBtnText,
                                                  ),
                                                  child:
                                                      StreamBuilder<ArtistRecord>(
                                                    stream:
                                                        ArtistRecord.getDocument(
                                                            containerSongsRecord
                                                                .songArtist!),
                                                    builder: (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Center(
                                                          child: SizedBox(
                                                            width: 50,
                                                            height: 50,
                                                            child:
                                                                SpinKitDualRing(
                                                              color: Color(
                                                                  0xFFEB4323),
                                                              size: 50,
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                      final containerArtistRecord =
                                                          snapshot.data!;
                                                      return InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                                await FFAppState().audioMetaList(
                                                                  artist:containerArtistRecord
                                                                        .artistName,
                                                                   playlist: widget.playlist!.reference ,
                                                                  songs: widget
                                                                        .playlist!
                                                                        .playlistSongs
                                                                        .toList(),
                                                                  assetsAudioPlayer: _audioPlayerManager.player,
                                                                 index: playListSongsIndex);
                                                              },
                                                        child: Container(
                                                          width: 100,
                                                          height: 100,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        20,
                                                                        0,
                                                                        10,
                                                                        10),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBtnText,
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Image
                                                                          .network(
                                                                        containerSongsRecord
                                                                            .songImage,
                                                                        width:
                                                                            100,
                                                                        height:
                                                                            100,
                                                                        fit: BoxFit
                                                                            .fitWidth,
                                                                      ),
                                                                      Align(
                                                                        alignment:
                                                                            AlignmentDirectional(
                                                                                0,
                                                                                0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              15,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                containerSongsRecord.songName,
                                                                                textAlign: TextAlign.start,
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Poppins',
                                                                                      color: FlutterFlowTheme.of(context).secondary,
                                                                                    ),
                                                                              ),
                                                                              Text(
                                                                                containerArtistRecord.artistName,
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Poppins',
                                                                                      color: Color(0xFF575757),
                                                                                      fontSize: 12,
                                                                                      fontWeight: FontWeight.normal,
                                                                                    ),
                                                                              ),
                                                                              Text(
                                                                                'Exclusively on Spark FM. ',
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Poppins',
                                                                                      fontSize: 10,
                                                                                      fontWeight: FontWeight.normal,
                                                                                    ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (widget.singleSong != null) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: MediaQuery.sizeOf(context).width,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Stack(
                                      children: [
                                        Image.asset(
                                          'assets/images/White_Digital_UI_Beauty_Brand_Instagram_Reel.png',
                                          width:
                                              MediaQuery.sizeOf(context).width,
                                          height: 320,
                                          fit: BoxFit.cover,
                                        ),
                                        Align(
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 50, 0, 0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                widget.singleSong!.songImage,
                                                width: 200,
                                                height: 200,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              decoration: BoxDecoration(),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 10, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 10, 0, 0),
                                              child: Text(
                                                valueOrDefault<String>(
                                                  widget.singleSong?.songName,
                                                  'song',
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 16,
                                                          lineHeight: 3,
                                                        ),
                                              ),
                                            ),
                                            StreamBuilder<ArtistRecord>(
                                              stream: ArtistRecord.getDocument(
                                                  widget
                                                      .singleSong!.songArtist!),
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 50,
                                                      height: 50,
                                                      child: SpinKitDualRing(
                                                        color:
                                                            Color(0xFFEB4323),
                                                        size: 50,
                                                      ),
                                                    ),
                                                  );
                                                }
                                                final textArtistRecord =
                                                    snapshot.data!;
                                                return Text(
                                                  textArtistRecord.artistName,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            StreamBuilder<ArtistRecord>(
                              stream: ArtistRecord.getDocument(
                                  widget.singleSong!.songArtist!),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: SpinKitDualRing(
                                        color: Color(0xFFEB4323),
                                        size: 50,
                                      ),
                                    ),
                                  );
                                }
                                final containerArtistRecord = snapshot.data!;
                                return Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          FlutterFlowIconButton(
                                            borderColor: Colors.transparent,
                                            borderRadius: 30,
                                            borderWidth: 1,
                                            buttonSize: 60,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryBtnText,
                                            icon: Icon(
                                              Icons.shuffle_on,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                              size: 30,
                                            ),
                                            onPressed: () {
                                              print('IconButton pressed ...');
                                            },
                                          ),
                                          FlutterFlowIconButton(
                                            borderColor: Colors.transparent,
                                            borderRadius: 30,
                                            borderWidth: 1,
                                            buttonSize: 60,
                                            icon: Icon(
                                              Icons.play_circle_fill,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                              size: 30,
                                            ),
                                            onPressed: () async {
                                           await FFAppState().audioMetaList(
                                              song: widget.singleSong!.reference,
                                              artist: containerArtistRecord.artistName,
                                              assetsAudioPlayer: _audioPlayerManager.player
                                            );
                                            },
                                          ),
                                        ],
                                      ),
                                      ListView(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        children: [
                                          StreamBuilder<SongsRecord>(
                                            stream: SongsRecord.getDocument(
                                                widget.singleSong!.reference),
                                            builder: (context, snapshot) {
                                              // Customize what your widget looks like when it's loading.
                                              if (!snapshot.hasData) {
                                                return Center(
                                                  child: SizedBox(
                                                    width: 50,
                                                    height: 50,
                                                    child: SpinKitDualRing(
                                                      color: Color(0xFFEB4323),
                                                      size: 50,
                                                    ),
                                                  ),
                                                );
                                              }
                                              final containerSongsRecord =
                                                  snapshot.data!;
                                              return InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                   await FFAppState().audioMetaList(
                                              song: widget.singleSong!.reference,
                                              artist: containerArtistRecord.artistName,
                                              assetsAudioPlayer: _audioPlayerManager.player
                                            );
                                                },
                                                child: Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                          .width,
                                                  height: 115,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBtnText,
                                                  ),
                                                  child: Container(
                                                    width: 100,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(20, 0,
                                                                  10, 10),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryBtnText,
                                                            ),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Image.network(
                                                                  widget
                                                                      .singleSong!
                                                                      .songImage,
                                                                  width: 100,
                                                                  height: 100,
                                                                  fit: BoxFit
                                                                      .fitWidth,
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0, 0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            15,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          containerSongsRecord
                                                                              .songName,
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Poppins',
                                                                                color: FlutterFlowTheme.of(context).secondary,
                                                                              ),
                                                                        ),
                                                                        StreamBuilder<
                                                                            ArtistRecord>(
                                                                          stream:
                                                                              ArtistRecord.getDocument(containerSongsRecord.songArtist!),
                                                                          builder:
                                                                              (context, snapshot) {
                                                                            // Customize what your widget looks like when it's loading.
                                                                            if (!snapshot.hasData) {
                                                                              return Center(
                                                                                child: SizedBox(
                                                                                  width: 50,
                                                                                  height: 50,
                                                                                  child: SpinKitDualRing(
                                                                                    color: Color(0xFFEB4323),
                                                                                    size: 50,
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            }
                                                                            final textArtistRecord =
                                                                                snapshot.data!;
                                                                            return Text(
                                                                              textArtistRecord.artistName,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Poppins',
                                                                                    color: Color(0xFF575757),
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.normal,
                                                                                  ),
                                                                            );
                                                                          },
                                                                        ),
                                                                        Text(
                                                                          'Exclusively on Spark FM. ',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Poppins',
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.normal,
                                                                              ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (widget.podcast != null) {
                  return StreamBuilder<List<EpisodesRecord>>(
                    stream: queryEpisodesRecord(),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: SpinKitDualRing(
                              color: Color(0xFFEB4323),
                              size: 50,
                            ),
                          ),
                        );
                      }
                      List<EpisodesRecord> containerEpisodesRecordList =
                          snapshot.data!;
                      return Container(
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 300,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFEEE811),
                                      FlutterFlowTheme.of(context)
                                          .secondaryBackground
                                    ],
                                    stops: [0, 1],
                                    begin: AlignmentDirectional(0, -1),
                                    end: AlignmentDirectional(0, 1),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 44, 16, 1),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FlutterFlowIconButton(
                                        borderColor: Colors.transparent,
                                        borderRadius: 30,
                                        borderWidth: 1,
                                        buttonSize: 40,
                                        icon: Icon(
                                          Icons.arrow_back_ios_new,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 24,
                                        ),
                                        onPressed: () async {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 12, 0, 25),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.network(
                                                widget
                                                    .podcast!.podcastThumbnail,
                                                width: 120,
                                                height: 120,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(16, 0, 0, 0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      valueOrDefault<String>(
                                                        widget.podcast
                                                            ?.podcastName,
                                                        'Spark FM',
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .displaySmall,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 8, 0, 0),
                                                      child: StreamBuilder<
                                                          ArtistRecord>(
                                                        stream: ArtistRecord
                                                            .getDocument(widget
                                                                .podcast!
                                                                .contentCreator!),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child: SizedBox(
                                                                width: 50,
                                                                height: 50,
                                                                child:
                                                                    SpinKitDualRing(
                                                                  color: Color(
                                                                      0xFFEB4323),
                                                                  size: 50,
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          final textArtistRecord =
                                                              snapshot.data!;
                                                          return Text(
                                                            textArtistRecord
                                                                .artistName,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (widget.podcast?.podcastDiscription != null &&
                                  widget.podcast?.podcastDiscription != '')
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 25, 16, 0),
                                  child: Text(
                                    valueOrDefault<String>(
                                      widget.podcast?.podcastDiscription,
                                      'No discription for this podcast',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                        ),
                                  ),
                                ),
                              Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 16, 0, 0),
                                  child: Builder(
                                    builder: (context) {
                                      final eps = containerEpisodesRecordList
                                          .where((e) =>
                                              (e.podcast ==
                                                  widget.podcast?.reference) ||
                                              widget.podcast!.episodes
                                                  .contains(e.reference))
                                          .toList();
                                      if (eps.isEmpty) {
                                        return Image.asset(
                                          'assets/images/No_media_to_display._Come_back_later_for_more!.png',
                                        );
                                      }
                                      return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        primary: false,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: eps.length,
                                        itemBuilder: (context, epsIndex) {
                                          final epsItem = eps[epsIndex];
                                          return Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 0, 16, 16),
                                            child: StreamBuilder<ArtistRecord>(
                                              stream: ArtistRecord.getDocument(
                                                  widget.podcast!
                                                      .contentCreator!),
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 50,
                                                      height: 50,
                                                      child: SpinKitDualRing(
                                                        color:
                                                            Color(0xFFEB4323),
                                                        size: 50,
                                                      ),
                                                    ),
                                                  );
                                                }
                                                final containerArtistRecord =
                                                    snapshot.data!;
                                                return Container(
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFEB4323),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                12, 12, 12, 12),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Most Recent',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodySmall
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBtnText,
                                                              ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      12, 0, 0),
                                                          child: Text(
                                                            epsItem.episodeName,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .titleMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBtnText,
                                                                ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      8, 0, 0),
                                                          child: Text(
                                                            containerArtistRecord
                                                                .artistName,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodySmall
                                                                .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBtnText,
                                                                ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0,
                                                                      12,
                                                                      0,
                                                                      12),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              if (widget.podcast
                                                                      ?.explicit ??
                                                                  true)
                                                                Icon(
                                                                  Icons
                                                                      .explicit,
                                                                  color: Color(
                                                                      0xFFEEE811),
                                                                  size: 24,
                                                                ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            8,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                child: Text(
                                                                  'Mar 25 • 3 hr, 32 min',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .override(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBtnText,
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            if (!(currentUserDocument
                                                                        ?.favoritePodcastEpisodes
                                                                        ?.toList() ??
                                                                    [])
                                                                .contains(epsItem
                                                                    .reference))
                                                              AuthUserStreamWidget(
                                                                builder:
                                                                    (context) =>
                                                                        FlutterFlowIconButton(
                                                                  borderColor:
                                                                      Colors
                                                                          .transparent,
                                                                  borderRadius:
                                                                      30,
                                                                  borderWidth:
                                                                      1,
                                                                  buttonSize:
                                                                      40,
                                                                  icon: Icon(
                                                                    Icons
                                                                        .favorite_border,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 20,
                                                                  ),
                                                                  onPressed:
                                                                      () async {
                                                                    await currentUserReference!
                                                                        .update({
                                                                      'favorite_podcast_episodes':
                                                                          FieldValue
                                                                              .arrayUnion([
                                                                        epsItem
                                                                            .reference
                                                                      ]),
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            if ((currentUserDocument
                                                                        ?.favoritePodcastEpisodes
                                                                        ?.toList() ??
                                                                    [])
                                                                .contains(epsItem
                                                                    .reference))
                                                              AuthUserStreamWidget(
                                                                builder:
                                                                    (context) =>
                                                                        FlutterFlowIconButton(
                                                                  borderColor:
                                                                      Colors
                                                                          .transparent,
                                                                  borderRadius:
                                                                      30,
                                                                  borderWidth:
                                                                      1,
                                                                  buttonSize:
                                                                      40,
                                                                  icon: Icon(
                                                                    Icons
                                                                        .favorite,
                                                                    color: (currentUserDocument?.favoritePodcastEpisodes?.toList() ??
                                                                                [])
                                                                            .contains(epsItem
                                                                                .reference)
                                                                        ? FlutterFlowTheme.of(context)
                                                                            .primary
                                                                        : Color(
                                                                            0x00000000),
                                                                    size: 20,
                                                                  ),
                                                                  onPressed:
                                                                      () async {
                                                                    await currentUserReference!
                                                                        .update({
                                                                      'favorite_podcast_episodes':
                                                                          FieldValue
                                                                              .arrayUnion([
                                                                        epsItem
                                                                            .reference
                                                                      ]),
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            Expanded(
                                                              child: Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        1, 0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          12,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child:
                                                                      FlutterFlowIconButton(
                                                                    borderColor:
                                                                        Colors
                                                                            .transparent,
                                                                    borderRadius:
                                                                        30,
                                                                    borderWidth:
                                                                        1,
                                                                    buttonSize:
                                                                        40,
                                                                    fillColor: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBtnText,
                                                                    icon: Icon(
                                                                      Icons
                                                                          .play_arrow_rounded,
                                                                      color: Color(
                                                                          0xFFEB4323),
                                                                      size: 20,
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      List<DocumentReference> filteredEpisodes = containerEpisodesRecordList
                                                                          .where((e) =>
                                                                              epsItem.podcast ==
                                                                              widget
                                                                                  .podcast?.reference)
                                                                          .map((e) =>
                                                                              epsItem.reference)
                                                                          .toList();

                                                                          if (widget.podcast?.episodes == null) {
                                                                            await FFAppState().audioMetaList(
                                                                          podcast: widget
                                                                              .podcast!
                                                                              .reference,
                                                                          episodes:
                                                                              filteredEpisodes,
                                                                          assetsAudioPlayer:
                                                                              _audioPlayerManager.player,
                                                                          index:
                                                                              epsIndex);
                                                                          } else {
                                                                            await FFAppState().audioMetaList(
                                                                          podcast: widget
                                                                              .podcast!
                                                                              .reference,
                                                                          episodes:
                                                                              widget.podcast!.episodes,
                                                                          assetsAudioPlayer:
                                                                              _audioPlayerManager.player,
                                                                          index:
                                                                              epsIndex);
                                                                          }
                                                                      
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Container(
                    width: double.infinity,
                    height: 795,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Text(
                            'There was an issue',
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ); 
      },
    );
  }
}

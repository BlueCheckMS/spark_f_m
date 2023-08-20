import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'podcas_page_model.dart';
export 'podcas_page_model.dart';

class PodcasPageWidget extends StatefulWidget {
  const PodcasPageWidget({
    Key? key,
    this.podcastDoc,
  }) : super(key: key);

  final PodcastRecord? podcastDoc;

  @override
  _PodcasPageWidgetState createState() => _PodcasPageWidgetState();
}

class _PodcasPageWidgetState extends State<PodcasPageWidget> {
  late PodcasPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PodcasPageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<List<EpisodesRecord>>(
      stream: queryEpisodesRecord(),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
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
        List<EpisodesRecord> podcasPageEpisodesRecordList = snapshot.data!;
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: SingleChildScrollView(
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
                          FlutterFlowTheme.of(context).secondaryBackground
                        ],
                        stops: [0, 1],
                        begin: AlignmentDirectional(0, -1),
                        end: AlignmentDirectional(0, 1),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 44, 16, 1),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 30,
                            borderWidth: 1,
                            buttonSize: 40,
                            icon: Icon(
                              Icons.chevron_left_rounded,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24,
                            ),
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 12, 0, 25),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    widget.podcastDoc!.podcastThumbnail,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 0, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.podcastDoc!.podcastName,
                                          style: FlutterFlowTheme.of(context)
                                              .displaySmall,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 8, 0, 0),
                                          child: StreamBuilder<ArtistRecord>(
                                            stream: ArtistRecord.getDocument(
                                                widget.podcastDoc!
                                                    .contentCreator!),
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
                                              final textArtistRecord =
                                                  snapshot.data!;
                                              return Text(
                                                textArtistRecord.artistName,
                                                style:
                                                    FlutterFlowTheme.of(context)
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
                  if (widget.podcastDoc?.podcastDiscription != null &&
                      widget.podcastDoc?.podcastDiscription != '')
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 25, 16, 0),
                      child: Text(
                        widget.podcastDoc!.podcastDiscription,
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                      ),
                    ),
                  Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                      child: Builder(
                        builder: (context) {
                          final episodes = podcasPageEpisodesRecordList
                              .where((e) =>
                                  e.podcasts
                                      .contains(widget.podcastDoc?.reference) ||
                                  (e.podcast == widget.podcastDoc?.reference))
                              .toList();
                          if (episodes.isEmpty) {
                            return Image.asset(
                              'assets/images/No_media_to_display._Come_back_later_for_more!.png',
                            );
                          }
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: episodes.length,
                            itemBuilder: (context, episodesIndex) {
                              final episodesItem = episodes[episodesIndex];
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 16),
                                child: StreamBuilder<ArtistRecord>(
                                  stream: ArtistRecord.getDocument(
                                      widget.podcastDoc!.contentCreator!),
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
                                    final containerArtistRecord =
                                        snapshot.data!;
                                    return Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFEB4323),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12, 12, 12, 12),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Most Recent',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmall
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryBtnText,
                                                      ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 12, 0, 0),
                                              child: Text(
                                                episodesItem.episodeName,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBtnText,
                                                        ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 8, 0, 0),
                                              child: Text(
                                                containerArtistRecord
                                                    .artistName,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmall
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBtnText,
                                                        ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 12, 0, 12),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  if (widget.podcastDoc
                                                          ?.explicit ??
                                                      true)
                                                    Icon(
                                                      Icons.explicit,
                                                      color: Color(0xFFEEE811),
                                                      size: 24,
                                                    ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                8, 0, 0, 0),
                                                    child: Text(
                                                      'Mar 25 • 3 hr, 32 min',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
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
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                if (!(currentUserDocument
                                                            ?.favoritePodcastEpisodes
                                                            ?.toList() ??
                                                        [])
                                                    .contains(
                                                        episodesItem.reference))
                                                  AuthUserStreamWidget(
                                                    builder: (context) =>
                                                        FlutterFlowIconButton(
                                                      borderColor:
                                                          Colors.transparent,
                                                      borderRadius: 30,
                                                      borderWidth: 1,
                                                      buttonSize: 40,
                                                      icon: Icon(
                                                        Icons.favorite_border,
                                                        color: Colors.white,
                                                        size: 20,
                                                      ),
                                                      onPressed: () async {
                                                        await currentUserReference!
                                                            .update({
                                                          'favorite_podcast_episodes':
                                                              FieldValue
                                                                  .arrayUnion([
                                                            episodesItem
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
                                                    .contains(
                                                        episodesItem.reference))
                                                  AuthUserStreamWidget(
                                                    builder: (context) =>
                                                        FlutterFlowIconButton(
                                                      borderColor:
                                                          Colors.transparent,
                                                      borderRadius: 30,
                                                      borderWidth: 1,
                                                      buttonSize: 40,
                                                      icon: Icon(
                                                        Icons.favorite,
                                                        color: (currentUserDocument
                                                                        ?.favoritePodcastEpisodes
                                                                        ?.toList() ??
                                                                    [])
                                                                .contains(
                                                                    episodesItem
                                                                        .reference)
                                                            ? FlutterFlowTheme
                                                                    .of(context)
                                                                .primary
                                                            : Color(0x00000000),
                                                        size: 20,
                                                      ),
                                                      onPressed: () async {
                                                        await currentUserReference!
                                                            .update({
                                                          'favorite_podcast_episodes':
                                                              FieldValue
                                                                  .arrayUnion([
                                                            episodesItem
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
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  12, 0, 0, 0),
                                                      child:
                                                          FlutterFlowIconButton(
                                                        borderColor:
                                                            Colors.transparent,
                                                        borderRadius: 30,
                                                        borderWidth: 1,
                                                        buttonSize: 40,
                                                        fillColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryBtnText,
                                                        icon: Icon(
                                                          Icons
                                                              .play_arrow_rounded,
                                                          color:
                                                              Color(0xFFEB4323),
                                                          size: 20,
                                                        ),
                                                        onPressed: () async {
                                                          // setState(() {
                                                          //   FFAppState()
                                                          //           .AudioPlayerMeta =
                                                          //       AudioMetaStruct();
                                                          // });
                                                          // if (FFAppState()
                                                          //         .AudioPlayerMeta !=
                                                          //     null) {
                                                          //   setState(() {
                                                          //     FFAppState()
                                                          //         .updateAudioPlayerMetaStruct(
                                                          //       (e) => e
                                                          //         ..title = episodesItem.episodeName
                                                          //         ..artist =
                                                          //             containerArtistRecord
                                                          //                 .artistName
                                                          //         ..image = widget
                                                          //             .podcastDoc
                                                          //             ?.podcastThumbnail
                                                          //         ..audios = podcasPageEpisodesRecordList
                                                          //             .map((e) =>
                                                          //                 e.audioFile)
                                                          //             .toList()
                                                          //         ..selectedSongIndex =
                                                          //             episodesIndex,
                                                          //     );
                                                          //   });
                                                          // }
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
          ),
        );
      },
    );
  }
}

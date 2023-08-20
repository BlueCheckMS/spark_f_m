import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'view_all_podcast_model.dart';
export 'view_all_podcast_model.dart';

class ViewAllPodcastWidget extends StatefulWidget {
  const ViewAllPodcastWidget({
    Key? key,
    this.podcast,
  }) : super(key: key);

  final List<PodcastRecord>? podcast;

  @override
  _ViewAllPodcastWidgetState createState() => _ViewAllPodcastWidgetState();
}

class _ViewAllPodcastWidgetState extends State<ViewAllPodcastWidget> {
  late ViewAllPodcastModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ViewAllPodcastModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back,
              color: Color(0xFFEB4323),
              size: 30.0,
            ),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'View All',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 16.0,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 25.0, 16.0, 5.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Featured in this Category',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              fontSize: 16.0,
                            ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 420.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                  ),
                  child: Builder(
                    builder: (context) {
                      final featuredPodcast = widget.podcast
                              ?.where((e) => e.featuredPodcast)
                              .toList()
                              ?.toList() ??
                          [];
                      if (featuredPodcast.isEmpty) {
                        return Image.asset(
                          'assets/images/No_media_to_display._Come_back_later_for_more!.png',
                        );
                      }
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: featuredPodcast.length,
                        itemBuilder: (context, featuredPodcastIndex) {
                          final featuredPodcastItem =
                              featuredPodcast[featuredPodcastIndex];
                          return Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 8.0, 16.0, 8.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                Navigator.pushNamed(context,
                                  'PodcasPage',
                                  arguments: {
                                    'podcastDoc': featuredPodcastItem,
                                     'extra': <String, dynamic>{
                                    'podcastDoc': featuredPodcastItem,
                                  },
                                  }.withoutNulls,
                                 
                                );
                              },
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.7,
                                height: 40.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 5.0,
                                      color: Color(0x44111417),
                                      offset: Offset(0.0, 2.0),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 12.0, 12.0, 12.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 250.0,
                                              height: 250.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .lineColor,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        2.0, 2.0, 2.0, 2.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0),
                                                  child: Image.network(
                                                    featuredPodcastItem
                                                        .podcastThumbnail,
                                                    width: 100.0,
                                                    height: 100.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 8.0, 0.0, 4.0),
                                              child: Text(
                                                featuredPodcastItem.podcastName,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium,
                                              ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 4.0),
                                                    child: StreamBuilder<
                                                        ArtistRecord>(
                                                      stream: ArtistRecord
                                                          .getDocument(
                                                              featuredPodcastItem
                                                                  .contentCreator!),
                                                      builder:
                                                          (context, snapshot) {
                                                        // Customize what your widget looks like when it's loading.
                                                        if (!snapshot.hasData) {
                                                          return Center(
                                                            child: SizedBox(
                                                              width: 50.0,
                                                              height: 50.0,
                                                              child:
                                                                  SpinKitDualRing(
                                                                color: Color(
                                                                    0xFFEB4323),
                                                                size: 50.0,
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
                                                              .bodySmall
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
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
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 12.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 25.0, 0.0, 0.0),
                        child: Text(
                          'More from this Category',
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                Builder(
                  builder: (context) {
                    final podcast = widget.podcast?.toList() ?? [];
                    if (podcast.isEmpty) {
                      return Image.asset(
                        'assets/images/No_media_to_display._Come_back_later_for_more!.png',
                      );
                    }
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: podcast.length,
                      itemBuilder: (context, podcastIndex) {
                        final podcastItem = podcast[podcastIndex];
                        return InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            Navigator.pushNamed(context,
                              'PodcasPage',
                              arguments: {
                                'podcastDoc': podcastItem,
                                'extra': <String, dynamic>{
                                'podcastDoc': podcastItem,
                              },
                              }.withoutNulls,
                            );
                          },
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: 150.0,
                            decoration: BoxDecoration(
                              color:
                                  FlutterFlowTheme.of(context).primaryBtnText,
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 0.0, 10.0, 10.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 100.0,
                                    decoration: BoxDecoration(),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          podcastItem.podcastThumbnail,
                                          width: 100.0,
                                          height: 100.0,
                                          fit: BoxFit.fitWidth,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 0.0, 0.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                podcastItem.podcastName,
                                                textAlign: TextAlign.start,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium,
                                              ),
                                              StreamBuilder<ArtistRecord>(
                                                stream:
                                                    ArtistRecord.getDocument(
                                                        podcastItem
                                                            .contentCreator!),
                                                builder: (context, snapshot) {
                                                  // Customize what your widget looks like when it's loading.
                                                  if (!snapshot.hasData) {
                                                    return Center(
                                                      child: SizedBox(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        child: SpinKitDualRing(
                                                          color:
                                                              Color(0xFFEB4323),
                                                          size: 50.0,
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
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color:
                                                              Color(0xFF575757),
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  );
                                                },
                                              ),
                                              Text(
                                                'Exclusively on Spark FM.',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 10.0,
                                                          fontWeight:
                                                              FontWeight.normal,
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
                          ),
                        );
                      },
                    );
                  },
                ),
              ].addToEnd(SizedBox(
                  height: FFAppState().isLive || FFAppState().streamPlaying
                      ? 100.0
                      : 40.0)),
            ),
          ),
        ),
      ),
    );
  }
}

import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'live_radio_tab_demo_model.dart';
export 'live_radio_tab_demo_model.dart';

class LiveRadioTabDemoWidget extends StatefulWidget {
  const LiveRadioTabDemoWidget({super.key});

  @override
  State<LiveRadioTabDemoWidget> createState() => _LiveRadioTabDemoWidgetState();
}

class _LiveRadioTabDemoWidgetState extends State<LiveRadioTabDemoWidget>
    with TickerProviderStateMixin {
  late LiveRadioTabDemoModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LiveRadioTabDemoModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 78,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30,
                    borderWidth: 1,
                    buttonSize: 60,
                    icon: Icon(
                      Icons.account_circle_sharp,
                      color: Color(0xFFEB4323),
                      size: 30,
                    ),
                    onPressed: () async {
                      context.pushNamed('EditProfile');
                    },
                  ),
                  Text(
                    'Listen Live',
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 16,
                          letterSpacing: 0,
                        ),
                  ),
                  FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30,
                    borderWidth: 1,
                    buttonSize: 60,
                    icon: Icon(
                      Icons.message,
                      color: Color(0xFFEB4323),
                      size: 30,
                    ),
                    onPressed: () async {
                      context.pushNamed('chat2Main');
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment(0, 0),
                    child: TabBar(
                      labelColor: Colors.black,
                      labelStyle:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                letterSpacing: 0,
                              ),
                      unselectedLabelStyle: TextStyle(),
                      indicatorColor: Color(0xFFEB4323),
                      indicatorWeight: 4,
                      tabs: [
                        Tab(
                          text: 'Spark Live',
                        ),
                        Tab(
                          text: 'Schedule',
                        ),
                      ],
                      controller: _model.tabBarController,
                      onTap: (i) async {
                        [() async {}, () async {}][i]();
                      },
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _model.tabBarController,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    FFAppState().isLive = true;
                                    FFAppState().streamPlaying = false;
                                  });
                                },
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEEEEEE),
                                  ),
                                  child: Image.asset(
                                    'assets/images/7e4837_5719dd637be246169079b5e73f21f381_mv2.webp',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: StreamBuilder<List<ShowsRecord>>(
                                  stream: _model.nowPlayingShow(
                                    requestFn: () => queryShowsRecord(),
                                  ),
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
                                    List<ShowsRecord> containerShowsRecordList =
                                        snapshot.data!;
                                    return Container(
                                      decoration: BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Align(
                                                alignment:
                                                    AlignmentDirectional(0, 0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(18, 25, 0, 0),
                                                  child: Text(
                                                    'On Air Now',
                                                    textAlign: TextAlign.start,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                          letterSpacing: 0,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          if (functions.currentShowCopy(
                                                  containerShowsRecordList
                                                      .toList()) !=
                                              null)
                                            StreamBuilder<ShowsRecord>(
                                              stream: ShowsRecord.getDocument(
                                                  functions
                                                      .currentShowCopy(
                                                          containerShowsRecordList
                                                              .toList())!
                                                      .reference),
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
                                                final containerShowsRecord =
                                                    snapshot.data!;
                                                return Container(
                                                  decoration: BoxDecoration(),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                20, 0, 10, 10),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Image.network(
                                                                containerShowsRecord
                                                                    .showImage,
                                                                width: 100,
                                                                height: 100,
                                                                fit: BoxFit
                                                                    .fitWidth,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            20,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      containerShowsRecord
                                                                          .title,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Poppins',
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondary,
                                                                            letterSpacing:
                                                                                0,
                                                                          ),
                                                                    ),
                                                                    Text(
                                                                      containerShowsRecord
                                                                          .description
                                                                          .maybeHandleOverflow(
                                                                              maxChars: 25),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Poppins',
                                                                            fontSize:
                                                                                12,
                                                                            letterSpacing:
                                                                                0,
                                                                          ),
                                                                    ),
                                                                    Builder(
                                                                      builder:
                                                                          (context) {
                                                                        final djs = containerShowsRecord
                                                                            .dJName
                                                                            .toList();
                                                                        return Wrap(
                                                                          spacing:
                                                                              0,
                                                                          runSpacing:
                                                                              0,
                                                                          alignment:
                                                                              WrapAlignment.start,
                                                                          crossAxisAlignment:
                                                                              WrapCrossAlignment.start,
                                                                          direction:
                                                                              Axis.vertical,
                                                                          runAlignment:
                                                                              WrapAlignment.start,
                                                                          verticalDirection:
                                                                              VerticalDirection.down,
                                                                          clipBehavior:
                                                                              Clip.none,
                                                                          children: List.generate(
                                                                              djs.length,
                                                                              (djsIndex) {
                                                                            final djsItem =
                                                                                djs[djsIndex];
                                                                            return Text(
                                                                              djsItem,
                                                                              textAlign: TextAlign.start,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Poppins',
                                                                                    color: Color(0xFF575757),
                                                                                    letterSpacing: 0,
                                                                                    fontWeight: FontWeight.normal,
                                                                                  ),
                                                                            );
                                                                          }),
                                                                        );
                                                                      },
                                                                    ),
                                                                    Text(
                                                                      'Exclusively on Spark FM. \nInterviews, spotlights, and good music.',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Poppins',
                                                                            fontSize:
                                                                                10,
                                                                            letterSpacing:
                                                                                0,
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
                                                );
                                              },
                                            ),
                                          if (!(functions.currentShowCopy(
                                                  containerShowsRecordList
                                                      .toList()) !=
                                              null))
                                            Container(
                                              width: double.infinity,
                                              height: 100,
                                              decoration: BoxDecoration(),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'No Shows On Air At The Moment',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          letterSpacing: 0,
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
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          18, 25, 0, 0),
                                      child: Text(
                                        'Today\'s Lineup',
                                        textAlign: TextAlign.start,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Colors.black,
                                              fontSize: 18,
                                              letterSpacing: 0,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              StreamBuilder<List<ShowsRecord>>(
                                stream: queryShowsRecord(),
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
                                  List<ShowsRecord> containerShowsRecordList =
                                      snapshot.data!;
                                  return Container(
                                    decoration: BoxDecoration(),
                                    child: Builder(
                                      builder: (context) {
                                        final todayShows = functions
                                                .currentShow(
                                                    containerShowsRecordList
                                                        .toList())
                                                ?.toList() ??
                                            [];
                                        return ListView.builder(
                                          primary: false,
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: todayShows.length,
                                          itemBuilder:
                                              (context, todayShowsIndex) {
                                            final todayShowsItem =
                                                todayShows[todayShowsIndex];
                                            return Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 10, 0, 10),
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                        .width,
                                                decoration: BoxDecoration(),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(20, 0, 20, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Image.network(
                                                        todayShowsItem
                                                            .showImage,
                                                        width: 100,
                                                        height: 100,
                                                        fit: BoxFit.fitWidth,
                                                      ),
                                                      Flexible(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(20,
                                                                      0, 0, 0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                todayShowsItem
                                                                    .title,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Poppins',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondary,
                                                                      letterSpacing:
                                                                          0,
                                                                    ),
                                                              ),
                                                              Text(
                                                                todayShowsItem
                                                                    .description,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                maxLines: 2,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Poppins',
                                                                      fontSize:
                                                                          12,
                                                                      letterSpacing:
                                                                          0,
                                                                    ),
                                                              ),
                                                              Builder(
                                                                builder:
                                                                    (context) {
                                                                  final djs =
                                                                      todayShowsItem
                                                                          .dJName
                                                                          .toList();
                                                                  return Wrap(
                                                                    spacing: 0,
                                                                    runSpacing:
                                                                        0,
                                                                    alignment:
                                                                        WrapAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        WrapCrossAlignment
                                                                            .start,
                                                                    direction: Axis
                                                                        .vertical,
                                                                    runAlignment:
                                                                        WrapAlignment
                                                                            .start,
                                                                    verticalDirection:
                                                                        VerticalDirection
                                                                            .down,
                                                                    clipBehavior:
                                                                        Clip.none,
                                                                    children: List.generate(
                                                                        djs.length,
                                                                        (djsIndex) {
                                                                      final djsItem =
                                                                          djs[djsIndex];
                                                                      return Text(
                                                                        djsItem,
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Poppins',
                                                                              color: Color(0xFF575757),
                                                                              letterSpacing: 0,
                                                                              fontWeight: FontWeight.normal,
                                                                            ),
                                                                      );
                                                                    }),
                                                                  );
                                                                },
                                                              ),
                                                              Text(
                                                                'Exclusively on Spark FM. \nInterviews, spotlights, and good music.',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Poppins',
                                                                      fontSize:
                                                                          10,
                                                                      letterSpacing:
                                                                          0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                    ),
                                                              ),
                                                            ],
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
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        FutureBuilder<List<ShowsRecord>>(
                          future: queryShowsRecordOnce(),
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
                            List<ShowsRecord> columnShowsRecordList =
                                snapshot.data!;
                            return SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children:
                                    List.generate(columnShowsRecordList.length,
                                        (columnIndex) {
                                  final columnShowsRecord =
                                      columnShowsRecordList[columnIndex];
                                  return Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 10, 0, 10),
                                    child: Container(
                                      decoration: BoxDecoration(),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20, 0, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Image.network(
                                              columnShowsRecord.showImage,
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.fitWidth,
                                            ),
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(20, 0, 0, 0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      columnShowsRecord.title,
                                                      textAlign:
                                                          TextAlign.start,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondary,
                                                                letterSpacing:
                                                                    0,
                                                              ),
                                                    ),
                                                    Text(
                                                      columnShowsRecord
                                                          .description,
                                                      textAlign:
                                                          TextAlign.start,
                                                      maxLines: 2,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize: 12,
                                                            letterSpacing: 0,
                                                          ),
                                                    ),
                                                    Text(
                                                      columnShowsRecord.title,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Color(
                                                                0xFF575757),
                                                            letterSpacing: 0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                    ),
                                                    Text(
                                                      'Exclusively on Spark FM. \nInterviews, spotlights, and good music.',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize: 10,
                                                            letterSpacing: 0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            );
                          },
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
    );
  }
}

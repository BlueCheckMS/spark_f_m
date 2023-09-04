import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_youtube_player.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'spark_t_v_demo_model.dart';
export 'spark_t_v_demo_model.dart';

class SparkTVDemoWidget extends StatefulWidget {
  const SparkTVDemoWidget({Key? key}) : super(key: key);

  @override
  _SparkTVDemoWidgetState createState() => _SparkTVDemoWidgetState();
}

class _SparkTVDemoWidgetState extends State<SparkTVDemoWidget> {
  late SparkTVDemoModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SparkTVDemoModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return FutureBuilder<ApiCallResponse>(
      future: FFAppState()
          .sparkTv(
        requestFn: () => SparkFMYoutubeCall.call(),
      )
          .then((result) {
        _model.apiRequestCompleted = true;
        return result;
      }),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: SpinKitDualRing(
                  color: Color(0xFFEB4323),
                  size: 50.0,
                ),
              ),
            ),
          );
        }
        final sparkTVDemoSparkFMYoutubeResponse = snapshot.data!;
        return YoutubeFullScreenWrapper(
          child: GestureDetector(
            onTap: () =>
                FocusScope.of(context).requestFocus(_model.unfocusNode),
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              appBar: AppBar(
                leading: FlutterFlowIconButton(
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
                backgroundColor: Colors.white,
                title: Text('Spark TV'),
                centerTitle: true,
                titleTextStyle:
                    FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 16,
                        ),
                actions: [
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
                      context.pushNamed(
                        'chatsCopy',
                      );
                    },
                  ),
                ],
                elevation: 0,
              ),
              body: SafeArea(
                top: true,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            setState(() {
                              FFAppState().clearSparkTvCache();
                              _model.apiRequestCompleted = false;
                            });
                            await _model.waitForApiRequestCompleted();
                          },
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: 65.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFEB4323),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 30.0, 0.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      await launchURL(
                                          'https://facebook.com/sparkfmonline');
                                    },
                                    child: FaIcon(
                                      FontAwesomeIcons.facebookSquare,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBtnText,
                                      size: 35.0,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 30.0, 0.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      await launchURL(
                                          'https://instagram.com/sparkfmonline');
                                    },
                                    child: FaIcon(
                                      FontAwesomeIcons.instagram,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBtnText,
                                      size: 35.0,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    await launchURL(
                                        'https://www.twitch.tv/sparkfmonline');
                                  },
                                  child: FaIcon(
                                    FontAwesomeIcons.twitch,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBtnText,
                                    size: 35.0,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      30.0, 0.0, 0.0, 0.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      await launchURL(
                                          'https://www.youtube.com/@sparkfmnetwork');
                                    },
                                    child: FaIcon(
                                      FontAwesomeIcons.youtube,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBtnText,
                                      size: 35.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (SparkFMYoutubeCall.channelLive(
                          sparkTVDemoSparkFMYoutubeResponse.jsonBody,
                        ).toString() ==
                        'live')
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10.0, 10.0, 10.0, 0.0),
                        child: FutureBuilder<ApiCallResponse>(
                          future: SparkFMYoutubeCall.call(),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 50.0,
                                  height: 50.0,
                                  child: SpinKitDualRing(
                                    color: Color(0xFFEB4323),
                                    size: 50.0,
                                  ),
                                ),
                              );
                            }
                            final containerSparkFMYoutubeResponse =
                                snapshot.data!;
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: FlutterFlowYoutubePlayer(
                                url:
                                    'https://www.youtube.com/watch?v=${SparkFMYoutubeCall.liveId(
                                  containerSparkFMYoutubeResponse.jsonBody,
                                ).toString()}',
                                autoPlay: false,
                                looping: true,
                                mute: false,
                                showControls: true,
                                showFullScreen: true,
                              ),
                            );
                          },
                        ),
                      ),
                    Builder(
                      builder: (context) {
                        final ch = SparkFMYoutubeCall.channalvideos(
                              sparkTVDemoSparkFMYoutubeResponse.jsonBody,
                            )?.toList() ??
                            [];
                        return RefreshIndicator(
                            child: Expanded(
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: ch.length,
                                itemBuilder: (context, chIndex) {
                                  final chItem = ch[chIndex];
                                  return Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 10.0, 10.0, 10.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed(
                                          'videoPage',
                                          queryParameters: {
                                            'videoId': serializeParam(
                                              getJsonField(
                                                chItem,
                                                r'''$..videoId''',
                                              ).toString(),
                                              ParamType.String,
                                            ),
                                            'videoTitle': serializeParam(
                                              getJsonField(
                                                chItem,
                                                r'''$..title''',
                                              ).toString(),
                                              ParamType.String,
                                            ),
                                            'videoDiscription': serializeParam(
                                              getJsonField(
                                                chItem,
                                                r'''$..description''',
                                              ).toString(),
                                              ParamType.String,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                      child: Container(
                                        width: 100.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4.0,
                                              color: Color(0x33000000),
                                              offset: Offset(0.0, 2.0),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: Image.network(
                                                getJsonField(
                                                  chItem,
                                                  r'''$..thumbnails.default.url''',
                                                ),
                                                width: 100.0,
                                                height: 100.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      10.0, 10.0, 0.0, 10.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 250.0,
                                                    decoration: BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          getJsonField(
                                                            chItem,
                                                            r'''$..title''',
                                                          )
                                                              .toString()
                                                              .maybeHandleOverflow(
                                                                  maxChars: 50),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                        ),
                                                        Text(
                                                          getJsonField(
                                                            chItem,
                                                            r'''$..description''',
                                                          )
                                                              .toString()
                                                              .maybeHandleOverflow(
                                                                maxChars: 50,
                                                                replacement:
                                                                    '…',
                                                              ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 12.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
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
                              ),
                            ),
                            onRefresh: () async {
                              _model.apiResultbpa =
                                  await SparkFMYoutubeCall.call();
                            });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

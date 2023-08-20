import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_audio_player.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'music_stream_demo_model.dart';
export 'music_stream_demo_model.dart';

class MusicStreamDemoWidget extends StatefulWidget {
  const MusicStreamDemoWidget({
    Key? key,
    this.album,
    this.songIndex,
  }) : super(key: key);

  final AlbumRecord? album;
  final int? songIndex;

  @override
  _MusicStreamDemoWidgetState createState() => _MusicStreamDemoWidgetState();
}

class _MusicStreamDemoWidgetState extends State<MusicStreamDemoWidget> {
  late MusicStreamDemoModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MusicStreamDemoModel());
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
              Icons.arrow_back_rounded,
              color: Color(0xFFEB4323),
              size: 30.0,
            ),
            onPressed: () async {
              context.safePop();
            },
          ),
          title: Text(
            'Listen Now',
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: MediaQuery.sizeOf(context).height * 1.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBtnText,
                  ),
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/White_Digital_UI_Beauty_Brand_Instagram_Reel.png',
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: MediaQuery.sizeOf(context).height * 1.0,
                        fit: BoxFit.cover,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 250.0,
                            height: 250.0,
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.sizeOf(context).width * 1.0,
                              maxHeight:
                                  MediaQuery.sizeOf(context).height * 1.0,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFEEEEEE),
                            ),
                            child: Image.network(
                              FFAppState().AudioPlayerMeta.metas.image?.path as String,
                              width: 100.0,
                              height: 100.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 25.0, 0.0, 0.0),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                              ),
                              child: FlutterFlowAudioPlayer(
                                audio: Audio.network(
                                  FFAppState().AudioPlayerMeta.path,
                                  metas: Metas(
                                    id: '2vqf7_-ee0acf1f',
                                    title: FFAppState().AudioPlayerMeta.metas.title,
                                  ),
                                ),
                                titleTextStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                playbackDurationTextStyle:
                                    FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF9D9D9D),
                                          fontSize: 12.0,
                                        ),
                                fillColor: Color(0xFFEEEEEE),
                                playbackButtonColor:
                                    FlutterFlowTheme.of(context).secondary,
                                activeTrackColor: Color(0xFF57636C),
                                elevation: 4.0,
                                pauseOnNavigate: false,
                                playInBackground: PlayInBackground.enabled,
                              ),
                            ),
                          ),
                        ],
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
  }
}

// import '/flutter_flow/flutter_flow_audio_player.dart';
// import '/flutter_flow/flutter_flow_theme.dart';
// import '/flutter_flow/flutter_flow_util.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'music_model.dart';
// export 'music_model.dart';

// class MusicWidget extends StatefulWidget {
//   const MusicWidget({Key? key}) : super(key: key);

//   @override
//   _MusicWidgetState createState() => _MusicWidgetState();
// }

// class _MusicWidgetState extends State<MusicWidget> {
//   late MusicModel _model;

//   @override
//   void setState(VoidCallback callback) {
//     super.setState(callback);
//     _model.onUpdate();
//   }

//   @override
//   void initState() {
//     super.initState();
//     _model = createModel(context, () => MusicModel());
//   }

//   @override
//   void dispose() {
//     _model.maybeDispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     context.watch<FFAppState>();

//     return Column(
//       mainAxisSize: MainAxisSize.max,
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Expanded(
//           child: Container(
//             width: MediaQuery.sizeOf(context).width * 1.0,
//             height: MediaQuery.sizeOf(context).height * 1.0,
//             decoration: BoxDecoration(
//               color: FlutterFlowTheme.of(context).primaryBtnText,
//             ),
//             child: Stack(
//               children: [
//                 Image.asset(
//                   'assets/images/White_Digital_UI_Beauty_Brand_Instagram_Reel.png',
//                   width: MediaQuery.sizeOf(context).width * 1.0,
//                   height: MediaQuery.sizeOf(context).height * 1.0,
//                   fit: BoxFit.cover,
//                 ),
//                 Column(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: 250.0,
//                       height: 250.0,
//                       constraints: BoxConstraints(
//                         maxWidth: MediaQuery.sizeOf(context).width * 1.0,
//                         maxHeight: MediaQuery.sizeOf(context).height * 1.0,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Color(0xFFEEEEEE),
//                       ),
//                       child: Image.network(
//                         FFAppState().AudioPlayerMeta as String,
//                         width: 100.0,
//                         height: 100.0,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     Padding(
//                       padding:
//                           EdgeInsetsDirectional.fromSTEB(0.0, 25.0, 0.0, 0.0),
//                       child: Container(
//                         width: MediaQuery.sizeOf(context).width * 1.0,
//                         height: 100.0,
//                         decoration: BoxDecoration(
//                           color: Color(0xFFEEEEEE),
//                         ),
//                         child: FlutterFlowAudioPlayer(
//                           audio: Audio.network(
//                             FFAppState().AudioPlayerMeta as String,
//                             metas: Metas(
//                               id: '2vqf7_-ca611975',
//                               title: FFAppState().AudioPlayerMeta as String,
//                             ),
//                           ),
//                           titleTextStyle:
//                               FlutterFlowTheme.of(context).bodyMedium.override(
//                                     fontFamily: 'Poppins',
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                           playbackDurationTextStyle:
//                               FlutterFlowTheme.of(context).bodyMedium.override(
//                                     fontFamily: 'Poppins',
//                                     color: Color(0xFF9D9D9D),
//                                     fontSize: 12.0,
//                                   ),
//                           fillColor: Color(0xFFEEEEEE),
//                           playbackButtonColor:
//                               FlutterFlowTheme.of(context).secondary,
//                           activeTrackColor: Color(0xFF57636C),
//                           elevation: 4.0,
//                           pauseOnNavigate: false,
//                           playInBackground: PlayInBackground.enabled,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

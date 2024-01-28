// // Automatic FlutterFlow imports
// import 'package:spark_f_m/flutter_flow/flutter_flow_audio_player.dart';

// import '/backend/backend.dart';
// import '/backend/schema/structs/index.dart';
// import '/flutter_flow/flutter_flow_theme.dart';
// import '/flutter_flow/flutter_flow_util.dart';
// import 'index.dart'; // Imports other custom actions
// import '/flutter_flow/custom_functions.dart'; // Imports custom functions
// import 'package:flutter/material.dart';
// // Begin custom action code
// // DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Future audioMetaList(
//   String artist,
//   List<DocumentReference> songs,
// ) async {
//   FFAppState().audioMediaMetas.clear();

//   for (var song in songs) {
//   Audio audioMeta;
//   DocumentSnapshot songSnapshot = await song.get();
//   Map<String, dynamic> songData = songSnapshot.data() as Map<String, dynamic>;

//    String title = songData['song_name'];
//    String image = songData['song_image'];
//    String audio = songData['song_audioFile'];

//   bool metaExist = FFAppState().audioMediaMetas.any((meta) => 
//         meta.metas.title == title &&
//         meta.path == audio &&
//         meta.metas.image?.path == image
//   );
//     if (!metaExist) {
//     //    FFAppState().audioMediaMetas.artist = artist;
//     // FFAppState().AudioPlayerMeta.audio = audio;
//     // FFAppState().AudioPlayerMeta.image = image;
//     // FFAppState().AudioPlayerMeta.title = title;

//   audioMeta =  Audio.network(
//       audio.toString(),
//       metas: Metas(
//         title: title,
//         image: MetasImage.network(image),
//         artist: artist
//       )
//     );
//     FFAppState().audioMediaMetas.add(audioMeta);
//     }
   
//   }
//   // Add your function code here!
// }

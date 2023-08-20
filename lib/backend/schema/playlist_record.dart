import 'dart:async';

import 'package:from_css_color/from_css_color.dart';
import '/backend/algolia/algolia_manager.dart';
import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PlaylistRecord extends FirestoreRecord {
  PlaylistRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "playlistName" field.
  String? _playlistName;
  String get playlistName => _playlistName ?? '';
  bool hasPlaylistName() => _playlistName != null;

  // "PlaylistCreator" field.
  String? _playlistCreator;
  String get playlistCreator => _playlistCreator ?? '';
  bool hasPlaylistCreator() => _playlistCreator != null;

  // "playlist_image" field.
  String? _playlistImage;
  String get playlistImage => _playlistImage ?? '';
  bool hasPlaylistImage() => _playlistImage != null;

  // "featured_playlist" field.
  bool? _featuredPlaylist;
  bool get featuredPlaylist => _featuredPlaylist ?? false;
  bool hasFeaturedPlaylist() => _featuredPlaylist != null;

  // "playlist_songs" field.
  List<DocumentReference>? _playlistSongs;
  List<DocumentReference> get playlistSongs => _playlistSongs ?? const [];
  bool hasPlaylistSongs() => _playlistSongs != null;

  void _initializeFields() {
    _playlistName = snapshotData['playlistName'] as String?;
    _playlistCreator = snapshotData['PlaylistCreator'] as String?;
    _playlistImage = snapshotData['playlist_image'] as String?;
    _featuredPlaylist = snapshotData['featured_playlist'] as bool?;
    _playlistSongs = getDataList(snapshotData['playlist_songs']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('playlist');

  static Stream<PlaylistRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PlaylistRecord.fromSnapshot(s));

  static Future<PlaylistRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PlaylistRecord.fromSnapshot(s));

  static PlaylistRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PlaylistRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PlaylistRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PlaylistRecord._(reference, mapFromFirestore(data));

  static PlaylistRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) =>
      PlaylistRecord.getDocumentFromData(
        {
          'playlistName': snapshot.data['playlistName'],
          'PlaylistCreator': snapshot.data['PlaylistCreator'],
          'playlist_image': snapshot.data['playlist_image'],
          'featured_playlist': snapshot.data['featured_playlist'],
          'playlist_songs': safeGet(
            () => snapshot.data['playlist_songs'].map((s) => toRef(s)).toList(),
          ),
        },
        PlaylistRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<PlaylistRecord>> search({
    String? term,
    FutureOr<LatLng>? location,
    int? maxResults,
    double? searchRadiusMeters,
    bool useCache = false,
  }) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'playlist',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
            useCache: useCache,
          )
          .then((r) => r.map(fromAlgolia).toList());

  @override
  String toString() =>
      'PlaylistRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PlaylistRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPlaylistRecordData({
  String? playlistName,
  String? playlistCreator,
  String? playlistImage,
  bool? featuredPlaylist,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'playlistName': playlistName,
      'PlaylistCreator': playlistCreator,
      'playlist_image': playlistImage,
      'featured_playlist': featuredPlaylist,
    }.withoutNulls,
  );

  return firestoreData;
}

class PlaylistRecordDocumentEquality implements Equality<PlaylistRecord> {
  const PlaylistRecordDocumentEquality();

  @override
  bool equals(PlaylistRecord? e1, PlaylistRecord? e2) {
    const listEquality = ListEquality();
    return e1?.playlistName == e2?.playlistName &&
        e1?.playlistCreator == e2?.playlistCreator &&
        e1?.playlistImage == e2?.playlistImage &&
        e1?.featuredPlaylist == e2?.featuredPlaylist &&
        listEquality.equals(e1?.playlistSongs, e2?.playlistSongs);
  }

  @override
  int hash(PlaylistRecord? e) => const ListEquality().hash([
        e?.playlistName,
        e?.playlistCreator,
        e?.playlistImage,
        e?.featuredPlaylist,
        e?.playlistSongs
      ]);

  @override
  bool isValidKey(Object? o) => o is PlaylistRecord;
}

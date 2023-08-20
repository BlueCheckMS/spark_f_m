import 'dart:async';

import 'package:from_css_color/from_css_color.dart';
import '/backend/algolia/algolia_manager.dart';
import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SongsRecord extends FirestoreRecord {
  SongsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "song_single" field.
  bool? _songSingle;
  bool get songSingle => _songSingle ?? false;
  bool hasSongSingle() => _songSingle != null;

  // "song_name" field.
  String? _songName;
  String get songName => _songName ?? '';
  bool hasSongName() => _songName != null;

  // "song_details" field.
  String? _songDetails;
  String get songDetails => _songDetails ?? '';
  bool hasSongDetails() => _songDetails != null;

  // "song_image" field.
  String? _songImage;
  String get songImage => _songImage ?? '';
  bool hasSongImage() => _songImage != null;

  // "song_audioFile" field.
  String? _songAudioFile;
  String get songAudioFile => _songAudioFile ?? '';
  bool hasSongAudioFile() => _songAudioFile != null;

  // "song_artist" field.
  DocumentReference? _songArtist;
  DocumentReference? get songArtist => _songArtist;
  bool hasSongArtist() => _songArtist != null;

  // "album" field.
  DocumentReference? _album;
  DocumentReference? get album => _album;
  bool hasAlbum() => _album != null;

  // "single" field.
  bool? _single;
  bool get single => _single ?? false;
  bool hasSingle() => _single != null;

  // "playlist" field.
  List<DocumentReference>? _playlist;
  List<DocumentReference> get playlist => _playlist ?? const [];
  bool hasPlaylist() => _playlist != null;

  void _initializeFields() {
    _songSingle = snapshotData['song_single'] as bool?;
    _songName = snapshotData['song_name'] as String?;
    _songDetails = snapshotData['song_details'] as String?;
    _songImage = snapshotData['song_image'] as String?;
    _songAudioFile = snapshotData['song_audioFile'] as String?;
    _songArtist = snapshotData['song_artist'] as DocumentReference?;
    _album = snapshotData['album'] as DocumentReference?;
    _single = snapshotData['single'] as bool?;
    _playlist = getDataList(snapshotData['playlist']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('songs');

  static Stream<SongsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SongsRecord.fromSnapshot(s));

  static Future<SongsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SongsRecord.fromSnapshot(s));

  static SongsRecord fromSnapshot(DocumentSnapshot snapshot) => SongsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SongsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SongsRecord._(reference, mapFromFirestore(data));

  static SongsRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) =>
      SongsRecord.getDocumentFromData(
        {
          'song_single': snapshot.data['song_single'],
          'song_name': snapshot.data['song_name'],
          'song_details': snapshot.data['song_details'],
          'song_image': snapshot.data['song_image'],
          'song_audioFile': snapshot.data['song_audioFile'],
          'song_artist': safeGet(
            () => toRef(snapshot.data['song_artist']),
          ),
          'album': safeGet(
            () => toRef(snapshot.data['album']),
          ),
          'single': snapshot.data['single'],
          'playlist': safeGet(
            () => snapshot.data['playlist'].map((s) => toRef(s)).toList(),
          ),
        },
        SongsRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<SongsRecord>> search({
    String? term,
    FutureOr<LatLng>? location,
    int? maxResults,
    double? searchRadiusMeters,
    bool useCache = false,
  }) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'songs',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
            useCache: useCache,
          )
          .then((r) => r.map(fromAlgolia).toList());

  @override
  String toString() =>
      'SongsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SongsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSongsRecordData({
  bool? songSingle,
  String? songName,
  String? songDetails,
  String? songImage,
  String? songAudioFile,
  DocumentReference? songArtist,
  DocumentReference? album,
  bool? single,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'song_single': songSingle,
      'song_name': songName,
      'song_details': songDetails,
      'song_image': songImage,
      'song_audioFile': songAudioFile,
      'song_artist': songArtist,
      'album': album,
      'single': single,
    }.withoutNulls,
  );

  return firestoreData;
}

class SongsRecordDocumentEquality implements Equality<SongsRecord> {
  const SongsRecordDocumentEquality();

  @override
  bool equals(SongsRecord? e1, SongsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.songSingle == e2?.songSingle &&
        e1?.songName == e2?.songName &&
        e1?.songDetails == e2?.songDetails &&
        e1?.songImage == e2?.songImage &&
        e1?.songAudioFile == e2?.songAudioFile &&
        e1?.songArtist == e2?.songArtist &&
        e1?.album == e2?.album &&
        e1?.single == e2?.single &&
        listEquality.equals(e1?.playlist, e2?.playlist);
  }

  @override
  int hash(SongsRecord? e) => const ListEquality().hash([
        e?.songSingle,
        e?.songName,
        e?.songDetails,
        e?.songImage,
        e?.songAudioFile,
        e?.songArtist,
        e?.album,
        e?.single,
        e?.playlist
      ]);

  @override
  bool isValidKey(Object? o) => o is SongsRecord;
}

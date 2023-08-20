import 'dart:async';

import 'package:from_css_color/from_css_color.dart';
import '/backend/algolia/algolia_manager.dart';
import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AlbumRecord extends FirestoreRecord {
  AlbumRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "Artist" field.
  DocumentReference? _artist;
  DocumentReference? get artist => _artist;
  bool hasArtist() => _artist != null;

  // "AlbumTitle" field.
  String? _albumTitle;
  String get albumTitle => _albumTitle ?? '';
  bool hasAlbumTitle() => _albumTitle != null;

  // "songs" field.
  List<DocumentReference>? _songs;
  List<DocumentReference> get songs => _songs ?? const [];
  bool hasSongs() => _songs != null;

  // "year" field.
  DateTime? _year;
  DateTime? get year => _year;
  bool hasYear() => _year != null;

  // "duration" field.
  String? _duration;
  String get duration => _duration ?? '';
  bool hasDuration() => _duration != null;

  // "album_cover" field.
  String? _albumCover;
  String get albumCover => _albumCover ?? '';
  bool hasAlbumCover() => _albumCover != null;

  // "featured_Album" field.
  bool? _featuredAlbum;
  bool get featuredAlbum => _featuredAlbum ?? false;
  bool hasFeaturedAlbum() => _featuredAlbum != null;

  // "explicit" field.
  bool? _explicit;
  bool get explicit => _explicit ?? false;
  bool hasExplicit() => _explicit != null;

  // "newRelease" field.
  bool? _newRelease;
  bool get newRelease => _newRelease ?? false;
  bool hasNewRelease() => _newRelease != null;

  void _initializeFields() {
    _artist = snapshotData['Artist'] as DocumentReference?;
    _albumTitle = snapshotData['AlbumTitle'] as String?;
    _songs = getDataList(snapshotData['songs']);
    _year = snapshotData['year'] as DateTime?;
    _duration = snapshotData['duration'] as String?;
    _albumCover = snapshotData['album_cover'] as String?;
    _featuredAlbum = snapshotData['featured_Album'] as bool?;
    _explicit = snapshotData['explicit'] as bool?;
    _newRelease = snapshotData['newRelease'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Album');

  static Stream<AlbumRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AlbumRecord.fromSnapshot(s));

  static Future<AlbumRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AlbumRecord.fromSnapshot(s));

  static AlbumRecord fromSnapshot(DocumentSnapshot snapshot) => AlbumRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AlbumRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AlbumRecord._(reference, mapFromFirestore(data));

  static AlbumRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) =>
      AlbumRecord.getDocumentFromData(
        {
          'Artist': safeGet(
            () => toRef(snapshot.data['Artist']),
          ),
          'AlbumTitle': snapshot.data['AlbumTitle'],
          'songs': safeGet(
            () => snapshot.data['songs'].map((s) => toRef(s)).toList(),
          ),
          'year': safeGet(
            () => DateTime.fromMillisecondsSinceEpoch(snapshot.data['year']),
          ),
          'duration': snapshot.data['duration'],
          'album_cover': snapshot.data['album_cover'],
          'featured_Album': snapshot.data['featured_Album'],
          'explicit': snapshot.data['explicit'],
          'newRelease': snapshot.data['newRelease'],
        },
        AlbumRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<AlbumRecord>> search({
    String? term,
    FutureOr<LatLng>? location,
    int? maxResults,
    double? searchRadiusMeters,
    bool useCache = false,
  }) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'Album',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
            useCache: useCache,
          )
          .then((r) => r.map(fromAlgolia).toList());

  @override
  String toString() =>
      'AlbumRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AlbumRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAlbumRecordData({
  DocumentReference? artist,
  String? albumTitle,
  DateTime? year,
  String? duration,
  String? albumCover,
  bool? featuredAlbum,
  bool? explicit,
  bool? newRelease,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'Artist': artist,
      'AlbumTitle': albumTitle,
      'year': year,
      'duration': duration,
      'album_cover': albumCover,
      'featured_Album': featuredAlbum,
      'explicit': explicit,
      'newRelease': newRelease,
    }.withoutNulls,
  );

  return firestoreData;
}

class AlbumRecordDocumentEquality implements Equality<AlbumRecord> {
  const AlbumRecordDocumentEquality();

  @override
  bool equals(AlbumRecord? e1, AlbumRecord? e2) {
    const listEquality = ListEquality();
    return e1?.artist == e2?.artist &&
        e1?.albumTitle == e2?.albumTitle &&
        listEquality.equals(e1?.songs, e2?.songs) &&
        e1?.year == e2?.year &&
        e1?.duration == e2?.duration &&
        e1?.albumCover == e2?.albumCover &&
        e1?.featuredAlbum == e2?.featuredAlbum &&
        e1?.explicit == e2?.explicit &&
        e1?.newRelease == e2?.newRelease;
  }

  @override
  int hash(AlbumRecord? e) => const ListEquality().hash([
        e?.artist,
        e?.albumTitle,
        e?.songs,
        e?.year,
        e?.duration,
        e?.albumCover,
        e?.featuredAlbum,
        e?.explicit,
        e?.newRelease
      ]);

  @override
  bool isValidKey(Object? o) => o is AlbumRecord;
}

import 'dart:async';

import 'package:from_css_color/from_css_color.dart';
import '/backend/algolia/algolia_manager.dart';
import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ArtistRecord extends FirestoreRecord {
  ArtistRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "artist_name" field.
  String? _artistName;
  String get artistName => _artistName ?? '';
  bool hasArtistName() => _artistName != null;

  // "artist_bio" field.
  String? _artistBio;
  String get artistBio => _artistBio ?? '';
  bool hasArtistBio() => _artistBio != null;

  // "artist_image" field.
  String? _artistImage;
  String get artistImage => _artistImage ?? '';
  bool hasArtistImage() => _artistImage != null;

  // "artist_songs" field.
  List<DocumentReference>? _artistSongs;
  List<DocumentReference> get artistSongs => _artistSongs ?? const [];
  bool hasArtistSongs() => _artistSongs != null;

  // "artist_Albums" field.
  List<DocumentReference>? _artistAlbums;
  List<DocumentReference> get artistAlbums => _artistAlbums ?? const [];
  bool hasArtistAlbums() => _artistAlbums != null;

  // "local_artist" field.
  bool? _localArtist;
  bool get localArtist => _localArtist ?? false;
  bool hasLocalArtist() => _localArtist != null;

  // "featured_artist" field.
  bool? _featuredArtist;
  bool get featuredArtist => _featuredArtist ?? false;
  bool hasFeaturedArtist() => _featuredArtist != null;

  // "genre" field.
  DocumentReference? _genre;
  DocumentReference? get genre => _genre;
  bool hasGenre() => _genre != null;

  void _initializeFields() {
    _artistName = snapshotData['artist_name'] as String?;
    _artistBio = snapshotData['artist_bio'] as String?;
    _artistImage = snapshotData['artist_image'] as String?;
    _artistSongs = getDataList(snapshotData['artist_songs']);
    _artistAlbums = getDataList(snapshotData['artist_Albums']);
    _localArtist = snapshotData['local_artist'] as bool?;
    _featuredArtist = snapshotData['featured_artist'] as bool?;
    _genre = snapshotData['genre'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Artist');

  static Stream<ArtistRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ArtistRecord.fromSnapshot(s));

  static Future<ArtistRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ArtistRecord.fromSnapshot(s));

  static ArtistRecord fromSnapshot(DocumentSnapshot snapshot) => ArtistRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ArtistRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ArtistRecord._(reference, mapFromFirestore(data));

  static ArtistRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) =>
      ArtistRecord.getDocumentFromData(
        {
          'artist_name': snapshot.data['artist_name'],
          'artist_bio': snapshot.data['artist_bio'],
          'artist_image': snapshot.data['artist_image'],
          'artist_songs': safeGet(
            () => snapshot.data['artist_songs'].map((s) => toRef(s)).toList(),
          ),
          'artist_Albums': safeGet(
            () => snapshot.data['artist_Albums'].map((s) => toRef(s)).toList(),
          ),
          'local_artist': snapshot.data['local_artist'],
          'featured_artist': snapshot.data['featured_artist'],
          'genre': safeGet(
            () => toRef(snapshot.data['genre']),
          ),
        },
        ArtistRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<ArtistRecord>> search({
    String? term,
    FutureOr<LatLng>? location,
    int? maxResults,
    double? searchRadiusMeters,
    bool useCache = false,
  }) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'Artist',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
            useCache: useCache,
          )
          .then((r) => r.map(fromAlgolia).toList());

  @override
  String toString() =>
      'ArtistRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ArtistRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createArtistRecordData({
  String? artistName,
  String? artistBio,
  String? artistImage,
  bool? localArtist,
  bool? featuredArtist,
  DocumentReference? genre,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'artist_name': artistName,
      'artist_bio': artistBio,
      'artist_image': artistImage,
      'local_artist': localArtist,
      'featured_artist': featuredArtist,
      'genre': genre,
    }.withoutNulls,
  );

  return firestoreData;
}

class ArtistRecordDocumentEquality implements Equality<ArtistRecord> {
  const ArtistRecordDocumentEquality();

  @override
  bool equals(ArtistRecord? e1, ArtistRecord? e2) {
    const listEquality = ListEquality();
    return e1?.artistName == e2?.artistName &&
        e1?.artistBio == e2?.artistBio &&
        e1?.artistImage == e2?.artistImage &&
        listEquality.equals(e1?.artistSongs, e2?.artistSongs) &&
        listEquality.equals(e1?.artistAlbums, e2?.artistAlbums) &&
        e1?.localArtist == e2?.localArtist &&
        e1?.featuredArtist == e2?.featuredArtist &&
        e1?.genre == e2?.genre;
  }

  @override
  int hash(ArtistRecord? e) => const ListEquality().hash([
        e?.artistName,
        e?.artistBio,
        e?.artistImage,
        e?.artistSongs,
        e?.artistAlbums,
        e?.localArtist,
        e?.featuredArtist,
        e?.genre
      ]);

  @override
  bool isValidKey(Object? o) => o is ArtistRecord;
}

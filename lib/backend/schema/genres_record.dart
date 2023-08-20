import 'dart:async';

import 'package:from_css_color/from_css_color.dart';
import '/backend/algolia/algolia_manager.dart';
import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GenresRecord extends FirestoreRecord {
  GenresRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "genreType" field.
  String? _genreType;
  String get genreType => _genreType ?? '';
  bool hasGenreType() => _genreType != null;

  void _initializeFields() {
    _genreType = snapshotData['genreType'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('genres');

  static Stream<GenresRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => GenresRecord.fromSnapshot(s));

  static Future<GenresRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => GenresRecord.fromSnapshot(s));

  static GenresRecord fromSnapshot(DocumentSnapshot snapshot) => GenresRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static GenresRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      GenresRecord._(reference, mapFromFirestore(data));

  static GenresRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) =>
      GenresRecord.getDocumentFromData(
        {
          'genreType': snapshot.data['genreType'],
        },
        GenresRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<GenresRecord>> search({
    String? term,
    FutureOr<LatLng>? location,
    int? maxResults,
    double? searchRadiusMeters,
    bool useCache = false,
  }) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'genres',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
            useCache: useCache,
          )
          .then((r) => r.map(fromAlgolia).toList());

  @override
  String toString() =>
      'GenresRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is GenresRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createGenresRecordData({
  String? genreType,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'genreType': genreType,
    }.withoutNulls,
  );

  return firestoreData;
}

class GenresRecordDocumentEquality implements Equality<GenresRecord> {
  const GenresRecordDocumentEquality();

  @override
  bool equals(GenresRecord? e1, GenresRecord? e2) {
    return e1?.genreType == e2?.genreType;
  }

  @override
  int hash(GenresRecord? e) => const ListEquality().hash([e?.genreType]);

  @override
  bool isValidKey(Object? o) => o is GenresRecord;
}

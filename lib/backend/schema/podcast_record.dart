import 'dart:async';

import 'package:from_css_color/from_css_color.dart';
import '/backend/algolia/algolia_manager.dart';
import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PodcastRecord extends FirestoreRecord {
  PodcastRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "contentCreator" field.
  DocumentReference? _contentCreator;
  DocumentReference? get contentCreator => _contentCreator;
  bool hasContentCreator() => _contentCreator != null;

  // "podcast_name" field.
  String? _podcastName;
  String get podcastName => _podcastName ?? '';
  bool hasPodcastName() => _podcastName != null;

  // "episodes" field.
  List<DocumentReference>? _episodes;
  List<DocumentReference> get episodes => _episodes ?? const [];
  bool hasEpisodes() => _episodes != null;

  // "Podcast_thumbnail" field.
  String? _podcastThumbnail;
  String get podcastThumbnail => _podcastThumbnail ?? '';
  bool hasPodcastThumbnail() => _podcastThumbnail != null;

  // "featuredPodcast" field.
  bool? _featuredPodcast;
  bool get featuredPodcast => _featuredPodcast ?? false;
  bool hasFeaturedPodcast() => _featuredPodcast != null;

  // "podcast_discription" field.
  String? _podcastDiscription;
  String get podcastDiscription => _podcastDiscription ?? '';
  bool hasPodcastDiscription() => _podcastDiscription != null;

  // "explicit" field.
  bool? _explicit;
  bool get explicit => _explicit ?? false;
  bool hasExplicit() => _explicit != null;

  void _initializeFields() {
    _contentCreator = snapshotData['contentCreator'] as DocumentReference?;
    _podcastName = snapshotData['podcast_name'] as String?;
    _episodes = getDataList(snapshotData['episodes']);
    _podcastThumbnail = snapshotData['Podcast_thumbnail'] as String?;
    _featuredPodcast = snapshotData['featuredPodcast'] as bool?;
    _podcastDiscription = snapshotData['podcast_discription'] as String?;
    _explicit = snapshotData['explicit'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('podcast');

  static Stream<PodcastRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PodcastRecord.fromSnapshot(s));

  static Future<PodcastRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PodcastRecord.fromSnapshot(s));

  static PodcastRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PodcastRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PodcastRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PodcastRecord._(reference, mapFromFirestore(data));

  static PodcastRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) =>
      PodcastRecord.getDocumentFromData(
        {
          'contentCreator': safeGet(
            () => toRef(snapshot.data['contentCreator']),
          ),
          'podcast_name': snapshot.data['podcast_name'],
          'episodes': safeGet(
            () => snapshot.data['episodes'].map((s) => toRef(s)).toList(),
          ),
          'Podcast_thumbnail': snapshot.data['Podcast_thumbnail'],
          'featuredPodcast': snapshot.data['featuredPodcast'],
          'podcast_discription': snapshot.data['podcast_discription'],
          'explicit': snapshot.data['explicit'],
        },
        PodcastRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<PodcastRecord>> search({
    String? term,
    FutureOr<LatLng>? location,
    int? maxResults,
    double? searchRadiusMeters,
    bool useCache = false,
  }) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'podcast',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
            useCache: useCache,
          )
          .then((r) => r.map(fromAlgolia).toList());

  @override
  String toString() =>
      'PodcastRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PodcastRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPodcastRecordData({
  DocumentReference? contentCreator,
  String? podcastName,
  String? podcastThumbnail,
  bool? featuredPodcast,
  String? podcastDiscription,
  bool? explicit,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'contentCreator': contentCreator,
      'podcast_name': podcastName,
      'Podcast_thumbnail': podcastThumbnail,
      'featuredPodcast': featuredPodcast,
      'podcast_discription': podcastDiscription,
      'explicit': explicit,
    }.withoutNulls,
  );

  return firestoreData;
}

class PodcastRecordDocumentEquality implements Equality<PodcastRecord> {
  const PodcastRecordDocumentEquality();

  @override
  bool equals(PodcastRecord? e1, PodcastRecord? e2) {
    const listEquality = ListEquality();
    return e1?.contentCreator == e2?.contentCreator &&
        e1?.podcastName == e2?.podcastName &&
        listEquality.equals(e1?.episodes, e2?.episodes) &&
        e1?.podcastThumbnail == e2?.podcastThumbnail &&
        e1?.featuredPodcast == e2?.featuredPodcast &&
        e1?.podcastDiscription == e2?.podcastDiscription &&
        e1?.explicit == e2?.explicit;
  }

  @override
  int hash(PodcastRecord? e) => const ListEquality().hash([
        e?.contentCreator,
        e?.podcastName,
        e?.episodes,
        e?.podcastThumbnail,
        e?.featuredPodcast,
        e?.podcastDiscription,
        e?.explicit
      ]);

  @override
  bool isValidKey(Object? o) => o is PodcastRecord;
}

import 'dart:async';

import 'package:from_css_color/from_css_color.dart';
import '/backend/algolia/algolia_manager.dart';
import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EpisodesRecord extends FirestoreRecord {
  EpisodesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "podcast" field.
  DocumentReference? _podcast;
  DocumentReference? get podcast => _podcast;
  bool hasPodcast() => _podcast != null;

  // "episode_name" field.
  String? _episodeName;
  String get episodeName => _episodeName ?? '';
  bool hasEpisodeName() => _episodeName != null;

  // "EpisodeDate" field.
  DateTime? _episodeDate;
  DateTime? get episodeDate => _episodeDate;
  bool hasEpisodeDate() => _episodeDate != null;

  // "Episode_Description" field.
  String? _episodeDescription;
  String get episodeDescription => _episodeDescription ?? '';
  bool hasEpisodeDescription() => _episodeDescription != null;

  // "Episode_Duration" field.
  String? _episodeDuration;
  String get episodeDuration => _episodeDuration ?? '';
  bool hasEpisodeDuration() => _episodeDuration != null;

  // "audio_file" field.
  String? _audioFile;
  String get audioFile => _audioFile ?? '';
  bool hasAudioFile() => _audioFile != null;

  // "podcasts" field.
  List<DocumentReference>? _podcasts;
  List<DocumentReference> get podcasts => _podcasts ?? const [];
  bool hasPodcasts() => _podcasts != null;

  void _initializeFields() {
    _podcast = snapshotData['podcast'] as DocumentReference?;
    _episodeName = snapshotData['episode_name'] as String?;
    _episodeDate = snapshotData['EpisodeDate'] as DateTime?;
    _episodeDescription = snapshotData['Episode_Description'] as String?;
    _episodeDuration = snapshotData['Episode_Duration'] as String?;
    _audioFile = snapshotData['audio_file'] as String?;
    _podcasts = getDataList(snapshotData['podcasts']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('episodes');

  static Stream<EpisodesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => EpisodesRecord.fromSnapshot(s));

  static Future<EpisodesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => EpisodesRecord.fromSnapshot(s));

  static EpisodesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      EpisodesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static EpisodesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      EpisodesRecord._(reference, mapFromFirestore(data));

  static EpisodesRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) =>
      EpisodesRecord.getDocumentFromData(
        {
          'podcast': safeGet(
            () => toRef(snapshot.data['podcast']),
          ),
          'episode_name': snapshot.data['episode_name'],
          'EpisodeDate': safeGet(
            () => DateTime.fromMillisecondsSinceEpoch(
                snapshot.data['EpisodeDate']),
          ),
          'Episode_Description': snapshot.data['Episode_Description'],
          'Episode_Duration': snapshot.data['Episode_Duration'],
          'audio_file': snapshot.data['audio_file'],
          'podcasts': safeGet(
            () => snapshot.data['podcasts'].map((s) => toRef(s)).toList(),
          ),
        },
        EpisodesRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<EpisodesRecord>> search({
    String? term,
    FutureOr<LatLng>? location,
    int? maxResults,
    double? searchRadiusMeters,
    bool useCache = false,
  }) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'episodes',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
            useCache: useCache,
          )
          .then((r) => r.map(fromAlgolia).toList());

  @override
  String toString() =>
      'EpisodesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is EpisodesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createEpisodesRecordData({
  DocumentReference? podcast,
  String? episodeName,
  DateTime? episodeDate,
  String? episodeDescription,
  String? episodeDuration,
  String? audioFile,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'podcast': podcast,
      'episode_name': episodeName,
      'EpisodeDate': episodeDate,
      'Episode_Description': episodeDescription,
      'Episode_Duration': episodeDuration,
      'audio_file': audioFile,
    }.withoutNulls,
  );

  return firestoreData;
}

class EpisodesRecordDocumentEquality implements Equality<EpisodesRecord> {
  const EpisodesRecordDocumentEquality();

  @override
  bool equals(EpisodesRecord? e1, EpisodesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.podcast == e2?.podcast &&
        e1?.episodeName == e2?.episodeName &&
        e1?.episodeDate == e2?.episodeDate &&
        e1?.episodeDescription == e2?.episodeDescription &&
        e1?.episodeDuration == e2?.episodeDuration &&
        e1?.audioFile == e2?.audioFile &&
        listEquality.equals(e1?.podcasts, e2?.podcasts);
  }

  @override
  int hash(EpisodesRecord? e) => const ListEquality().hash([
        e?.podcast,
        e?.episodeName,
        e?.episodeDate,
        e?.episodeDescription,
        e?.episodeDuration,
        e?.audioFile,
        e?.podcasts
      ]);

  @override
  bool isValidKey(Object? o) => o is EpisodesRecord;
}

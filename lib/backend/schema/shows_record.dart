import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ShowsRecord extends FirestoreRecord {
  ShowsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "showImage" field.
  String? _showImage;
  String get showImage => _showImage ?? '';
  bool hasShowImage() => _showImage != null;

  // "Title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "Description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "DayofWeek" field.
  String? _dayofWeek;
  String get dayofWeek => _dayofWeek ?? '';
  bool hasDayofWeek() => _dayofWeek != null;

  // "Showtimes" field.
  String? _showtimes;
  String get showtimes => _showtimes ?? '';
  bool hasShowtimes() => _showtimes != null;

  // "DJName" field.
  List<String>? _dJName;
  List<String> get dJName => _dJName ?? const [];
  bool hasDJName() => _dJName != null;

  // "nowPlaying" field.
  bool? _nowPlaying;
  bool get nowPlaying => _nowPlaying ?? false;
  bool hasNowPlaying() => _nowPlaying != null;

  // "ShowOrder" field.
  int? _showOrder;
  int get showOrder => _showOrder ?? 0;
  bool hasShowOrder() => _showOrder != null;

  // "TodaysLineup" field.
  bool? _todaysLineup;
  bool get todaysLineup => _todaysLineup ?? false;
  bool hasTodaysLineup() => _todaysLineup != null;

  void _initializeFields() {
    _showImage = snapshotData['showImage'] as String?;
    _title = snapshotData['Title'] as String?;
    _description = snapshotData['Description'] as String?;
    _dayofWeek = snapshotData['DayofWeek'] as String?;
    _showtimes = snapshotData['Showtimes'] as String?;
    _dJName = getDataList(snapshotData['DJName']);
    _nowPlaying = snapshotData['nowPlaying'] as bool?;
    _showOrder = castToType<int>(snapshotData['ShowOrder']);
    _todaysLineup = snapshotData['TodaysLineup'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('shows');

  static Stream<ShowsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ShowsRecord.fromSnapshot(s));

  static Future<ShowsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ShowsRecord.fromSnapshot(s));

  static ShowsRecord fromSnapshot(DocumentSnapshot snapshot) => ShowsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ShowsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ShowsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ShowsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ShowsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createShowsRecordData({
  String? showImage,
  String? title,
  String? description,
  String? dayofWeek,
  String? showtimes,
  bool? nowPlaying,
  int? showOrder,
  bool? todaysLineup,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'showImage': showImage,
      'Title': title,
      'Description': description,
      'DayofWeek': dayofWeek,
      'Showtimes': showtimes,
      'nowPlaying': nowPlaying,
      'ShowOrder': showOrder,
      'TodaysLineup': todaysLineup,
    }.withoutNulls,
  );

  return firestoreData;
}

class ShowsRecordDocumentEquality implements Equality<ShowsRecord> {
  const ShowsRecordDocumentEquality();

  @override
  bool equals(ShowsRecord? e1, ShowsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.showImage == e2?.showImage &&
        e1?.title == e2?.title &&
        e1?.description == e2?.description &&
        e1?.dayofWeek == e2?.dayofWeek &&
        e1?.showtimes == e2?.showtimes &&
        listEquality.equals(e1?.dJName, e2?.dJName) &&
        e1?.nowPlaying == e2?.nowPlaying &&
        e1?.showOrder == e2?.showOrder &&
        e1?.todaysLineup == e2?.todaysLineup;
  }

  @override
  int hash(ShowsRecord? e) => const ListEquality().hash([
        e?.showImage,
        e?.title,
        e?.description,
        e?.dayofWeek,
        e?.showtimes,
        e?.dJName,
        e?.nowPlaying,
        e?.showOrder,
        e?.todaysLineup
      ]);

  @override
  bool isValidKey(Object? o) => o is ShowsRecord;
}

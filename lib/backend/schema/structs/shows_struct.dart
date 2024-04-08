// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ShowsStruct extends FFFirebaseStruct {
  ShowsStruct({
    String? showDay,
    String? showStartTime,
    String? showEndTime,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _showDay = showDay,
        _showStartTime = showStartTime,
        _showEndTime = showEndTime,
        super(firestoreUtilData);

  // "ShowDay" field.
  String? _showDay;
  String get showDay => _showDay ?? '';
  set showDay(String? val) => _showDay = val;
  bool hasShowDay() => _showDay != null;

  // "showStartTime" field.
  String? _showStartTime;
  String get showStartTime => _showStartTime ?? '';
  set showStartTime(String? val) => _showStartTime = val;
  bool hasShowStartTime() => _showStartTime != null;

  // "ShowEndTime" field.
  String? _showEndTime;
  String get showEndTime => _showEndTime ?? '';
  set showEndTime(String? val) => _showEndTime = val;
  bool hasShowEndTime() => _showEndTime != null;

  static ShowsStruct fromMap(Map<String, dynamic> data) => ShowsStruct(
        showDay: data['ShowDay'] as String?,
        showStartTime: data['showStartTime'] as String?,
        showEndTime: data['ShowEndTime'] as String?,
      );

  static ShowsStruct? maybeFromMap(dynamic data) =>
      data is Map ? ShowsStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'ShowDay': _showDay,
        'showStartTime': _showStartTime,
        'ShowEndTime': _showEndTime,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'ShowDay': serializeParam(
          _showDay,
          ParamType.String,
        ),
        'showStartTime': serializeParam(
          _showStartTime,
          ParamType.String,
        ),
        'ShowEndTime': serializeParam(
          _showEndTime,
          ParamType.String,
        ),
      }.withoutNulls;

  static ShowsStruct fromSerializableMap(Map<String, dynamic> data) =>
      ShowsStruct(
        showDay: deserializeParam(
          data['ShowDay'],
          ParamType.String,
          false,
        ),
        showStartTime: deserializeParam(
          data['showStartTime'],
          ParamType.String,
          false,
        ),
        showEndTime: deserializeParam(
          data['ShowEndTime'],
          ParamType.String,
          false,
        ),
      );

  static ShowsStruct fromAlgoliaData(Map<String, dynamic> data) => ShowsStruct(
        showDay: convertAlgoliaParam(
          data['ShowDay'],
          ParamType.String,
          false,
        ),
        showStartTime: convertAlgoliaParam(
          data['showStartTime'],
          ParamType.String,
          false,
        ),
        showEndTime: convertAlgoliaParam(
          data['ShowEndTime'],
          ParamType.String,
          false,
        ),
        firestoreUtilData: const FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'ShowsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ShowsStruct &&
        showDay == other.showDay &&
        showStartTime == other.showStartTime &&
        showEndTime == other.showEndTime;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([showDay, showStartTime, showEndTime]);
}

ShowsStruct createShowsStruct({
  String? showDay,
  String? showStartTime,
  String? showEndTime,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ShowsStruct(
      showDay: showDay,
      showStartTime: showStartTime,
      showEndTime: showEndTime,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ShowsStruct? updateShowsStruct(
  ShowsStruct? shows, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    shows
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addShowsStructData(
  Map<String, dynamic> firestoreData,
  ShowsStruct? shows,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (shows == null) {
    return;
  }
  if (shows.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && shows.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final showsData = getShowsFirestoreData(shows, forFieldValue);
  final nestedData = showsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = shows.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getShowsFirestoreData(
  ShowsStruct? shows, [
  bool forFieldValue = false,
]) {
  if (shows == null) {
    return {};
  }
  final firestoreData = mapToFirestore(shows.toMap());

  // Add any Firestore field values
  shows.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getShowsListFirestoreData(
  List<ShowsStruct>? showss,
) =>
    showss?.map((e) => getShowsFirestoreData(e, true)).toList() ?? [];

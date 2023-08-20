// ignore_for_file: unnecessary_getters_setters
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AudioMetaStruct extends FFFirebaseStruct {
  AudioMetaStruct({
    String? title,
    String? artist,
    String? image,
    List<String>? audios,
    int? selectedSongIndex,
    double? intt,
    String? audio,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _title = title,
        _artist = artist,
        _image = image,
        _audios = audios,
        _selectedSongIndex = selectedSongIndex,
        _intt = intt,
        _audio = audio,
        super(firestoreUtilData);

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;
  bool hasTitle() => _title != null;

  // "artist" field.
  String? _artist;
  String get artist => _artist ?? '';
  set artist(String? val) => _artist = val;
  bool hasArtist() => _artist != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  set image(String? val) => _image = val;
  bool hasImage() => _image != null;

  // "audios" field.
  List<String>? _audios;
  List<String> get audios => _audios ?? const [];
  set audios(List<String>? val) => _audios = val;
  void updateAudios(Function(List<String>) updateFn) =>
      updateFn(_audios ??= []);
  bool hasAudios() => _audios != null;

  // "SelectedSongIndex" field.
  int? _selectedSongIndex;
  int get selectedSongIndex => _selectedSongIndex ?? 0;
  set selectedSongIndex(int? val) => _selectedSongIndex = val;
  void incrementSelectedSongIndex(int amount) =>
      _selectedSongIndex = selectedSongIndex + amount;
  bool hasSelectedSongIndex() => _selectedSongIndex != null;

  // "intt" field.
  double? _intt;
  double get intt => _intt ?? 0.0;
  set intt(double? val) => _intt = val;
  void incrementIntt(double amount) => _intt = intt + amount;
  bool hasIntt() => _intt != null;

  // "audio" field.
  String? _audio;
  String get audio => _audio ?? '';
  set audio(String? val) => _audio = val;
  bool hasAudio() => _audio != null;

  static AudioMetaStruct fromMap(Map<String, dynamic> data) => AudioMetaStruct(
        title: data['title'] as String?,
        artist: data['artist'] as String?,
        image: data['image'] as String?,
        audios: getDataList(data['audios']),
        selectedSongIndex: castToType<int>(data['SelectedSongIndex']),
        intt: castToType<double>(data['intt']),
        audio: data['audio'] as String?,
      );

  static AudioMetaStruct? maybeFromMap(dynamic data) =>
      data is Map<String, dynamic> ? AudioMetaStruct.fromMap(data) : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'artist': _artist,
        'image': _image,
        'audios': _audios,
        'SelectedSongIndex': _selectedSongIndex,
        'intt': _intt,
        'audio': _audio,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'artist': serializeParam(
          _artist,
          ParamType.String,
        ),
        'image': serializeParam(
          _image,
          ParamType.String,
        ),
        'audios': serializeParam(
          _audios,
          ParamType.String,
          true,
        ),
        'SelectedSongIndex': serializeParam(
          _selectedSongIndex,
          ParamType.int,
        ),
        'intt': serializeParam(
          _intt,
          ParamType.double,
        ),
        'audio': serializeParam(
          _audio,
          ParamType.String,
        ),
      }.withoutNulls;

  static AudioMetaStruct fromSerializableMap(Map<String, dynamic> data) =>
      AudioMetaStruct(
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        artist: deserializeParam(
          data['artist'],
          ParamType.String,
          false,
        ),
        image: deserializeParam(
          data['image'],
          ParamType.String,
          false,
        ),
        audios: deserializeParam<String>(
          data['audios'],
          ParamType.String,
          true,
        ),
        selectedSongIndex: deserializeParam(
          data['SelectedSongIndex'],
          ParamType.int,
          false,
        ),
        intt: deserializeParam(
          data['intt'],
          ParamType.double,
          false,
        ),
        audio: deserializeParam(
          data['audio'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'AudioMetaStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is AudioMetaStruct &&
        title == other.title &&
        artist == other.artist &&
        image == other.image &&
        listEquality.equals(audios, other.audios) &&
        selectedSongIndex == other.selectedSongIndex &&
        intt == other.intt &&
        audio == other.audio;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([title, artist, image, audios, selectedSongIndex, intt, audio]);
}

AudioMetaStruct createAudioMetaStruct({
  String? title,
  String? artist,
  String? image,
  int? selectedSongIndex,
  double? intt,
  String? audio,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    AudioMetaStruct(
      title: title,
      artist: artist,
      image: image,
      selectedSongIndex: selectedSongIndex,
      intt: intt,
      audio: audio,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

AudioMetaStruct? updateAudioMetaStruct(
  AudioMetaStruct? audioMeta, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    audioMeta
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addAudioMetaStructData(
  Map<String, dynamic> firestoreData,
  AudioMetaStruct? audioMeta,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (audioMeta == null) {
    return;
  }
  if (audioMeta.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && audioMeta.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final audioMetaData = getAudioMetaFirestoreData(audioMeta, forFieldValue);
  final nestedData = audioMetaData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = audioMeta.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getAudioMetaFirestoreData(
  AudioMetaStruct? audioMeta, [
  bool forFieldValue = false,
]) {
  if (audioMeta == null) {
    return {};
  }
  final firestoreData = mapToFirestore(audioMeta.toMap());

  // Add any Firestore field values
  audioMeta.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getAudioMetaListFirestoreData(
  List<AudioMetaStruct>? audioMetas,
) =>
    audioMetas?.map((e) => getAudioMetaFirestoreData(e, true)).toList() ?? [];

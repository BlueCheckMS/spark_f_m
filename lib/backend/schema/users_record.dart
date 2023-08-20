import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "password" field.
  String? _password;
  String get password => _password ?? '';
  bool hasPassword() => _password != null;

  // "favorite_podcast" field.
  List<DocumentReference>? _favoritePodcast;
  List<DocumentReference> get favoritePodcast => _favoritePodcast ?? const [];
  bool hasFavoritePodcast() => _favoritePodcast != null;

  // "admin" field.
  bool? _admin;
  bool get admin => _admin ?? false;
  bool hasAdmin() => _admin != null;

  // "favorite_albums" field.
  List<DocumentReference>? _favoriteAlbums;
  List<DocumentReference> get favoriteAlbums => _favoriteAlbums ?? const [];
  bool hasFavoriteAlbums() => _favoriteAlbums != null;

  // "favorite_songs" field.
  List<DocumentReference>? _favoriteSongs;
  List<DocumentReference> get favoriteSongs => _favoriteSongs ?? const [];
  bool hasFavoriteSongs() => _favoriteSongs != null;

  // "favorite_podcast_episodes" field.
  List<DocumentReference>? _favoritePodcastEpisodes;
  List<DocumentReference> get favoritePodcastEpisodes =>
      _favoritePodcastEpisodes ?? const [];
  bool hasFavoritePodcastEpisodes() => _favoritePodcastEpisodes != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _password = snapshotData['password'] as String?;
    _favoritePodcast = getDataList(snapshotData['favorite_podcast']);
    _admin = snapshotData['admin'] as bool?;
    _favoriteAlbums = getDataList(snapshotData['favorite_albums']);
    _favoriteSongs = getDataList(snapshotData['favorite_songs']);
    _favoritePodcastEpisodes =
        getDataList(snapshotData['favorite_podcast_episodes']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  String? password,
  bool? admin,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'password': password,
      'admin': admin,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.password == e2?.password &&
        listEquality.equals(e1?.favoritePodcast, e2?.favoritePodcast) &&
        e1?.admin == e2?.admin &&
        listEquality.equals(e1?.favoriteAlbums, e2?.favoriteAlbums) &&
        listEquality.equals(e1?.favoriteSongs, e2?.favoriteSongs) &&
        listEquality.equals(
            e1?.favoritePodcastEpisodes, e2?.favoritePodcastEpisodes);
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.password,
        e?.favoritePodcast,
        e?.admin,
        e?.favoriteAlbums,
        e?.favoriteSongs,
        e?.favoritePodcastEpisodes
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}

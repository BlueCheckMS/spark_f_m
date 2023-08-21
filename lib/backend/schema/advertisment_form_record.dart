import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AdvertismentFormRecord extends FirestoreRecord {
  AdvertismentFormRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "first_name" field.
  String? _firstName;
  String get firstName => _firstName ?? '';
  bool hasFirstName() => _firstName != null;

  // "last_name" field.
  String? _lastName;
  String get lastName => _lastName ?? '';
  bool hasLastName() => _lastName != null;

  // "company_name" field.
  String? _companyName;
  String get companyName => _companyName ?? '';
  bool hasCompanyName() => _companyName != null;

  // "company_website" field.
  String? _companyWebsite;
  String get companyWebsite => _companyWebsite ?? '';
  bool hasCompanyWebsite() => _companyWebsite != null;

  // "how_did_you_hear_about_us" field.
  String? _howDidYouHearAboutUs;
  String get howDidYouHearAboutUs => _howDidYouHearAboutUs ?? '';
  bool hasHowDidYouHearAboutUs() => _howDidYouHearAboutUs != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "phone" field.
  String? _phone;
  String get phone => _phone ?? '';
  bool hasPhone() => _phone != null;

  // "what_service_are_you_interested_in" field.
  String? _whatServiceAreYouInterestedIn;
  String get whatServiceAreYouInterestedIn =>
      _whatServiceAreYouInterestedIn ?? '';
  bool hasWhatServiceAreYouInterestedIn() =>
      _whatServiceAreYouInterestedIn != null;

  void _initializeFields() {
    _firstName = snapshotData['first_name'] as String?;
    _lastName = snapshotData['last_name'] as String?;
    _companyName = snapshotData['company_name'] as String?;
    _companyWebsite = snapshotData['company_website'] as String?;
    _howDidYouHearAboutUs =
        snapshotData['how_did_you_hear_about_us'] as String?;
    _email = snapshotData['email'] as String?;
    _phone = snapshotData['phone'] as String?;
    _whatServiceAreYouInterestedIn =
        snapshotData['what_service_are_you_interested_in'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('advertisment_form');

  static Stream<AdvertismentFormRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AdvertismentFormRecord.fromSnapshot(s));

  static Future<AdvertismentFormRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => AdvertismentFormRecord.fromSnapshot(s));

  static AdvertismentFormRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AdvertismentFormRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AdvertismentFormRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AdvertismentFormRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AdvertismentFormRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AdvertismentFormRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAdvertismentFormRecordData({
  String? firstName,
  String? lastName,
  String? companyName,
  String? companyWebsite,
  String? howDidYouHearAboutUs,
  String? email,
  String? phone,
  String? whatServiceAreYouInterestedIn,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'first_name': firstName,
      'last_name': lastName,
      'company_name': companyName,
      'company_website': companyWebsite,
      'how_did_you_hear_about_us': howDidYouHearAboutUs,
      'email': email,
      'phone': phone,
      'what_service_are_you_interested_in': whatServiceAreYouInterestedIn,
    }.withoutNulls,
  );

  return firestoreData;
}

class AdvertismentFormRecordDocumentEquality
    implements Equality<AdvertismentFormRecord> {
  const AdvertismentFormRecordDocumentEquality();

  @override
  bool equals(AdvertismentFormRecord? e1, AdvertismentFormRecord? e2) {
    return e1?.firstName == e2?.firstName &&
        e1?.lastName == e2?.lastName &&
        e1?.companyName == e2?.companyName &&
        e1?.companyWebsite == e2?.companyWebsite &&
        e1?.howDidYouHearAboutUs == e2?.howDidYouHearAboutUs &&
        e1?.email == e2?.email &&
        e1?.phone == e2?.phone &&
        e1?.whatServiceAreYouInterestedIn == e2?.whatServiceAreYouInterestedIn;
  }

  @override
  int hash(AdvertismentFormRecord? e) => const ListEquality().hash([
        e?.firstName,
        e?.lastName,
        e?.companyName,
        e?.companyWebsite,
        e?.howDidYouHearAboutUs,
        e?.email,
        e?.phone,
        e?.whatServiceAreYouInterestedIn
      ]);

  @override
  bool isValidKey(Object? o) => o is AdvertismentFormRecord;
}

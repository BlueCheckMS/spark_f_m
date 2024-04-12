import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'update_profile_model.dart';
export 'update_profile_model.dart';

class UpdateProfileWidget extends StatefulWidget {
  const UpdateProfileWidget({super.key});

  @override
  State<UpdateProfileWidget> createState() => _UpdateProfileWidgetState();
}

class _UpdateProfileWidgetState extends State<UpdateProfileWidget> {
  late UpdateProfileModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UpdateProfileModel());

    _model.emailAddressController ??=
        TextEditingController(text: currentUserEmail);
    _model.emailAddressFocusNode ??= FocusNode();

    _model.usernameController ??=
        TextEditingController(text: currentUserDisplayName);
    _model.usernameFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Form(
              key: _model.formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 12),
                    child: TextFormField(
                      controller: _model.emailAddressController,
                      focusNode: _model.emailAddressFocusNode,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Your email address...',
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF57636C),
                                  fontSize: 14,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                ),
                        hintText: 'Enter your email',
                        hintStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF57636C),
                                  fontSize: 14,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFEB4323),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsetsDirectional.fromSTEB(24, 24, 20, 24),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF1D2429),
                            fontSize: 14,
                            letterSpacing: 0,
                            fontWeight: FontWeight.normal,
                          ),
                      validator: _model.emailAddressControllerValidator
                          .asValidator(context),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 12),
                    child: AuthUserStreamWidget(
                      builder: (context) => TextFormField(
                        controller: _model.usernameController,
                        focusNode: _model.usernameFocusNode,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'User Name',
                          labelStyle:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF57636C),
                                    fontSize: 14,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                  ),
                          hintText: 'Enter your user name.',
                          hintStyle:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF57636C),
                                    fontSize: 14,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                  ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFEB4323),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(24, 24, 20, 24),
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF1D2429),
                              fontSize: 14,
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal,
                            ),
                        validator: _model.usernameControllerValidator
                            .asValidator(context),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).secondary,
                        ),
                      ),
                      child: AuthUserStreamWidget(
                        builder: (context) => ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            valueOrDefault<String>(
                              () {
                                if ((_model.profileImage != null &&
                                        _model.profileImage != '') &&
                                    (_model.profileImage != null &&
                                        _model.profileImage != '') &&
                                    (_model.profileImage != currentUserPhoto)) {
                                  return _model.profileImage;
                                } else if (currentUserPhoto != null &&
                                    currentUserPhoto != '') {
                                  return currentUserPhoto;
                                } else {
                                  return _model.profileImage;
                                }
                              }(),
                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/spark-f-m-2-k3szws/assets/q4jyjq9fdvw8/social-media-chatting-online-blank-profile-picture-head-and-body-icon-people-standing-icon-grey-background-free-vector.jpg',
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                    child: FFButtonWidget(
                      onPressed: () async {
                        final selectedMedia =
                            await selectMediaWithSourceBottomSheet(
                          context: context,
                          allowPhoto: true,
                        );
                        if (selectedMedia != null &&
                            selectedMedia.every((m) =>
                                validateFileFormat(m.storagePath, context))) {
                          setState(() => _model.isDataUploading = true);
                          var selectedUploadedFiles = <FFUploadedFile>[];

                          var downloadUrls = <String>[];
                          try {
                            selectedUploadedFiles = selectedMedia
                                .map((m) => FFUploadedFile(
                                      name: m.storagePath.split('/').last,
                                      bytes: m.bytes,
                                      height: m.dimensions?.height,
                                      width: m.dimensions?.width,
                                      blurHash: m.blurHash,
                                    ))
                                .toList();

                            downloadUrls = (await Future.wait(
                              selectedMedia.map(
                                (m) async =>
                                    await uploadData(m.storagePath, m.bytes),
                              ),
                            ))
                                .where((u) => u != null)
                                .map((u) => u!)
                                .toList();
                          } finally {
                            _model.isDataUploading = false;
                          }
                          if (selectedUploadedFiles.length ==
                                  selectedMedia.length &&
                              downloadUrls.length == selectedMedia.length) {
                            setState(() {
                              _model.uploadedLocalFile =
                                  selectedUploadedFiles.first;
                              _model.uploadedFileUrl = downloadUrls.first;
                            });
                          } else {
                            setState(() {});
                            return;
                          }
                        }

                        setState(() {
                          _model.profileImage = _model.uploadedFileUrl;
                        });
                      },
                      text: 'Update Profile Image',
                      options: FFButtonOptions(
                        height: 50,
                        padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: FlutterFlowTheme.of(context).secondary,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  letterSpacing: 0,
                                ),
                        elevation: 3,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: FFButtonWidget(
                      onPressed: () async {
                        await currentUserReference!
                            .update(createUsersRecordData(
                          email: _model.emailAddressController.text,
                          displayName: _model.usernameController.text,
                          photoUrl: valueOrDefault<String>(
                            () {
                              if ((_model.profileImage != null &&
                                      _model.profileImage != '') &&
                                  (_model.profileImage != null &&
                                      _model.profileImage != '') &&
                                  (_model.profileImage != currentUserPhoto)) {
                                return _model.profileImage;
                              } else if (currentUserPhoto != null &&
                                  currentUserPhoto != '') {
                                return currentUserPhoto;
                              } else {
                                return _model.profileImage;
                              }
                            }(),
                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/spark-f-m-2-k3szws/assets/q4jyjq9fdvw8/social-media-chatting-online-blank-profile-picture-head-and-body-icon-people-standing-icon-grey-background-free-vector.jpg',
                          ),
                        ));
                        Navigator.pop(context);
                      },
                      text: 'Save',
                      options: FFButtonOptions(
                        width: 170,
                        height: 50,
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: Color(0xFF090F13),
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: 16,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                        elevation: 3,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

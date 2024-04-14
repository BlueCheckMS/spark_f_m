import 'package:spark_f_m/flutter_flow/flutter_flow_icon_button.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'about_us_model.dart';
export 'about_us_model.dart';

class AboutUsWidget extends StatefulWidget {
  const AboutUsWidget({Key? key}) : super(key: key);

  @override
  _AboutUsWidgetState createState() => _AboutUsWidgetState();
}

class _AboutUsWidgetState extends State<AboutUsWidget> {
  late AboutUsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AboutUsModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: Icon(
              Icons.account_circle_sharp,
              color: Color(0xFFEB4323),
              size: 30,
            ),
            onPressed: () async {
              context.pushNamed('EditProfile');
            },
          ),
          backgroundColor: Colors.white,
          title: Text('About Us'),
          centerTitle: true,
          titleTextStyle: FlutterFlowTheme.of(context).headlineMedium.override(
                fontFamily: 'Poppins',
                color: Colors.black,
                fontSize: 16,
              ),
          actions: [
            FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              borderWidth: 1,
              buttonSize: 60,
              icon: Icon(
                Icons.message,
                color: Color(0xFFEB4323),
                size: 30,
              ),
              onPressed: () async {
                context.pushNamed('chat2Main');
              },
            ),
          ],
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(
                  'assets/images/7e4837_5719dd637be246169079b5e73f21f381_mv2.webp',
                  fit: BoxFit.fill,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBtnText,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 35.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 25.0, 0.0, 0.0),
                                child: Text(
                                  'MORE THAN MUSIC',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              SizedBox(
                                width: 250.0,
                                child: Divider(
                                  thickness: 3.0,
                                  color: FlutterFlowTheme.of(context).warning,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 15.0, 15.0, 0.0),
                                child: Text(
                                  'Spark FM Online is a digital radio platform that was created to empower and amplify the underserved voices of the community.',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 15.0, 15.0, 25.0),
                                child: Text(
                                  'Based in Boston, Ma, our station provides a local and professional platform where DJ’s, personalities, and artists have the unique opportunity to create their own messaging, mixes, and music, while engaging listeners on both the neighborhood and national levels.\n\n​While sharing the artistry of both local and mainstream artists is at the heart of Spark FM, we are way more than just your average radio station. One of our primary goals is to intentionally invest in the community through partnerships, community service, and providing access to important information and resources. At Spark FM, our programming is reliable, relevant, and relatable.',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  context.pushNamed('Advertise');
                                },
                                text: 'Advertise With Us',
                                options: FFButtonOptions(
                                  width: 180.0,
                                  height: 50.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).secondary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                      ),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).primaryText,
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'MEET THE TEAM',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBtnText,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 25.0, 0.0, 25.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 25.0, 0.0, 0.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(250.0),
                                  child: Image.asset(
                                    'assets/images/image0+(6).webp',
                                    width: 260.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 15.0, 15.0, 0.0),
                                child: Text(
                                  'DANIELLE JOHNSON\nFOUNDER & CEO',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              SizedBox(
                                width: 250.0,
                                child: Divider(
                                  thickness: 3.0,
                                  color: FlutterFlowTheme.of(context).warning,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 15.0, 15.0, 25.0),
                                child: Text(
                                  'Danielle Johnson, widely known as Ms. HotSauce, has encompassed the essence of her stage name, combining her fun-loving appeal and fiery sense of humor to any stage, Room,  and/or airwaves.\n\nBorn in Boston, Massachusetts, HotSauce is a mom, a radio personality, speaker, MC, and creator. In 2020 Danielle Launched the First Black Female Owned Digital Radio station in Boston, Spark FM. Spark FM Online is a national digital radio station amplifying, and empowering the underserved voice of the urban and Caribbean community.',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 25.0, 0.0, 25.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 25.0, 0.0, 0.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(250.0),
                                  child: Image.asset(
                                    'assets/images/6BACDCDE-A12A-4A80-8045-CEFAE0BA4CB2.webp',
                                    width: 260.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 15.0, 15.0, 0.0),
                                child: Text(
                                  'GARRY BANTON\nOPERATIONS DIRECTOR',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              SizedBox(
                                width: 250.0,
                                child: Divider(
                                  thickness: 3.0,
                                  color: FlutterFlowTheme.of(context).warning,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 15.0, 15.0, 25.0),
                                child: Text(
                                  'Garry White better known by his DJ name, Garry Banton, migrated to the US in 1997 with his family. Garry’s love and passion for music was sparked by his older brother, Darryl White. Keeping the legacy of his brother alive, Garry has been a dj since 1999. Now, as widely requested and respected DJ withIn his community and currently the Operations director and resident DJ at Spark FM. His influence and experience have helped to propel spark FM to the gem that it is today.\n\nGarry brings a wealth of knowledge and experience with him, having done everything from working the street teams for major radio stations such as WILD, Hot97, Choice102.9, and Vibes105.3, to being an on air personality and nightclub promoter over the past 20 years. Garry’s influence in radio and the Caribbean culture is undeniable.',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 25.0, 0.0, 25.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 25.0, 0.0, 0.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(250.0),
                                  child: Image.asset(
                                    'assets/images/SparkFM_RockStoneTrizz-502.webp',
                                    width: 260.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 15.0, 15.0, 0.0),
                                child: Text(
                                  'TRYSTIN JOHNSON\nSTATION MANAGER',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              SizedBox(
                                width: 250.0,
                                child: Divider(
                                  thickness: 3.0,
                                  color: FlutterFlowTheme.of(context).warning,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 15.0, 15.0, 25.0),
                                child: Text(
                                  'Rockstone Trizz Born in Dorchester to Caribbean & Latin X parents.  Trizz has been a staple in Boston\'s entertainment scene for the past 15 years. His sound can be described as a fusion of Urban Caribbean with a global fusion approach.\n\nApart from being a DJ, He is 1/3 Co-Host on #SaucyAndFriends Mornin Show, co-host of Loud After Dark, Station Manager of Spark FM Online, Owner of Friends Lifestyle Group and Owner of Born 2 Prosper Graphics. \n\nHe\'s worked for the likes of Major Lazer, Missy Elliott, Timbaland, Macy\'s, Champion,  Louie \"Ox\" Rankin, Free (Bet) and more.',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 25.0, 0.0, 25.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 25.0, 0.0, 0.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(250.0),
                                  child: Image.asset(
                                    'assets/images/Tayla_Andre_MW_1-3.webp',
                                    width: 260.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 15.0, 15.0, 0.0),
                                child: Text(
                                  'TAYLA ANDRE\nCOMMUNITY BUSINESS MANAGER',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              SizedBox(
                                width: 250.0,
                                child: Divider(
                                  thickness: 3.0,
                                  color: FlutterFlowTheme.of(context).warning,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 15.0, 15.0, 25.0),
                                child: Text(
                                  'Tayla Andre exemplifies the true meaning of \"working for the people\". Her extensive background involves a platform that not only is of influence to a large masses of people but to her community in which she is passionate about.\n\n​While a ‘Jill’ of many trades, her eagerness to learn and educate others, affinity for activism and urgency to unify communities coupled with her background as a community outreach volunteer, mentor, counselor, social media connoisseur and marketer have all prompted her pursuit of a career in real estate. ',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 25.0, 0.0, 50.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 25.0, 0.0, 0.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(250.0),
                                  child: Image.asset(
                                    'assets/images/DJ_WhySham_Tues_Thurs_1pm-3pm_JPG.webp',
                                    width: 260.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 15.0, 15.0, 0.0),
                                child: Text(
                                  'SHAMARA RHODES\nCOMMUNITY LIASON',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              SizedBox(
                                width: 250.0,
                                child: Divider(
                                  thickness: 3.0,
                                  color: FlutterFlowTheme.of(context).warning,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 15.0, 15.0, 25.0),
                                child: Text(
                                  'DJ WhySham, is a Dorchester Native, God-parent, Sister, Activist, Traveler and #YourCommunityDJ. WhySham is the visionary of Bringing Back Boston (BBBMA) now known as “The Social Justice Trap Movement“; Creator of “Boston Got Next“; and On-air Radio Personality on SparkFM Online’s (Lunch Is Ova). \n\nWhySham is a part of the 2021 WBUR ARTery’s Top 25 cohort and was the only womxn nominated for New England Music 2021 Awards \"Producer of the Year”. WhySham is also a 3x Boston Music Award nominee for ‘DJ of The Year’.',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

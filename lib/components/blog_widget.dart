import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'blog_model.dart';
export 'blog_model.dart';

class BlogWidget extends StatefulWidget {
  const BlogWidget({
    Key? key,
    required this.postUrl,
  }) : super(key: key);

  final String? postUrl;

  @override
  _BlogWidgetState createState() => _BlogWidgetState();
}

class _BlogWidgetState extends State<BlogWidget> {
  late BlogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BlogModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: 360.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: FlutterFlowWebView(
        content: widget.postUrl!,
        bypass: false,
        width: MediaQuery.sizeOf(context).width * 0.8,
        height: MediaQuery.sizeOf(context).height * 1.0,
        verticalScroll: false,
        horizontalScroll: false,
      ),
    );
  }
}

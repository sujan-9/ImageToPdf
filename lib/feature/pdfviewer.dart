import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:device_info_plus/device_info_plus.dart';

class PDFViewer extends StatefulWidget {
  String path;
  PDFViewer({super.key, required this.path});

  @override
  State<PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    String name = widget.path.split('/').last;
    return Scaffold(
      appBar: AppBar(
        title: Text(
        //  name.length > 0 ? '${name.substring(0, 20)}...pdf' :
           name,
          style: const TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      body: SfPdfViewer.file(
        File(widget.path),
        key: _pdfViewerKey,
      ),
    );
  }
}

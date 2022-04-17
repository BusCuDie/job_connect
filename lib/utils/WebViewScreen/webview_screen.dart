import 'dart:io';
import "package:flutter/material.dart";
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  WebViewScreen(this.url, {Key? key}) : super(key: key);
  @override
  State<WebViewScreen> createState() => WebViewState();
}

class WebViewState extends State<WebViewScreen> {
  PdfViewerController _pdfViewerController = PdfViewerController();
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Syncfusion Flutter PdfViewer'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.keyboard_arrow_up,
                color: Colors.white,
              ),
              onPressed: () {
                _pdfViewerController.previousPage();
              },
            ),
            IconButton(
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
              onPressed: () {
                _pdfViewerController.nextPage();
              },
            ),
            IconButton(
              icon: Icon(
                Icons.zoom_in,
                color: Colors.white,
              ),
              onPressed: () {
                _pdfViewerController.zoomLevel = 2;
              },
            ),
            IconButton(
              icon: Icon(
                Icons.zoom_out,
                color: Colors.white,
              ),
              onPressed: () {
                _pdfViewerController.zoomLevel = 1;
              },
            ),
            IconButton(
              icon: Icon(
                Icons.bookmark,
                color: Colors.white,
              ),
              onPressed: () {
                _pdfViewerKey.currentState?.openBookmarkView();
              },
            ),
          ],
        ),
        body: SfPdfViewer.network(widget.url,
            controller: _pdfViewerController,
            key: _pdfViewerKey,
            canShowScrollHead: false,
            canShowScrollStatus: false,
            enableDoubleTapZooming: true,
            canShowPaginationDialog: true,
           ));
  }
}

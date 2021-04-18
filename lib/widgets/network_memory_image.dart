import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkMemoryImage extends StatefulWidget {
  NetworkMemoryImage({this.src});

  final String src;

  @override
  _NetworkMemoryImageState createState() => _NetworkMemoryImageState();
}

class _NetworkMemoryImageState extends State<NetworkMemoryImage> {
  Uint8List _bytes;
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    var url = Uri.parse(widget.src);
    _bytes = (await http.get(url)).bodyBytes;

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return _bytes != null ? Image.memory(_bytes) : Container();
  }
}

import 'package:flutter/material.dart';
import 'package:pinch_zoom_image_last/pinch_zoom_image_last.dart';

class PhotoZoomView extends StatelessWidget {
  final Image img;
  PhotoZoomView(this.img);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: PinchZoomImage(
          image: img,
          zoomedBackgroundColor: Colors.white,
          hideStatusBarWhileZooming: false,
          onZoomStart: () {
            print('Zoom started');
          },
          onZoomEnd: () {
            print('Zoom finished');
          },
        ),
      ),
    );
  }
}

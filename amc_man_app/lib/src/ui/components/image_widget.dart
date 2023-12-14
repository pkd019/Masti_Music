import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../global/image_handler.dart';
import '../../extensions/snack_bar.dart';
import '../screens/map_asset/image_bloc/bloc/image_bloc.dart';

class ImageWidget extends StatefulWidget {
  const ImageWidget({super.key});

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  final ImageHandler imageHandler = ImageHandler();
  List<File> _imageFiles = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImageBloc, ImageState>(
      listener: (context, state) {
        context.showSnackbar(state.errorMessage!);
        _imageFiles = state.imageFiles!;
      },
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            FutureBuilder<void>(
              future: imageHandler.retrieveLostImageFile(),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const _ImageWidgetRow(
                      image1: Text(''),
                      image2: Text(''),
                    );
                  case ConnectionState.done:
                    final imageList = state.imageFiles;
                    return _ImageWidgetRow(
                      image1: imageHandler.previewImage(
                          imageList!.isNotEmpty ? imageList[0] : imageList[1]),
                      image2: imageHandler.previewImage(
                        imageList.length > 1 ? imageList[1] : imageList[0],
                      ),
                    );
                  default:
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return const _ImageWidgetRow(
                        image1: Text(''),
                        image2: Text(''),
                      );
                    }
                }
              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton.icon(
              onPressed: () {
                BlocProvider.of<ImageBloc>(context).add(
                  CaptureImage(
                      imageHandler: imageHandler, imageFiles: _imageFiles),
                );
              },
              icon: const Icon(Icons.add_a_photo, size: 20.0),
              label: const Text('Add Asset Photo'),
              style: ButtonStyle(
                minimumSize:
                    MaterialStateProperty.all<Size>(const Size(400, 42)),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ImageWidgetRow extends StatelessWidget {
  const _ImageWidgetRow({required this.image1, required this.image2});

  final Widget image1;
  final Widget image2;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 7,
            child: ImageHolder(child: image1),
          ),
          const Spacer(flex: 1),
          Expanded(
            flex: 7,
            child: ImageHolder(child: image2),
          ),
        ],
      ),
    );
  }
}

class NoImagePlaceholder extends StatelessWidget {
  const NoImagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        Icons.image,
        color: Colors.grey,
        semanticLabel: 'Asset Image',
        size: 30.0,
      ),
    );
  }
}

class ImageHolder extends StatelessWidget {
  const ImageHolder({super.key, required this.child});
  final Widget child;

  final _borderRadius = const BorderRadius.all(Radius.circular(4.0));

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: _borderRadius,
      ),
      child: Container(
        decoration: BoxDecoration(borderRadius: _borderRadius),
        child: Center(child: child),
      ),
    );
  }
}

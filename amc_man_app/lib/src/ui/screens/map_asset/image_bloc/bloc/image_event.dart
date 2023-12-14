part of 'image_bloc.dart';

abstract class ImageEvent extends Equatable {
  const ImageEvent();

  @override
  List<Object> get props => [];
}

class CaptureImage extends ImageEvent {
  const CaptureImage({required this.imageHandler, required this.imageFiles});

  final List<File> imageFiles;
  final ImageHandler imageHandler;

  @override
  List<Object> get props => [imageHandler, imageFiles];
}

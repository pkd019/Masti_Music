part of 'image_bloc.dart';

class ImageState extends Equatable {
  const ImageState.inProgress() : this._(imageFiles: null, errorMessage: null);
  const ImageState.imageCaptured(List<File> newImages)
      : this._(imageFiles: newImages, errorMessage: null);
  const ImageState.failure(String message)
      : this._(imageFiles: null, errorMessage: message);

  final List<File>? imageFiles;
  final String? errorMessage;

  const ImageState._({required this.imageFiles, required this.errorMessage});

  @override
  List<Object?> get props => [imageFiles, errorMessage];
}

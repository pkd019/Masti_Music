// ignore_for_file: override_on_non_overriding_member

import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import '../../../../../global/image_handler.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(const ImageState._(imageFiles: [], errorMessage: ''));

  @override
  Stream<ImageState> mapEventToState(
    ImageEvent event,
  ) async* {
    try {
      if (event is CaptureImage) {
        yield const ImageState.inProgress();
        final image = await event.imageHandler.pickFile();
        List<File> images = event.imageFiles;
        images.add(image);
        yield ImageState.imageCaptured(images);
      }
    } on NoSuchMethodError catch (e) {
      yield ImageState.failure(e.toString());
    } on TimeoutException catch (e) {
      yield ImageState.failure(e.message.toString());
    } on FormatException catch (e) {
      yield ImageState.failure(e.message);
    } on PlatformException catch (e) {
      yield ImageState.failure(e.message ?? 'Error: Platform Exception');
    } on Exception catch (e) {
      yield ImageState.failure(e.toString());
    }
  }
}

// ignore_for_file: override_on_non_overriding_member

import 'dart:async';
import 'dart:io';

import 'package:amc_man_app/src/sdk/asset_functions.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../models/asset_model/asset_model.dart';
import '../../../../global/globals.dart' as global;

part 'assetmap_event.dart';
part 'assetmap_state.dart';

class AssetMapBloc extends Bloc<AssetmapEvent, AssetmapState> {
  AssetMapBloc() : super(AssetmapInitial());

  @override
  Stream<AssetmapState> mapEventToState(
    AssetmapEvent event,
  ) async* {
    try {
      if (event is UploadAsset) {
        final assetFunc = AssetFunction(event.context);
        List<String> imageUrls = [];

        ScaffoldMessenger.of(global.navigatorKey.currentContext!).showSnackBar(
          const SnackBar(
            content: Text('Uploading images...'),
            duration: Duration(seconds: 10),
          ),
        );

        for (var imgPath in event.assetLocalFilePath) {
          final file = File(imgPath);
          final url = await assetFunc.uploadImage(file);
          imageUrls.add(url);
        }

        ScaffoldMessenger.of(global.navigatorKey.currentContext!)
            .hideCurrentSnackBar();

        final asset = Asset(
          assetClass: event.assetClass,
          assetSubClass: event.assetSubClass,
          assetSubClassOption: event.assetSubClassOption,
          assetImagesUrl: imageUrls,
          assetLocation: event.location,
          name: event.name,
          description: event.description,
          functioning: event.functioning,
          physicalCondition: event.physicalCondition,
          assetPartFuncReason: event.assetPartFuncReason,
          uploadedBy: global.user!.id,
          assetLocalFilePath: [],
        );

        yield AssetmapInProgress();
        await assetFunc.uploadAsset(asset);

        yield AssetmapSuccess();
      }
    } on NoSuchMethodError catch (e) {
      yield AssetmapFailure(message: 'Error: $e');
    } on TimeoutException catch (e) {
      yield AssetmapFailure(message: 'Timeout Error: ${e.message}');
    } on FormatException catch (e) {
      yield AssetmapFailure(message: 'Format Error: ${e.message}');
    } on PlatformException catch (e) {
      yield AssetmapFailure(
          message: 'Platform Error: ${e.message ?? "Unknown Error"}');
    } on Exception catch (e) {
      yield AssetmapFailure(message: 'Unexpected Error: $e');
    }
  }
}

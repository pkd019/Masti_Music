import 'dart:io';

import 'package:amc_man_app/src/constants.dart';
import 'package:amc_man_app/src/logger.dart';
import 'package:amc_man_app/src/models/asset_model/asset_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../extensions/snack_bar.dart';

class AssetFunction {
  AssetFunction(
    this._context,
  );

  final BuildContext _context;
  final _assetsRef = FirebaseFirestore.instance.collection(kAssetsCollection);

  Future<void> uploadAsset(Asset asset) async {
    try {
      await _assetsRef.add(asset.toJson());
    } on FirebaseException catch (e) {
      _context.showSnackbar(e.message ?? 'Error uploading asset');
      return Future.error(e.message ?? 'Error uploading asset');
    }
  }

  Future<String> uploadImage(File imageFile) async {
    try {
      final fileName = basename(imageFile.path);
      final storageRef =
          FirebaseStorage.instance.ref().child('assets/$fileName');

      final uploadTask = storageRef.putFile(imageFile);

      await showDialog(
        context: _context,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: StreamBuilder<TaskSnapshot>(
              stream: uploadTask.snapshotEvents,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  logger.e(snapshot);
                  logger.e(snapshot.error);
                  return Container();
                } else if (snapshot.hasData) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                      final progress = snapshot.data!.bytesTransferred /
                          snapshot.data!.totalBytes;
                      logger.i('Progress: $progress');

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 10.0,
                          backgroundColor: Colors.grey,
                          semanticsLabel: 'Uploading images',
                          semanticsValue:
                              '${(progress * 100).toStringAsFixed(2)} %',
                        ),
                      );
                    case ConnectionState.done:
                      logger.d('Image Uploaded');
                      return Container();
                    case ConnectionState.none:
                    default:
                      return Container();
                  }
                } else {
                  return Container();
                }
              },
            ),
          );
        },
      );

      await uploadTask;
      final imageUrl = await storageRef.getDownloadURL();
      return imageUrl;
    } on FirebaseException catch (e) {
      _context.showSnackbar(e.message ?? 'Error uploading image');
      return Future.error(e.message ?? 'Error uploading asset');
    }
  }

  Future<List<Asset>> getUserAssets(String userId) async {
    final queryDoc =
        await _assetsRef.where('uploadedBy', isEqualTo: userId).get().onError(
              (error, stackTrace) =>
                  Future.error(error ?? 'Error uploading asset'),
            );

    final docs = queryDoc.docs;
    try {
      final userAssets = docs.map((e) => Asset.fromJson(e.data())).toList();
      return userAssets;
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  Future<List<Asset>> getAllAssets() async {
    final queryDoc = await _assetsRef.get().onError(
          (error, stackTrace) => Future.error(error!),
        );
    final docs = queryDoc.docs;
    try {
      final assets = docs.map((e) => Asset.fromJson(e.data())).toList();
      return assets;
    } on Exception catch (e) {
      return Future.error(e);
    }
  }
}

// ignore_for_file: public_member_api_docs, use_build_context_synchronously

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whisper_flutter/widget/widget.dart';
import "package:whisper_gpl/whisper_gpl.dart";
import "package:path/path.dart" as path;
import "package:permission_handler/permission_handler.dart" as permission_handler;

class WhisperFlutter extends ChangeNotifier {
  final WhisperGpl whisperGpl = WhisperGpl();
  bool isModelLoaded = false;
  String modelPath = "";
  String transcribeResult = "";
  Directory directoryCache = Directory.systemTemp;
  static final WhisperFlutter whisperFlutter = WhisperFlutter();

  void ensureInitialized() {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      whisperGpl.ensureInitialized();
    } catch (e) {}
    return;
  }

  Future<void> initialized() async {
    await whisperGpl.initialized();
    await requestPermissions();
    // directoryCache = await path_provider.getApplicationCacheDirectory();
    return;
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  Future<void> requestPermissions() async {
    try {
      for (final permission in {
        // Permission.notification,
        // Permission.ignoreBatteryOptimizations,
        // Permission.mediaLibrary,
        // Permission.accessMediaLocation,
        // Permission.audio,
        // Permission.camera,
        // Permission.requestInstallPackages,
        permission_handler.Permission.manageExternalStorage,
        // Permission.storage,
      }) {
        int totalCountTry = 0;
        try {
          while (true) {
            if (totalCountTry >= 100) {
              break;
            }

            if ((await permission.isGranted)) {
              break;
            } else {
              final result = await permission.request();
              totalCountTry++;
              if (result.isPermanentlyDenied) {
                await permission_handler.openAppSettings();
              }

              if (result.isGranted || result.isLimited) {
                break;
              }
            }
          }
        } catch (e) {}
      }
    } catch (e) {}
    return;
  }

  Future<void> loadModel({
    required BuildContext context,
  }) async {
    final directoryPath = (await FilePicker.platform.getDirectoryPath()) ?? "";
    if (directoryPath.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("directory Empty"),
        ),
      );
      return;
    }
    final Directory directory = Directory(directoryPath);
    final files = directory.listSync().where((e) => e is File && path.extension(e.path) == ".bin");

    AzkadevDialogFlutter.showDialogWidget(
      context: context,
      builder: (context) {
        final ThemeData themeData = Theme.of(context);
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(),
            child: Column(
              children: [
                AzkadevDialogFlutter.titleSimpleWidget(
                  context: context,
                  title: "Models",
                ),
                for (final element in files) ...[
                  () {
                    final fileName = path.basename(element.path);
                    return SimpleContainerWidget(
                      margin: EdgeInsets.all(5),
                      child: ListTile(
                        title: Text(
                          fileName.trim(),
                          style: themeData.textTheme.titleSmall,
                        ),
                        onTap: () async {
                          AzkadevDialogFlutter.showDialogWidget(
                            context: context,
                            builder: (context) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );
                          final isLoaded = await whisperGpl.loadModelFromFilePath(
                            filePath: element.path,
                          );
                          // final bool isLoaded = load["@type"] == "ok";
                          Navigator.pop(context);
                          Navigator.pop(context);
                          isModelLoaded = isLoaded;
                          if (isModelLoaded) {
                            modelPath = element.path;
                          } else {
                            modelPath = "";
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Failed Load Model"),
                              ),
                            );
                          }
                          notifyListeners();
                        },
                      ),
                    );
                  }(),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> transcribe({
    required String filePath,
    required BuildContext context,
  }) async {
    if (!isModelLoaded) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Load Model First"),
        ),
      );
      return;
    }
    if (filePath.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("FilePath Empty"),
        ),
      );
      return;
    }
    if (modelPath.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Model Empty"),
        ),
      );
      return;
    }

    if (RegExp("^(assets)", caseSensitive: false).hasMatch(filePath)) {
      final data = await rootBundle.load(filePath);
      final fileName = path.basename(filePath);
      final File fileNew = File(path.join(directoryCache.path, fileName));
      await fileNew.writeAsBytes(data.buffer.asUint8List());
      filePath = fileNew.path;
    }

    AzkadevDialogFlutter.showDialogWidget(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    final result = await whisperGpl.transcribeFromFilePath(
      filePath: filePath,
      total_count_thread: 1,
      is_translate: false,
      language: "",
    );
    Navigator.pop(context);
    if (result.isSucces) {
      transcribeResult = result.result;
    } else {
      transcribeResult = result.error;
    }
    notifyListeners();
  }
}

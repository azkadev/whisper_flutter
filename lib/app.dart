// ignore_for_file: public_member_api_docs, use_build_context_synchronously

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:whisper_flutter/asset/generate/whisper_flutter/whisper_flutter_assets_external_samples.dart';
import 'package:whisper_flutter/client/client.dart';
import 'package:whisper_flutter/widget/widget.dart';
import "package:path/path.dart" as path;

void app() {
  WhisperFlutter.whisperFlutter.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final whisperFlutter = WhisperFlutter.whisperFlutter;
      try {
        await whisperFlutter.initialized();
        whisperFlutter.whisperGpl.ensureInitialized();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${e.toString()}"),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: WhisperFlutter.whisperFlutter,
      builder: (context, child) {
        final MediaQueryData mediaQueryData = MediaQuery.of(context);
        final whisperFlutter = WhisperFlutter.whisperFlutter;
        // This method is rerun every time setState is called, for instance as done
        // by the _incrementCounter method above.
        //
        // The Flutter framework has been optimized to make rerunning build methods
        // fast, so that you can just rebuild anything that needs updating rather
        // than having to individually change instances of widgets.
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text("Whisper Flutter By Azkadev"),
          ),
          body: RefreshIndicator(
            onRefresh: () async {},
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(),
                child: Column(
                  children: [
                    SimpleButtonWidget(
                      title: "Load Model",
                      onPressed: () {
                        WhisperFlutter.whisperFlutter.loadModel(context: context);
                      },
                    ),
                    Divider(),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsetsGeometry.all(10),
                        child: Text("Model"),
                      ),
                    ),
                    SimpleContainerWidget(
                      width: mediaQueryData.size.width,
                      margin: EdgeInsets.all(10),
                      child: Padding(
                        padding: EdgeInsetsGeometry.all(10),
                        child: Text(
                          "${path.basename(whisperFlutter.modelPath)}",
                        ),
                      ),
                    ),
                    Divider(),
                    if (whisperFlutter.isModelLoaded) ...[
                      SimpleButtonWidget(
                        title: "Transcribe JFK.mp3",
                        onPressed: () {
                          final filePath = WhisperFlutterAssetsExternalSamples.samplesJfkMp3.assetPath;
                          whisperFlutter.transcribe(filePath: filePath, context: context);
                        },
                      ),
                      SimpleButtonWidget(
                        title: "Transcribe JFK.wav",
                        onPressed: () {
                          final filePath = WhisperFlutterAssetsExternalSamples.samplesJfkWav.assetPath;
                          whisperFlutter.transcribe(filePath: filePath, context: context);
                        },
                      ),
                      SimpleButtonWidget(
                        title: "Transcribe Any Audio",
                        onPressed: () async {
                          final r = await FilePicker.platform.pickFiles(
                            type: FileType.audio,
                          );
                          if (r == null) {
                            return;
                          }
                          final filePath = r.files.first.path ?? "";
                          await whisperFlutter.transcribe(
                            filePath: filePath,
                            context: context,
                          );
                        },
                      ),
                      Divider(),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsetsGeometry.all(10),
                          child: Text("Transcribe Result"),
                        ),
                      ),
                      SimpleContainerWidget(
                        width: mediaQueryData.size.width,
                        margin: EdgeInsets.all(10),
                        child: Padding(
                          padding: EdgeInsetsGeometry.all(10),
                          child: Text(
                            "${whisperFlutter.transcribeResult}",
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

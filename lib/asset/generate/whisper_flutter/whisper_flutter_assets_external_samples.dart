/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
enum WhisperFlutterAssetsExternalSamples {

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
unknown(
  assetPath: "",
),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
samplesJfkMp3(
  assetPath: "assets/external/samples/jfk_mp3.mp3",
),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
samplesJfkWav(
  assetPath: "assets/external/samples/jfk_wav.wav",
),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
samplesLICENSE(
  assetPath: "assets/external/samples/LICENSE",
),
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
samplesREADME(
  assetPath: "assets/external/samples/README.md",
);
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final String assetPath;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const WhisperFlutterAssetsExternalSamples({
    required this.assetPath,
  });


  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  static List<WhisperFlutterAssetsExternalSamples> realValues = WhisperFlutterAssetsExternalSamples.values.toList()..remove(WhisperFlutterAssetsExternalSamples.unknown);


  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  static WhisperFlutterAssetsExternalSamples getFromValueIndex({
    required final int index,
    required final List<WhisperFlutterAssetsExternalSamples> values,
    required WhisperFlutterAssetsExternalSamples defaultWhisperFlutterAssetsExternalSamples,
  }) {
    try {
      return values[index];
    } catch (e) {
      return defaultWhisperFlutterAssetsExternalSamples;
    }
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  static WhisperFlutterAssetsExternalSamples getFromIndex({
    required int index,
    WhisperFlutterAssetsExternalSamples defaultWhisperFlutterAssetsExternalSamples = WhisperFlutterAssetsExternalSamples.unknown,
  }) {
    return WhisperFlutterAssetsExternalSamples.getFromValueIndex(
      index: index,
      values: WhisperFlutterAssetsExternalSamples.realValues,
      defaultWhisperFlutterAssetsExternalSamples: defaultWhisperFlutterAssetsExternalSamples,
    );
  }

}
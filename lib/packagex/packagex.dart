// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

/// AutoGenerateBy Packagex
class PackagexProjectWhisperFlutter {
/// AutoGenerateBy Packagex
  static bool isSame({
    required String data
  }) {
    return [default_data_to_string, json.encode(default_data)].contains(data);
  }
/// AutoGenerateBy Packagex
    static String get default_data_to_string {
      return (JsonEncoder.withIndent(" " * 2).convert(default_data));
    }
/// AutoGenerateBy Packagex
    static Map get default_data {
return {
  "name": "whisper_flutter",
  "description": "Application example usage whisper for flutter android and linux",
  "publish_to": "none",
  "version": "0.0.0",
  "org": "azkadev.whisper_gpl.whisper_flutter",
  "project": {
    "type": "opensource",
    "is_use_direct_package": true,
    "is_private": true,
    "developers": [
      {
        "username": "azkadev",
        "note": "",
        "social_medias": [
          "https://github.com/azkadev"
        ]
      }
    ]
  },
  "funding": []
};
    }

}
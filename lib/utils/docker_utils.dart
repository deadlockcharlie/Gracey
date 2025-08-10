// import 'package:process_run/process_run.dart';
import 'dart:io';

class DockerUtils {
  static Future<bool> isDockerRunning() async {
    try {
      final result = await Process.run('docker',['ps'], runInShell: true);
      return result.exitCode == 0;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

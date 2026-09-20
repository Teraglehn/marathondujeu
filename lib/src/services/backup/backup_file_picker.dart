import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

/// Les deux dialogues du système pour le fichier de sauvegarde (L09) : où l'écrire, lequel
/// ouvrir. Derrière une classe pour que le parcours e2e les remplace par des chemins connus.
class BackupFilePicker {
  const BackupFilePicker();

  static const _extension = 'json';

  /// Demande où écrire, écrit [bytes] (la première sauvegarde) et rend le chemin ; null si
  /// l'utilisateur renonce.
  Future<String?> chooseSavePath(String suggestedName, Uint8List bytes) async {
    final uri = await FilePicker.saveFile(
      fileName: suggestedName,
      bytes: bytes,
      mimeType: 'application/json',
      type: FileType.custom,
      allowedExtensions: const [_extension],
      windowsOptions: const WindowsOptions(lockParentWindow: true),
    );
    return uri?.toFilePath(windows: true);
  }

  /// Le chemin du fichier à ouvrir, ou null.
  Future<String?> chooseOpenPath() async {
    final file = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: const [_extension],
      windowsOptions: const WindowsOptions(lockParentWindow: true),
    );
    return file?.path;
  }
}

import "dart:developer" as devtools show log;
import "dart:io";
import "dart:math";

extension Log on Object {
  void log([String prefix = "Logger"]) => devtools.log(
        "[$prefix] ${toString()}",
        name: "Tool",
        level: 1200,
      );
}

Future<void> main() => AssetGenerator.generate(folder: "icons");

class AssetGenerator {
  AssetGenerator._();

  static Future<void> generate({required String folder}) async {
    try {
      final Directory directory = Directory("./assets/$folder");

      if (directory.listSync().isEmpty) {
        "Folder is not exist...".log("INFO");
        return;
      }

      final StringBuffer appClass = StringBuffer();
      String name = folder;

      if (folder.contains("/")) {
        name = folder.substring(folder.lastIndexOf("/"));
      }
      name = folder[0].toUpperCase() + folder.substring(1);

      //Writing...
      appClass
        ..writeln("final class App$name {")
        ..writeln("  const App$name._();\n");

      directory.listSync().forEach((FileSystemEntity element) {
        if (element is File) {
          final String findLastSlash = Platform.operatingSystem == "windows" ? r"\" : "/";

          final String fileName = element.path.substring(element.path.lastIndexOf(findLastSlash) + 1);
          String cutName = fileName.substring(0, fileName.lastIndexOf("."));
          cutName = _renamer(appClass.toString(), cutName);

          appClass.writeln(
            "  static const ${cutName.toLowerCase()} = 'assets/${folder.toLowerCase()}/$fileName';",
          );
        }
      });

      appClass.writeln("}");

      await _fileCreate(name, appClass.toString());
    } on PathNotFoundException catch (_, __) {
      "Not Found Folder Please Checking Directory".log("ERROR");
    }
  }

  static String _renamer(String appClass, String name) {
    String cutName = name;
    // Start At . Remove .
    if (cutName[0] == ".") {
      cutName = cutName.substring(1);
    }

    // End Contains . Remove . at
    while (cutName.contains(".")) {
      if (cutName.contains(".")) {
        cutName = cutName.substring(0, cutName.lastIndexOf(".") - 1);
      }
    }

    // End Contains - Remove - at
    while (cutName.contains("-")) {
      String rename = cutName.substring(0, cutName.lastIndexOf("-") - 1);
      if (cutName.length > cutName.lastIndexOf("-") + 1) {
        rename += cutName.substring(cutName.lastIndexOf("-") + 1);
      }
      cutName = rename;
    }

    if (RegExp("($cutName)").hasMatch(appClass)) {
      cutName += Random().nextInt(10).toString();
    }

    return cutName;
  }

  static Future<void> _fileCreate(String name, String appClass) async {
    final File file = File(
      "./lib/src/common/styles/app${name.isEmpty ? "" : "_${name.toLowerCase()}"}.dart",
    );
    await file.create(recursive: true);
    await file.writeAsString(appClass);

    "Successfully Created File ...".log("INFO");
  }
}

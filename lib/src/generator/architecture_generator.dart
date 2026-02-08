import 'dart:io';
import '../models/folder_structure.dart';
import '../models/module_config.dart';
import '../models/state_management.dart';
import '../templates/file_templates.dart';
import '../templates/state_management_templates.dart';
import '../templates/test_templates.dart';

/// Generates the Screaming Architecture folder structure
class ArchitectureGenerator {
  final FolderStructure structure;

  const ArchitectureGenerator(this.structure);

  /// Generates the complete folder structure
  Future<void> generate() async {
    print('🏗️  Generating Screaming Architecture structure...\n');

    // Create modules
    for (final moduleName in structure.modules) {
      await _generateModule(ModuleConfig.fullModule(moduleName));
    }

    // Create shared folder
    if (structure.includeShared) {
      await _generateSharedFolder();
    }

    // Create core folder
    await _generateCoreFolder();

    // Create main app structure
    await _generateAppStructure();

    print('\n✅ Structure generated successfully!');
    print('📁 Base path: ${structure.basePath}');
    print('📦 Modules created: ${structure.modules.join(", ")}');
  }

  /// Generates a single module with all its layers
  Future<void> _generateModule(ModuleConfig config) async {
    print('📦 Creating module: ${config.name}');

    final modulePath = '${structure.basePath}/modules/${config.name}';

    for (final subfolder in config.subfolders) {
      final path = '$modulePath/$subfolder';
      await _createDirectory(path);

      // Create example files if enabled
      if (structure.includeExamples) {
        await _createExampleFile(path, config.name, subfolder);
      }
    }

    // Generate state management files
    await _generateStateManagement(modulePath, config.name);

    // Generate tests
    await _generateTests(config.name);

    // Create module barrel file
    await _createBarrelFile(modulePath, config);
  }

  /// Generates the shared folder for cross-cutting concerns
  Future<void> _generateSharedFolder() async {
    print('🔗 Creating shared folder');

    final sharedFolders = [
      'shared/widgets',
      'shared/utils',
      'shared/extensions',
      'shared/constants',
      'shared/theme',
    ];

    for (final folder in sharedFolders) {
      final path = '${structure.basePath}/$folder';
      await _createDirectory(path);

      if (structure.includeExamples) {
        await _createSharedExampleFile(path);
      }
    }
  }

  /// Generates the core folder for app-wide configuration
  Future<void> _generateCoreFolder() async {
    print('⚙️  Creating core folder');

    final coreFolders = [
      'core/config',
      'core/di',
      'core/network',
      'core/errors',
      'core/routes',
    ];

    for (final folder in coreFolders) {
      final path = '${structure.basePath}/$folder';
      await _createDirectory(path);

      if (structure.includeExamples) {
        await _createCoreExampleFile(path);
      }
    }
  }

  /// Generates main app structure files
  Future<void> _generateAppStructure() async {
    print('🎯 Creating app structure');

    await _createDirectory('${structure.basePath}/app');

    if (structure.includeExamples) {
      await _createFile(
        '${structure.basePath}/app/app.dart',
        FileTemplates.appFile,
      );
    }
  }

  /// Creates a directory if it doesn't exist
  Future<void> _createDirectory(String path) async {
    final dir = Directory(path);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
  }

  /// Creates a file with content
  Future<void> _createFile(String path, String content) async {
    final file = File(path);
    await file.writeAsString(content);
  }

  /// Creates a barrel file for a module
  Future<void> _createBarrelFile(String modulePath, ModuleConfig config) async {
    final content = FileTemplates.moduleBarrelFile(config.name);
    await _createFile('$modulePath/${config.name}_module.dart', content);
  }

  /// Creates an example file based on the layer
  Future<void> _createExampleFile(
    String path,
    String moduleName,
    String subfolder,
  ) async {
    String? content;
    String? fileName;

    if (subfolder.contains('presentation/pages')) {
      fileName = '${moduleName}_page.dart';
      content = FileTemplates.pageTemplate(moduleName);
    } else if (subfolder.contains('presentation/widgets')) {
      fileName = '${moduleName}_widget.dart';
      content = FileTemplates.widgetTemplate(moduleName);
    } else if (subfolder.contains('domain/entities')) {
      fileName = '${moduleName}_entity.dart';
      content = FileTemplates.entityTemplate(moduleName);
    } else if (subfolder.contains('domain/repositories')) {
      fileName = '${moduleName}_repository.dart';
      content = FileTemplates.repositoryTemplate(moduleName);
    } else if (subfolder.contains('domain/usecases')) {
      fileName = 'get_$moduleName.dart';
      content = FileTemplates.usecaseTemplate(moduleName);
    } else if (subfolder.contains('data/models')) {
      fileName = '${moduleName}_model.dart';
      content = FileTemplates.modelTemplate(moduleName);
    } else if (subfolder.contains('data/datasources')) {
      fileName = '${moduleName}_remote_datasource.dart';
      content = FileTemplates.datasourceTemplate(moduleName);
    } else if (subfolder.contains('data/repositories')) {
      fileName = '${moduleName}_repository_impl.dart';
      content = FileTemplates.repositoryImplTemplate(moduleName);
    } else if (subfolder.contains('routes')) {
      fileName = '${moduleName}_routes.dart';
      content = FileTemplates.routesTemplate(moduleName);
    }

    if (content != null && fileName != null) {
      await _createFile('$path/$fileName', content);
    } else {
      // Create a .gitkeep file to preserve empty directories
      await _createFile('$path/.gitkeep', '');
    }
  }

  /// Creates example files in shared folder
  Future<void> _createSharedExampleFile(String path) async {
    if (path.contains('widgets')) {
      await _createFile(
        '$path/custom_button.dart',
        FileTemplates.sharedWidgetTemplate,
      );
    } else if (path.contains('utils')) {
      await _createFile(
        '$path/validators.dart',
        FileTemplates.validatorsTemplate,
      );
    } else if (path.contains('extensions')) {
      await _createFile(
        '$path/string_extensions.dart',
        FileTemplates.extensionsTemplate,
      );
    } else if (path.contains('constants')) {
      await _createFile(
        '$path/app_constants.dart',
        FileTemplates.constantsTemplate,
      );
    } else if (path.contains('theme')) {
      await _createFile('$path/app_theme.dart', FileTemplates.themeTemplate);
    }
  }

  /// Creates example files in core folder
  Future<void> _createCoreExampleFile(String path) async {
    if (path.contains('config')) {
      await _createFile('$path/app_config.dart', FileTemplates.configTemplate);
    } else if (path.contains('di')) {
      await _createFile(
        '$path/injection_container.dart',
        FileTemplates.diTemplate,
      );
    } else if (path.contains('network')) {
      await _createFile('$path/api_client.dart', FileTemplates.networkTemplate);
    } else if (path.contains('errors')) {
      await _createFile('$path/failures.dart', FileTemplates.failuresTemplate);
    } else if (path.contains('routes')) {
      await _createFile(
        '$path/app_routes.dart',
        FileTemplates.appRoutesTemplate,
      );
    }
  }

  /// Generate state management files for a module
  Future<void> _generateStateManagement(
    String modulePath,
    String moduleName,
  ) async {
    if (structure.stateManagement == StateManagement.none) return;

    final folderName = StateManagementTemplates.getFolderName(
      structure.stateManagement,
    );
    final suffix = StateManagementTemplates.getFileSuffix(
      structure.stateManagement,
    );
    final path = '$modulePath/presentation/$folderName';

    await _createDirectory(path);

    final template = StateManagementTemplates.getTemplate(
      structure.stateManagement,
      moduleName,
    );
    if (template != null) {
      await _createFile('$path/${moduleName}_$suffix.dart', template);
    }
  }

  /// Generate test files for a module
  Future<void> _generateTests(String moduleName) async {
    if (!structure.generateTests) return;

    print('  🧪 Generating tests for $moduleName');

    // Get project name from pubspec.yaml
    final projectName = await _getProjectName();

    final testPath = 'test/modules/$moduleName';
    final tests = TestTemplates.getAllTests(moduleName, projectName);

    for (final entry in tests.entries) {
      final filePath = '$testPath/${entry.key}';
      await _createDirectory(filePath.substring(0, filePath.lastIndexOf('/')));
      await _createFile(filePath, entry.value);
    }
  }

  /// Gets the project name from pubspec.yaml
  Future<String> _getProjectName() async {
    try {
      final pubspecFile = File('pubspec.yaml');
      if (await pubspecFile.exists()) {
        final content = await pubspecFile.readAsString();
        final nameMatch = RegExp(
          r'^name:\s*(.+)$',
          multiLine: true,
        ).firstMatch(content);
        if (nameMatch != null) {
          return nameMatch.group(1)!.trim();
        }
      }
    } catch (e) {
      print('⚠️  Warning: Could not read project name from pubspec.yaml');
    }
    // Fallback to a generic name
    return 'app';
  }
}

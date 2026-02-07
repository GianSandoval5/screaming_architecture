import 'state_management.dart';

/// Represents the folder structure for the Screaming Architecture pattern
class FolderStructure {
  /// Base path where the structure will be created
  final String basePath;

  /// Modules to generate (features/domains)
  final List<String> modules;

  /// Whether to include shared folder
  final bool includeShared;

  /// Whether to include example files
  final bool includeExamples;

  /// Whether to generate test structure
  final bool generateTests;

  /// State management solution to use
  final StateManagement stateManagement;

  const FolderStructure({
    required this.basePath,
    required this.modules,
    this.includeShared = true,
    this.includeExamples = true,
    this.generateTests = false,
    this.stateManagement = StateManagement.none,
  });

  /// Default modules for a typical Flutter app
  static const List<String> defaultModules = ['auth', 'home', 'profile'];

  /// Returns the default folder structure
  static FolderStructure get defaultStructure => const FolderStructure(
    basePath: 'lib',
    modules: defaultModules,
    includeShared: true,
    includeExamples: true,
    generateTests: false,
    stateManagement: StateManagement.none,
  );
}

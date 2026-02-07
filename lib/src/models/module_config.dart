/// Configuration for a single module in the architecture
class ModuleConfig {
  /// Name of the module (e.g., 'auth', 'products')
  final String name;

  /// Whether to include data layer
  final bool includeData;

  /// Whether to include domain layer
  final bool includeDomain;

  /// Whether to include presentation layer
  final bool includePresentation;

  /// Whether to include routing
  final bool includeRoutes;

  const ModuleConfig({
    required this.name,
    this.includeData = true,
    this.includeDomain = true,
    this.includePresentation = true,
    this.includeRoutes = true,
  });

  /// Creates a module with all layers
  factory ModuleConfig.fullModule(String name) => ModuleConfig(
    name: name,
    includeData: true,
    includeDomain: true,
    includePresentation: true,
    includeRoutes: true,
  );

  /// Module subfolders based on configuration
  List<String> get subfolders {
    final folders = <String>[];

    if (includePresentation) {
      folders.addAll(['presentation/pages', 'presentation/widgets']);
    }

    if (includeDomain) {
      folders.addAll([
        'domain/entities',
        'domain/repositories',
        'domain/usecases',
      ]);
    }

    if (includeData) {
      folders.addAll(['data/datasources', 'data/models', 'data/repositories']);
    }

    if (includeRoutes) {
      folders.add('routes');
    }

    return folders;
  }
}

import 'package:screaming_architecture/screaming_architecture.dart';

/// Example of how to use the Screaming Architecture generator
void main() async {
  // Create a custom structure
  final structure = FolderStructure(
    basePath: 'lib',
    modules: ['auth', 'products', 'orders', 'profile'],
    includeShared: true,
    includeExamples: true,
  );

  // Generate the structure
  final generator = ArchitectureGenerator(structure);
  await generator.generate();

  print('✅ Structure generated successfully!');
}

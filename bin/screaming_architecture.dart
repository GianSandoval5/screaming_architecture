#!/usr/bin/env dart

import 'dart:io';
import 'package:screaming_architecture/screaming_architecture.dart';

void main(List<String> arguments) async {
  print('🎯 Screaming Architecture Generator v1.0.0\n');

  // Check for interactive mode
  final isInteractive =
      arguments.contains('--interactive') || arguments.contains('-i');

  FolderStructure structure;

  if (isInteractive) {
    structure = await _interactiveMode();
  } else {
    structure = _parseArguments(arguments);
  }

  // Show configuration
  print('\n📋 Configuration:');
  print('  📁 Base path: ${structure.basePath}');
  print('  📦 Modules: ${structure.modules.join(", ")}');
  print('  📝 Include examples: ${structure.includeExamples}');
  print('  🧪 Generate tests: ${structure.generateTests}');
  print('  🎛️  State management: ${structure.stateManagement.description}\n');

  final shouldContinue = _promptUser('Continue? (y/n): ');

  if (!shouldContinue) {
    print('❌ Generation cancelled');
    exit(0);
  }

  // Create structure
  final generator = ArchitectureGenerator(structure);

  try {
    await generator.generate();

    // Show recommendations
    if (structure.stateManagement != StateManagement.none) {
      print('\n📦 Don\'t forget to add to pubspec.yaml:');
      print('   ${structure.stateManagement.packageName}');
    }

    if (structure.generateTests) {
      print('\n🧪 Tests generated! Run: flutter test');
    }

    print('\n🎉 Done! Your Screaming Architecture is ready.');
    print('📖 Check the generated files to start developing.');
  } catch (e) {
    print('❌ Error: $e');
    exit(1);
  }
}

Future<FolderStructure> _interactiveMode() async {
  print('🎨 Interactive Mode\n');

  // Select preset
  print('Select a preset:');
  print(
    '  1. ${ProjectPreset.ecommerce.emoji} E-commerce (${ProjectPreset.ecommerce.modules.length} modules)',
  );
  print(
    '  2. ${ProjectPreset.social.emoji} Social Media (${ProjectPreset.social.modules.length} modules)',
  );
  print(
    '  3. ${ProjectPreset.enterprise.emoji} Enterprise (${ProjectPreset.enterprise.modules.length} modules)',
  );
  print(
    '  4. ${ProjectPreset.minimal.emoji} Minimal (${ProjectPreset.minimal.modules.length} modules)',
  );
  print('  5. ${ProjectPreset.custom.emoji} Custom');

  final presetChoice = _promptNumber('Enter choice (1-5): ', 1, 5);
  final preset = ProjectPreset.values[presetChoice - 1];

  List<String> modules;
  if (preset == ProjectPreset.custom) {
    print('\nEnter module names (comma-separated):');
    final input = stdin.readLineSync() ?? '';
    modules = input
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    if (modules.isEmpty) {
      modules = FolderStructure.defaultModules;
      print('Using default modules: ${modules.join(", ")}');
    }
  } else {
    modules = preset.modules;
    print('\n✅ Selected: ${preset.description}');
    print('Modules: ${modules.join(", ")}');
  }

  // State management
  print('\nSelect state management:');
  print('  1. None (StatefulWidget only)');
  print('  2. BLoC/Cubit');
  print('  3. Riverpod');
  print('  4. Provider');
  print('  5. GetX');

  final stateChoice = _promptNumber('Enter choice (1-5): ', 1, 5);
  final stateManagement = StateManagement.values[stateChoice - 1];

  // Options
  final includeExamples = _promptBool('\nInclude example files? (y/n): ');
  final generateTests = _promptBool('Generate test structure? (y/n): ');

  return FolderStructure(
    basePath: 'lib',
    modules: modules,
    includeExamples: includeExamples,
    generateTests: generateTests,
    stateManagement: stateManagement,
  );
}

FolderStructure _parseArguments(List<String> arguments) {
  // Show help
  if (arguments.contains('--help') || arguments.contains('-h')) {
    _printHelp();
    exit(0);
  }

  // Parse arguments
  final basePath = _getArgument(arguments, '--path', 'lib');
  final modules = _getModules(arguments);
  final includeExamples = !arguments.contains('--no-examples');
  final generateTests = arguments.contains('--tests');
  final stateManagement = _getStateManagement(arguments);
  final preset = _getPreset(arguments);

  // Use preset if specified
  final finalModules = preset != null ? preset.modules : modules;

  return FolderStructure(
    basePath: basePath,
    modules: finalModules,
    includeExamples: includeExamples,
    generateTests: generateTests,
    stateManagement: stateManagement,
  );
}

void _printHelp() {
  print('''
Usage: dart run screaming_architecture:screaming_architecture [options]

Options:
  -h, --help              Show this help message
  -i, --interactive       Run in interactive mode
  --path <path>           Base path for generation (default: lib)
  --modules <list>        Comma-separated module names
  --preset <name>         Use a preset: ecommerce, social, enterprise, minimal
  --state <name>          State management: bloc, riverpod, provider, getx
  --tests                 Generate test structure
  --no-examples           Don't generate example files

Examples:
  # Interactive mode
  dart run screaming_architecture:screaming_architecture -i

  # E-commerce preset with BLoC
  dart run screaming_architecture:screaming_architecture --preset ecommerce --state bloc --tests

  # Custom modules with Riverpod
  dart run screaming_architecture:screaming_architecture --modules auth,products,cart --state riverpod

  # Minimal with tests
  dart run screaming_architecture:screaming_architecture --preset minimal --tests
''');
}

String _getArgument(List<String> arguments, String flag, String defaultValue) {
  final index = arguments.indexOf(flag);
  if (index != -1 && index + 1 < arguments.length) {
    return arguments[index + 1];
  }
  return defaultValue;
}

List<String> _getModules(List<String> arguments) {
  final modulesStr = _getArgument(arguments, '--modules', '');
  if (modulesStr.isEmpty) {
    return FolderStructure.defaultModules;
  }
  return modulesStr
      .split(',')
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toList();
}

ProjectPreset? _getPreset(List<String> arguments) {
  final presetStr = _getArgument(arguments, '--preset', '').toLowerCase();
  switch (presetStr) {
    case 'ecommerce':
    case 'e-commerce':
      return ProjectPreset.ecommerce;
    case 'social':
      return ProjectPreset.social;
    case 'enterprise':
      return ProjectPreset.enterprise;
    case 'minimal':
      return ProjectPreset.minimal;
    default:
      return null;
  }
}

StateManagement _getStateManagement(List<String> arguments) {
  final stateStr = _getArgument(arguments, '--state', '').toLowerCase();
  switch (stateStr) {
    case 'bloc':
      return StateManagement.bloc;
    case 'riverpod':
      return StateManagement.riverpod;
    case 'provider':
      return StateManagement.provider;
    case 'getx':
      return StateManagement.getx;
    default:
      return StateManagement.none;
  }
}

bool _promptUser(String message) {
  stdout.write(message);
  final input = stdin.readLineSync()?.toLowerCase() ?? '';
  return input == 'y' || input == 'yes';
}

bool _promptBool(String message) {
  return _promptUser(message);
}

int _promptNumber(String message, int min, int max) {
  while (true) {
    stdout.write(message);
    final input = stdin.readLineSync();
    final number = int.tryParse(input ?? '');
    if (number != null && number >= min && number <= max) {
      return number;
    }
    print('Please enter a number between $min and $max');
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:screaming_architecture/screaming_architecture.dart';

void main() {
  group('FolderStructure', () {
    test('should create default structure', () {
      final structure = FolderStructure.defaultStructure;

      expect(structure.basePath, 'lib');
      expect(structure.modules, FolderStructure.defaultModules);
      expect(structure.includeShared, true);
      expect(structure.includeExamples, true);
      expect(structure.generateTests, false);
      expect(structure.stateManagement, StateManagement.none);
    });

    test('should create custom structure', () {
      final structure = FolderStructure(
        basePath: 'src',
        modules: const ['auth', 'products'],
        includeShared: false,
        includeExamples: false,
        generateTests: true,
        stateManagement: StateManagement.bloc,
      );

      expect(structure.basePath, 'src');
      expect(structure.modules, ['auth', 'products']);
      expect(structure.includeShared, false);
      expect(structure.includeExamples, false);
      expect(structure.generateTests, true);
      expect(structure.stateManagement, StateManagement.bloc);
    });
  });

  group('ModuleConfig', () {
    test('should create full module', () {
      final config = ModuleConfig.fullModule('auth');

      expect(config.name, 'auth');
      expect(config.includeData, true);
      expect(config.includeDomain, true);
      expect(config.includePresentation, true);
      expect(config.includeRoutes, true);
    });

    test('should generate correct subfolders', () {
      final config = ModuleConfig.fullModule('auth');
      final subfolders = config.subfolders;

      expect(subfolders, contains('presentation/pages'));
      expect(subfolders, contains('presentation/widgets'));
      expect(subfolders, contains('domain/entities'));
      expect(subfolders, contains('domain/repositories'));
      expect(subfolders, contains('domain/usecases'));
      expect(subfolders, contains('data/datasources'));
      expect(subfolders, contains('data/models'));
      expect(subfolders, contains('data/repositories'));
      expect(subfolders, contains('routes'));
    });

    test('should generate presentation-only subfolders', () {
      final config = ModuleConfig(
        name: 'settings',
        includePresentation: true,
        includeDomain: false,
        includeData: false,
        includeRoutes: false,
      );
      final subfolders = config.subfolders;

      expect(subfolders, contains('presentation/pages'));
      expect(subfolders, contains('presentation/widgets'));
      expect(subfolders, hasLength(2));
    });
  });

  group('ProjectPreset', () {
    test('should have correct modules for ecommerce', () {
      final modules = ProjectPreset.ecommerce.modules;

      expect(modules, contains('auth'));
      expect(modules, contains('products'));
      expect(modules, contains('cart'));
      expect(modules, contains('checkout'));
      expect(modules, contains('orders'));
      expect(modules.length, 8);
    });

    test('should have correct modules for social', () {
      final modules = ProjectPreset.social.modules;

      expect(modules, contains('auth'));
      expect(modules, contains('feed'));
      expect(modules, contains('profile'));
      expect(modules, contains('chat'));
      expect(modules.length, 8);
    });

    test('should have description and emoji', () {
      expect(ProjectPreset.ecommerce.description, isNotEmpty);
      expect(ProjectPreset.ecommerce.emoji, isNotEmpty);
    });
  });

  group('StateManagement', () {
    test('should have correct package names', () {
      expect(StateManagement.bloc.packageName, 'flutter_bloc');
      expect(StateManagement.riverpod.packageName, 'flutter_riverpod');
      expect(StateManagement.provider.packageName, 'provider');
      expect(StateManagement.getx.packageName, 'get');
      expect(StateManagement.none.packageName, '');
    });

    test('should check if has state management', () {
      expect(StateManagement.bloc.hasStateManagement, true);
      expect(StateManagement.riverpod.hasStateManagement, true);
      expect(StateManagement.none.hasStateManagement, false);
    });
  });
}

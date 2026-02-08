/// Templates for test files
class TestTemplates {
  TestTemplates._();

  static String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  static String _pascalCase(String text) {
    return text.split('_').map(_capitalize).join();
  }

  // UseCase Test Template
  static String usecaseTestTemplate(String moduleName, String projectName) =>
      '''
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:$projectName/modules/$moduleName/domain/entities/${moduleName}_entity.dart';
import 'package:$projectName/modules/$moduleName/domain/repositories/${moduleName}_repository.dart';
import 'package:$projectName/modules/$moduleName/domain/usecases/get_$moduleName.dart';

class Mock${_pascalCase(moduleName)}Repository extends Mock implements ${_pascalCase(moduleName)}Repository {}

void main() {
  late Get${_pascalCase(moduleName)} usecase;
  late Mock${_pascalCase(moduleName)}Repository mockRepository;

  setUp(() {
    mockRepository = Mock${_pascalCase(moduleName)}Repository();
    usecase = Get${_pascalCase(moduleName)}(mockRepository);
  });

  group('Get${_pascalCase(moduleName)} UseCase', () {
    const testId = '1';
    final test${_pascalCase(moduleName)} = ${_pascalCase(moduleName)}Entity(
      id: testId,
      name: 'Test ${_capitalize(moduleName)}',
    );

    test('should return ${_pascalCase(moduleName)}Entity when repository call is successful', () async {
      // Arrange
      when(() => mockRepository.get${_pascalCase(moduleName)}(any()))
          .thenAnswer((_) async => test${_pascalCase(moduleName)});

      // Act
      final result = await usecase(testId);

      // Assert
      expect(result, equals(test${_pascalCase(moduleName)}));
      verify(() => mockRepository.get${_pascalCase(moduleName)}(testId)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should throw exception when repository call fails', () async {
      // Arrange
      when(() => mockRepository.get${_pascalCase(moduleName)}(any()))
          .thenThrow(Exception('Failed to load $moduleName'));

      // Act & Assert
      expect(
        () => usecase(testId),
        throwsException,
      );
      verify(() => mockRepository.get${_pascalCase(moduleName)}(testId)).called(1);
    });
  });
}
''';

  // Repository Implementation Test Template
  static String repositoryImplTestTemplate(
    String moduleName,
    String projectName,
  ) =>
      '''
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:$projectName/modules/$moduleName/data/datasources/${moduleName}_remote_datasource.dart';
import 'package:$projectName/modules/$moduleName/data/models/${moduleName}_model.dart';
import 'package:$projectName/modules/$moduleName/data/repositories/${moduleName}_repository_impl.dart';

class Mock${_pascalCase(moduleName)}RemoteDataSource extends Mock
    implements ${_pascalCase(moduleName)}RemoteDataSource {}

void main() {
  late ${_pascalCase(moduleName)}RepositoryImpl repository;
  late Mock${_pascalCase(moduleName)}RemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = Mock${_pascalCase(moduleName)}RemoteDataSource();
    repository = ${_pascalCase(moduleName)}RepositoryImpl(mockRemoteDataSource);
  });

  group('${_pascalCase(moduleName)}RepositoryImpl', () {
    const testId = '1';
    const test${_pascalCase(moduleName)}Model = ${_pascalCase(moduleName)}Model(
      id: testId,
      name: 'Test ${_capitalize(moduleName)}',
    );

    test('should return ${_pascalCase(moduleName)}Entity when remote datasource call is successful', () async {
      // Arrange
      when(() => mockRemoteDataSource.get${_pascalCase(moduleName)}(any()))
          .thenAnswer((_) async => test${_pascalCase(moduleName)}Model);

      // Act
      final result = await repository.get${_pascalCase(moduleName)}(testId);

      // Assert
      expect(result, equals(test${_pascalCase(moduleName)}Model));
      verify(() => mockRemoteDataSource.get${_pascalCase(moduleName)}(testId)).called(1);
    });

    test('should throw exception when datasource call fails', () async {
      // Arrange
      when(() => mockRemoteDataSource.get${_pascalCase(moduleName)}(any()))
          .thenThrow(Exception('Network error'));

      // Act & Assert
      expect(
        () => repository.get${_pascalCase(moduleName)}(testId),
        throwsException,
      );
    });

    test('should return list of entities when getAll is successful', () async {
      // Arrange
      final testList = [test${_pascalCase(moduleName)}Model];
      when(() => mockRemoteDataSource.getAll${_pascalCase(moduleName)}s())
          .thenAnswer((_) async => testList);

      // Act
      final result = await repository.getAll${_pascalCase(moduleName)}s();

      // Assert
      expect(result, equals(testList));
      verify(() => mockRemoteDataSource.getAll${_pascalCase(moduleName)}s()).called(1);
    });
  });
}
''';

  // Widget Test Template
  static String widgetTestTemplate(String moduleName, String projectName) =>
      '''
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:$projectName/modules/$moduleName/presentation/pages/${moduleName}_page.dart';

void main() {
  group('${_pascalCase(moduleName)}Page Widget Tests', () {
    testWidgets('should display ${_capitalize(moduleName)} title', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: ${_pascalCase(moduleName)}Page(),
        ),
      );

      // Assert
      expect(find.text('${_capitalize(moduleName)}'), findsOneWidget);
    });

    testWidgets('should have AppBar', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: ${_pascalCase(moduleName)}Page(),
        ),
      );

      // Assert
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('should display ${_capitalize(moduleName)} Page text', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: ${_pascalCase(moduleName)}Page(),
        ),
      );

      // Assert
      expect(find.text('${_capitalize(moduleName)} Page'), findsOneWidget);
    });
  });
}
''';

  // Model Test Template
  static String modelTestTemplate(String moduleName, String projectName) =>
      '''
import 'package:flutter_test/flutter_test.dart';
import 'package:$projectName/modules/$moduleName/data/models/${moduleName}_model.dart';
import 'package:$projectName/modules/$moduleName/domain/entities/${moduleName}_entity.dart';

void main() {
  group('${_pascalCase(moduleName)}Model', () {
    const testId = '1';
    const testName = 'Test ${_capitalize(moduleName)}';

    const test${_pascalCase(moduleName)}Model = ${_pascalCase(moduleName)}Model(
      id: testId,
      name: testName,
    );

    test('should be a subclass of ${_pascalCase(moduleName)}Entity', () {
      // Assert
      expect(test${_pascalCase(moduleName)}Model, isA<${_pascalCase(moduleName)}Entity>());
    });

    group('fromJson', () {
      test('should return a valid model from JSON', () {
        // Arrange
        final Map<String, dynamic> jsonMap = {
          'id': testId,
          'name': testName,
        };

        // Act
        final result = ${_pascalCase(moduleName)}Model.fromJson(jsonMap);

        // Assert
        expect(result, equals(test${_pascalCase(moduleName)}Model));
      });
    });

    group('toJson', () {
      test('should return a JSON map containing proper data', () {
        // Act
        final result = test${_pascalCase(moduleName)}Model.toJson();

        // Assert
        final expectedMap = {
          'id': testId,
          'name': testName,
        };
        expect(result, equals(expectedMap));
      });
    });
  });
}
''';

  /// Get all test templates for a module
  static Map<String, String> getAllTests(
    String moduleName,
    String projectName,
  ) {
    return {
      'domain/usecases/get_${moduleName}_test.dart': usecaseTestTemplate(
        moduleName,
        projectName,
      ),
      'data/repositories/${moduleName}_repository_impl_test.dart':
          repositoryImplTestTemplate(moduleName, projectName),
      'data/models/${moduleName}_model_test.dart': modelTestTemplate(
        moduleName,
        projectName,
      ),
      'presentation/pages/${moduleName}_page_test.dart': widgetTestTemplate(
        moduleName,
        projectName,
      ),
    };
  }
}

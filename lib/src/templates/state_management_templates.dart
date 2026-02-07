import '../models/state_management.dart';

/// Templates for state management implementations
class StateManagementTemplates {
  StateManagementTemplates._();

  static String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  static String _pascalCase(String text) {
    return text.split('_').map(_capitalize).join();
  }

  // BLoC Templates
  static String blocTemplate(String moduleName) =>
      '''
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/${moduleName}_entity.dart';
import '../../domain/usecases/get_$moduleName.dart';

// Events
abstract class ${_pascalCase(moduleName)}Event {}

class Load${_pascalCase(moduleName)} extends ${_pascalCase(moduleName)}Event {
  final String id;
  Load${_pascalCase(moduleName)}(this.id);
}

// States
abstract class ${_pascalCase(moduleName)}State {}

class ${_pascalCase(moduleName)}Initial extends ${_pascalCase(moduleName)}State {}

class ${_pascalCase(moduleName)}Loading extends ${_pascalCase(moduleName)}State {}

class ${_pascalCase(moduleName)}Loaded extends ${_pascalCase(moduleName)}State {
  final ${_pascalCase(moduleName)}Entity data;
  ${_pascalCase(moduleName)}Loaded(this.data);
}

class ${_pascalCase(moduleName)}Error extends ${_pascalCase(moduleName)}State {
  final String message;
  ${_pascalCase(moduleName)}Error(this.message);
}

// BLoC
class ${_pascalCase(moduleName)}Bloc extends Bloc<${_pascalCase(moduleName)}Event, ${_pascalCase(moduleName)}State> {
  final Get${_pascalCase(moduleName)} get${_pascalCase(moduleName)};

  ${_pascalCase(moduleName)}Bloc(this.get${_pascalCase(moduleName)}) : super(${_pascalCase(moduleName)}Initial()) {
    on<Load${_pascalCase(moduleName)}>(_onLoad${_pascalCase(moduleName)});
  }

  Future<void> _onLoad${_pascalCase(moduleName)}(
    Load${_pascalCase(moduleName)} event,
    Emitter<${_pascalCase(moduleName)}State> emit,
  ) async {
    emit(${_pascalCase(moduleName)}Loading());
    try {
      final data = await get${_pascalCase(moduleName)}(event.id);
      emit(${_pascalCase(moduleName)}Loaded(data));
    } catch (e) {
      emit(${_pascalCase(moduleName)}Error(e.toString()));
    }
  }
}
''';

  // Riverpod Templates
  static String riverpodTemplate(String moduleName) =>
      '''
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/${moduleName}_entity.dart';
import '../../domain/usecases/get_$moduleName.dart';

// State
class ${_pascalCase(moduleName)}State {
  final ${_pascalCase(moduleName)}Entity? data;
  final bool isLoading;
  final String? error;

  const ${_pascalCase(moduleName)}State({
    this.data,
    this.isLoading = false,
    this.error,
  });

  ${_pascalCase(moduleName)}State copyWith({
    ${_pascalCase(moduleName)}Entity? data,
    bool? isLoading,
    String? error,
  }) {
    return ${_pascalCase(moduleName)}State(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Notifier
class ${_pascalCase(moduleName)}Notifier extends StateNotifier<${_pascalCase(moduleName)}State> {
  final Get${_pascalCase(moduleName)} get${_pascalCase(moduleName)};

  ${_pascalCase(moduleName)}Notifier(this.get${_pascalCase(moduleName)}) : super(const ${_pascalCase(moduleName)}State());

  Future<void> load${_pascalCase(moduleName)}(String id) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final data = await get${_pascalCase(moduleName)}(id);
      state = state.copyWith(data: data, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

// Provider
final ${moduleName}Provider = StateNotifierProvider<${_pascalCase(moduleName)}Notifier, ${_pascalCase(moduleName)}State>((ref) {
  // TODO: Inject Get${_pascalCase(moduleName)} usecase
  throw UnimplementedError('Inject Get${_pascalCase(moduleName)} usecase');
});
''';

  // Provider Templates
  static String providerTemplate(String moduleName) =>
      '''
import 'package:flutter/foundation.dart';
import '../../domain/entities/${moduleName}_entity.dart';
import '../../domain/usecases/get_$moduleName.dart';

class ${_pascalCase(moduleName)}Provider extends ChangeNotifier {
  final Get${_pascalCase(moduleName)} get${_pascalCase(moduleName)};

  ${_pascalCase(moduleName)}Provider(this.get${_pascalCase(moduleName)});

  ${_pascalCase(moduleName)}Entity? _data;
  bool _isLoading = false;
  String? _error;

  ${_pascalCase(moduleName)}Entity? get data => _data;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> load${_pascalCase(moduleName)}(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _data = await get${_pascalCase(moduleName)}(id);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}
''';

  // GetX Templates
  static String getxTemplate(String moduleName) =>
      '''
import 'package:get/get.dart';
import '../../domain/entities/${moduleName}_entity.dart';
import '../../domain/usecases/get_$moduleName.dart';

class ${_pascalCase(moduleName)}Controller extends GetxController {
  final Get${_pascalCase(moduleName)} get${_pascalCase(moduleName)};

  ${_pascalCase(moduleName)}Controller(this.get${_pascalCase(moduleName)});

  final Rx<${_pascalCase(moduleName)}Entity?> _data = Rx<${_pascalCase(moduleName)}Entity?>(null);
  final RxBool _isLoading = false.obs;
  final RxString _error = ''.obs;

  ${_pascalCase(moduleName)}Entity? get data => _data.value;
  bool get isLoading => _isLoading.value;
  String get error => _error.value;

  Future<void> load${_pascalCase(moduleName)}(String id) async {
    _isLoading.value = true;
    _error.value = '';

    try {
      _data.value = await get${_pascalCase(moduleName)}(id);
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }
}
''';

  /// Get template based on state management type
  static String? getTemplate(
    StateManagement stateManagement,
    String moduleName,
  ) {
    switch (stateManagement) {
      case StateManagement.bloc:
        return blocTemplate(moduleName);
      case StateManagement.riverpod:
        return riverpodTemplate(moduleName);
      case StateManagement.provider:
        return providerTemplate(moduleName);
      case StateManagement.getx:
        return getxTemplate(moduleName);
      case StateManagement.none:
        return null;
    }
  }

  /// Get folder name for state management files
  static String getFolderName(StateManagement stateManagement) {
    switch (stateManagement) {
      case StateManagement.bloc:
        return 'bloc';
      case StateManagement.riverpod:
        return 'providers';
      case StateManagement.provider:
        return 'providers';
      case StateManagement.getx:
        return 'controllers';
      case StateManagement.none:
        return '';
    }
  }

  /// Get file suffix
  static String getFileSuffix(StateManagement stateManagement) {
    switch (stateManagement) {
      case StateManagement.bloc:
        return 'bloc';
      case StateManagement.riverpod:
        return 'provider';
      case StateManagement.provider:
        return 'provider';
      case StateManagement.getx:
        return 'controller';
      case StateManagement.none:
        return '';
    }
  }
}

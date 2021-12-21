import 'package:get/get.dart';
import 'package:dynamics_news/domain/use_cases/theme_management.dart';

class UIController extends GetxController {
  // Observables
  final _screenIndex = 0.obs;
  final _darkMode = false.obs;
  late ThemeManager _manager;

  set screenIndex(int index) {
    _screenIndex.value = index;
  }

  set themeManager(ThemeManager manager) {
    _manager = manager;
    _initMode(manager);
  }

  // Reactive Getters
  RxInt get reactiveScreenIndex => _screenIndex;

  RxBool get reactiveBrightness => _darkMode;

  // Getters
  int get screenIndex => _screenIndex.value;

  bool get darkMode => _darkMode.value;

  ThemeManager get manager => _manager;

  // Update app brightness mode with stored value
  _initMode(ThemeManager manager) async {
    _darkMode.value = await _manager.storedTheme;
  }
}

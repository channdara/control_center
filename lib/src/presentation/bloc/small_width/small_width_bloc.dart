import 'package:everything_i_need/everything_i_need.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/app_common.dart';
import '../../../common/app_method_channel.dart';
import '../../../model/small_width.dart';
import '../../../model/small_width_type.dart';
import 'small_width_bloc_state.dart';

class SmallWidthBloc extends EinBaseBloc {
  static const List<String> steps = ['1', '3', '5', '7'];
  late SharedPreferences preferences;
  late TabController stepTabController;
  final TextEditingController smallController = TextEditingController();
  final TextEditingController mediumController = TextEditingController();
  final TextEditingController largeController = TextEditingController();
  final FocusNode smallFocusNode = FocusNode();
  final FocusNode mediumFocusNode = FocusNode();
  final FocusNode largeFocusNode = FocusNode();

  int currentWidth = 0;
  bool enforceEvenNumbers = true;

  int get smallWidth => smallController.text.trim().toInt;

  int get mediumWidth => mediumController.text.trim().toInt;

  int get largeWidth => largeController.text.trim().toInt;

  @override
  void dispose() {
    stepTabController.dispose();
    smallController.dispose();
    mediumController.dispose();
    largeController.dispose();
    smallFocusNode.dispose();
    mediumFocusNode.dispose();
    largeFocusNode.dispose();
    super.dispose();
  }

  void initialize(TickerProvider vsync) {
    stepTabController = TabController(length: steps.length, vsync: vsync);
    SharedPreferences.getInstance().then((pref) {
      preferences = pref;
      final small = preferences.getString(SmallWidthType.small.name);
      final medium = preferences.getString(SmallWidthType.medium.name);
      final large = preferences.getString(SmallWidthType.large.name);
      smallController.text = small ?? '438';
      mediumController.text = medium ?? '372';
      largeController.text = large ?? '320';
    });
  }

  void onEnforceEvenNumberChanged(bool value) {
    enforceEvenNumbers = value;
    safeEmit(SmallWidthStateEnableEven());
  }

  Future<void> loadRequiredData() async {
    final current = await AppMethodChannel.getSmallestWidth();
    currentWidth = current;
    safeEmit(SmallWidthStateCurrent(current));
  }

  Future<void> readAndCheckSmallWidth(SmallWidthType type) async {
    final saved = preferences.getString(type.name) ?? '';
    if (saved.isNotEmpty) {
      safeEmit(SmallWidthStateShowOverrideDialog(type));
      return;
    }
    await saveSmallWidth(type);
  }

  Future<void> saveSmallWidth(SmallWidthType type) async {
    final value = await AppMethodChannel.getSmallestWidth();
    await preferences.setString(type.name, value.toString());
    final controller = switch (type) {
      SmallWidthType.small => smallController,
      SmallWidthType.medium => mediumController,
      SmallWidthType.large => largeController,
    };
    controller.text = value.toString();
  }

  void onFieldSubmitted(String value, SmallWidthType type) {
    if (value.isEmpty) return;
    preferences.setString(type.name, value);
  }

  void calculateSmallWidth() {
    if (smallWidth == 0) {
      smallFocusNode.requestFocus();
      return;
    }
    if (mediumWidth == 0) {
      mediumFocusNode.requestFocus();
      return;
    }
    if (largeWidth == 0) {
      largeFocusNode.requestFocus();
      return;
    }
    final anchors = [smallWidth, mediumWidth, largeWidth];
    final step = (stepTabController.index * 2) + 1;
    final calculated = AppCommon.interpolateSequence(
      anchors,
      step,
      enforceEven: enforceEvenNumbers,
    );
    final List<int> listInt = [];
    for (final map in calculated.entries) {
      listInt.add(map.key);
      listInt.addAll(map.value.map((e) => e));
    }
    final listSmallWidth = listInt.map((key) {
      SmallWidthType? type;
      var enable = true;
      if (key == smallWidth) {
        type = SmallWidthType.small;
        enable = false;
      }
      if (key == mediumWidth) {
        type = SmallWidthType.medium;
        enable = false;
      }
      if (key == largeWidth) {
        type = SmallWidthType.large;
        enable = false;
      }
      return SmallWidth(key, type, enable);
    }).toList();
    safeEmit(SmallWidthStateCalculated(step, listSmallWidth));
  }
}

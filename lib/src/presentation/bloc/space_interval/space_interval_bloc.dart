import 'package:everything_i_need/everything_i_need.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../common/app_common.dart';
import '../../../model/space_interval.dart';
import '../../../model/space_interval_type.dart';
import 'space_interval_bloc_state.dart';

class SpaceIntervalBloc extends EinBaseBloc {
  static const List<String> steps = ['1', '2', '3', '4', '5'];
  late TabController intervalTabController;
  final TextEditingController startController = TextEditingController();
  final TextEditingController endController = TextEditingController();
  final TextEditingController intervalController = TextEditingController();
  final FocusNode startFocusNode = FocusNode();
  final FocusNode endFocusNode = FocusNode();
  final FocusNode intervalFocusNode = FocusNode();

  bool convertToInteger = false;

  num get startValue => num.tryParse(startController.text.trim()) ?? -1;

  num get endValue => num.tryParse(endController.text.trim()) ?? -1;

  int get intervalValue => intervalController.text.trim().toInt;

  FilteringTextInputFormatter get inputFormatter {
    final filterPattern = convertToInteger ? r'[0-9]' : r'^\d*\.?\d*';
    return FilteringTextInputFormatter.allow(RegExp(filterPattern));
  }

  @override
  void dispose() {
    intervalTabController.removeListener(intervalChangeListener);
    intervalTabController.dispose();
    startController.dispose();
    endController.dispose();
    intervalController.dispose();
    startFocusNode.dispose();
    endFocusNode.dispose();
    intervalFocusNode.dispose();
    super.dispose();
  }

  void initialize(TickerProvider vsync) {
    intervalTabController = TabController(length: steps.length, vsync: vsync);
    intervalController.text = steps[intervalTabController.index];
    intervalTabController.addListener(intervalChangeListener);
    startController.text = '0';
    endController.text = '100';
  }

  void intervalChangeListener() {
    if (intervalTabController.indexIsChanging) {
      intervalController.text = steps[intervalTabController.index];
    }
  }

  void onEnforceEvenNumberChanged(bool value) {
    convertToInteger = value;
    safeEmit(SpaceIntervalStateValueType());
    startController.clear();
    endController.clear();
  }

  void calculateInterval() {
    if (startValue < 0) {
      startFocusNode.requestFocus();
      return;
    }
    if (endValue < 0) {
      endFocusNode.requestFocus();
      return;
    }
    if (intervalValue == 0) {
      intervalFocusNode.requestFocus();
      return;
    }
    final anchors = [startValue, endValue];
    final calculated = AppCommon.interpolateSequenceNum(anchors, intervalValue);
    final List<num> listNum = [];
    for (final map in calculated.entries) {
      final key = convertToInteger ? map.key.toInt() : map.key.toDouble();
      final value = map.value.map((e) {
        return convertToInteger ? e.toInt() : e.toDouble();
      });
      listNum.add(key);
      listNum.addAll(value);
    }
    listNum.removeAt(0);
    listNum.removeLast();
    final start = SpaceInterval(startValue, SpaceIntervalType.start, false);
    final end = SpaceInterval(endValue, SpaceIntervalType.end, false);
    final mapped = listNum.map((e) => SpaceInterval(e, null, true));
    final items = [start, ...mapped, end];
    safeEmit(SpaceIntervalStateCalculated(intervalValue, items));
  }
}

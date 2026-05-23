import 'package:everything_i_need/everything_i_need.dart';
import 'package:flutter/material.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:screen_brightness/screen_brightness.dart';

import '../../../common/app_common.dart';
import 'main_bloc_state.dart';

class MainBloc extends EinBaseBloc {
  late TabController ringTabController;

  double brightness = AppCommon.minBrightness;
  double systemVolume = 0.0;
  double ringVolume = 0.0;
  double alarmVolume = 0.0;
  double notificationVolume = 0.0;

  bool get isInVibrateMode => systemVolume <= 0.0;

  @override
  void dispose() {
    ringTabController.dispose();
    super.dispose();
  }

  void initialize(TickerProvider vsync) {
    ringTabController = TabController(length: 2, vsync: vsync);
  }

  void loadRequiredData() {
    getBrightness();
    getVolume(true);
  }

  Future<void> getBrightness() async {
    try {
      final raw = await ScreenBrightness.instance.system;
      brightness = raw.clamp(AppCommon.minBrightness, AppCommon.maxBrightness);
      safeEmit(MainStateBrightness());
    } catch (_) {}
  }

  void updateBrightness(double value) {
    brightness = value;
    safeEmit(MainStateBrightness());
  }

  Future<void> setBrightness(double value) async {
    try {
      final clamp = value.clamp(0.01, 1.0);
      await ScreenBrightness.instance.setSystemScreenBrightness(clamp);
    } catch (_) {}
  }

  Future<void> getVolume(bool init) async {
    try {
      for (final stream in [
        AudioStream.system,
        AudioStream.ring,
        AudioStream.alarm,
        AudioStream.notification,
      ]) {
        final raw = await FlutterVolumeController.getVolume(stream: stream);
        final clamp = (raw ?? 0.0).clamp(0.0, 1.0);
        switch (stream) {
          case AudioStream.system:
            systemVolume = clamp;
          case AudioStream.ring:
            ringVolume = clamp;
            if (init) ringTabController.animateTo(clamp == 0.0 ? 1 : 0);
          case AudioStream.alarm:
            alarmVolume = clamp;
          case AudioStream.notification:
            notificationVolume = clamp;
          case AudioStream.voiceCall:
          case AudioStream.music:
          case AudioStream.bluetoothSco:
            continue;
        }
      }
      safeEmit(MainStateVolume());
    } catch (_) {}
  }

  void updateVolume(double value, AudioStream stream) {
    switch (stream) {
      case AudioStream.ring:
        ringVolume = value;
        safeEmit(MainStateVolumeRing());
      case AudioStream.alarm:
        alarmVolume = value;
        safeEmit(MainStateVolumeAlarm());
      case AudioStream.notification:
        notificationVolume = value;
        safeEmit(MainStateVolumeNotification());
      case AudioStream.voiceCall:
      case AudioStream.system:
      case AudioStream.music:
      case AudioStream.bluetoothSco:
        break;
    }
  }

  Future<void> setVolume(double value, AudioStream stream) async {
    try {
      final clamp = switch (stream) {
        AudioStream.voiceCall => value.clamp(0.1, 1.0),
        AudioStream.alarm => value.clamp(0.1, 1.0),
        _ => value.clamp(0.0, 1.0),
      };
      await FlutterVolumeController.setVolume(clamp, stream: stream);
    } catch (_) {}
  }

  Future<void> setRingMode(int index) async {
    await FlutterVolumeController.setVolume(
      index == 0 ? 0.7 : 0.0,
      stream: AudioStream.system,
    );
    await getVolume(false);
  }
}

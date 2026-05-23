import 'package:everything_i_need/everything_i_need.dart';

import '../../../model/space_interval.dart';

class SpaceIntervalStateValueType extends EinBaseBlocState {}

class SpaceIntervalStateCalculated extends EinBaseBlocState {
  SpaceIntervalStateCalculated(this.step, this.items);

  final int step;
  final List<SpaceInterval> items;
}

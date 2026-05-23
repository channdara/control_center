import 'package:everything_i_need/everything_i_need.dart';

import '../../../model/small_width.dart';
import '../../../model/small_width_type.dart';

class SmallWidthStateShowOverrideDialog extends EinBaseBlocState {
  SmallWidthStateShowOverrideDialog(this.type);

  final SmallWidthType type;
}

class SmallWidthStateCalculated extends EinBaseBlocState {
  SmallWidthStateCalculated(this.step, this.items);

  final int step;
  final List<SmallWidth> items;
}

class SmallWidthStateCurrent extends EinBaseBlocState {
  SmallWidthStateCurrent(this.width);

  final int width;
}

class SmallWidthStateEnableEven extends EinBaseBlocState {}

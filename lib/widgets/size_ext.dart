

import 'package:raktdata_app/widgets/util.dart';

extension SizeExt on num {
  double get Sw => Util.getWidth(this);

  double get Sh => Util.getHeight(this);

  double get Sp =>  Util.getSp(this);

  double get r => Util.getRadius(this);
}

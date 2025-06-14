import 'package:flutter_base_app/core/utils/dimensions.dart';
import 'package:flutter_base_app/config/global.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const background = lightGrey;
  static const primary = Colors.cyan;
  static const primaryShop = blue2;
  static get primaryByRole => Global.isUserMode ? primaryShop : primary;

  static const purple = Colors.purple;
  static const green = Color(0xff12c373);
  static const deepPurple = Color(0xff0e1543);
  static const lightGrey = Color(0xFFe4e8ec);
  static const white = Colors.white;
  static const black = Color.fromRGBO(0, 0, 0, 1);

  static final border = primary.withOpacity(Dimensions.borderOpacity);
  static const borderDark = blackLight;
  static final borderLight = primary.withOpacity(Dimensions.borderOpacityLight);
  static final icon = primary.withOpacity(.8);

  static const red = Color(0xFFFC6356);
  static const redDeep = Color(0xFFED5555);
  static const lightRed = Color(0xFFFFFAFA);
  static const lightGrey2 = Color.fromARGB(255, 66, 78, 136);
  static const blackLight = Color(0xFF5f5f5f);
  static const blue = Color(0xFF518CED);
  static const blue2 = Color(0xFF649CF8);
  static const blueDark = Color(0xFF0055B1);
  static const blueGrey = Color(0xFF3778A0);
  static const blueGrey2 = Color(0xFF6986B1);
  static const tableHeader = Color(0xFFE7ECF5);
  static const blueGreyLight = Color(0xFF6B93BE);
  static const blueGreyDark = Color(0xFF496CA0);
  static const greyDark = Color(0xFF7F8FA6);
  static const greyXDark = Color(0xFF7A7A7A);
  static const hint = Color(0xFF999999);
  static const grey = Color(0xFF8A8A8A);
  static const grey2 = Color(0xFFF5F6FA);
  static const grey3 = Color(0xFFDCDFE6);
  static const grey4 = Color(0xFF718093);
  static const grey5 = Color(0xFF5F646E);
  static const grey6 = Color(0xFF707070);
  static const grey7 = Color(0xFF99A3B1);
  static const cornflowerBlue = Color(0xFF6785F5);
  static const indiaGreen = Color(0xFF0C9609);

  static const orange = Color(0xFFF0932B);
  static const lemon = Color(0xFFffe26a);
  static const yellow = Color(0xFFFFB62B);
  static const transparent = Colors.transparent;
  static const pink = Color(0xFFFD64A5);
  static const pinkDark = Color(0xFFEA3D86);
  static const green2 = Color(0xFF51C17D);
  static const green3 = Color(0xFF5FE392);
  static const greenDark = Color(0xFF34C759);
  static const divider = grey;

  // page indicator
  static const indicatorBackground = Color(0xFFB9B9B9);
  static const indicatorActive = Color(0xFFB7B7B7);

  static const btnTakeBreak = Color(0xFFFF454E);
  static const btnGoOut = Color(0xFFFF8E00);

  //
  static const bgInformationDialog = Color(0xFFF2F7FF);
  static const borderInformationDialog = Color(0xFFAAC7FF);

  static const borderPanel = Color(0xFF748091);
  static const bgFlipCamera = Color(0xFF5F5F5F);

  static final whiteLight = AppColors.white.withAlpha(200);
  static final whiteDisabled = AppColors.white.withAlpha(120);

  // PRoduct
  static const sellNumber = Color(0xFF999999);

  static const indicatorInactive = Color(0xFFB7B7B7);

  static Color fromInt(int color) {
    return Color(0xff000000 + color);
  }

  static int toInt(Color color) {
    return color.value - 0xff000000;
  }
}

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

abstract class SVGUtil {
  static SvgPicture renderFromAssets(String assetName,
          {BoxFit fit: BoxFit.fill, Color? color}) =>
      SvgPicture.asset(
        assetName,
        fit: fit,
        color: color,
      );
  static SvgPicture renderFromAssetsFitWidth(String assetName) =>
      SvgPicture.asset(assetName, fit: BoxFit.fitWidth);
  static SvgPicture renderFromNetwork(String assetUrl) =>
      SvgPicture.network(assetUrl);
  static SvgPicture renderFromFile(File assetFile) =>
      SvgPicture.file(assetFile);
}

// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class Assets {
  const Assets._();

  /// File path: assets/icons/.gitignore
  static const String iconsGitignore = 'assets/icons/.gitignore';

  /// File path: assets/images/backgroud_page_view1.svg
  static const SvgGenImage imagesBackgroudPageView1 = SvgGenImage(
    'assets/images/backgroud_page_view1.svg',
  );

  /// File path: assets/images/backgroud_page_view2.svg
  static const SvgGenImage imagesBackgroudPageView2 = SvgGenImage(
    'assets/images/backgroud_page_view2.svg',
  );

  /// File path: assets/images/backgroud_page_view3.svg
  static const SvgGenImage imagesBackgroudPageView3 = SvgGenImage(
    'assets/images/backgroud_page_view3.svg',
  );

  /// File path: assets/images/image_page_item1.svg
  static const SvgGenImage imagesImagePageItem1 = SvgGenImage(
    'assets/images/image_page_item1.svg',
  );

  /// File path: assets/images/image_page_item2.svg
  static const SvgGenImage imagesImagePageItem2 = SvgGenImage(
    'assets/images/image_page_item2.svg',
  );

  /// File path: assets/images/image_page_item3.svg
  static const SvgGenImage imagesImagePageItem3 = SvgGenImage(
    'assets/images/image_page_item3.svg',
  );

  /// List of all assets
  static List<dynamic> get values => [
    iconsGitignore,
    imagesBackgroudPageView1,
    imagesBackgroudPageView2,
    imagesBackgroudPageView3,
    imagesImagePageItem1,
    imagesImagePageItem2,
    imagesImagePageItem3,
  ];
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    _svg.ColorMapper? colorMapper,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
        colorMapper: colorMapper,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

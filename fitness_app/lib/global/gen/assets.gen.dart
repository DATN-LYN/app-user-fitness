/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/empty_data.png
  AssetGenImage get emptyData =>
      const AssetGenImage('assets/images/empty_data.png');

  /// File path: assets/images/finish.png
  AssetGenImage get finish => const AssetGenImage('assets/images/finish.png');

  /// File path: assets/images/intro1.png
  AssetGenImage get intro1 => const AssetGenImage('assets/images/intro1.png');

  /// File path: assets/images/intro2.png
  AssetGenImage get intro2 => const AssetGenImage('assets/images/intro2.png');

  /// File path: assets/images/intro3.png
  AssetGenImage get intro3 => const AssetGenImage('assets/images/intro3.png');

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/logo_container.png
  AssetGenImage get logoContainer =>
      const AssetGenImage('assets/images/logo_container.png');

  /// File path: assets/images/operator.png
  AssetGenImage get operator =>
      const AssetGenImage('assets/images/operator.png');

  /// File path: assets/images/relax.png
  AssetGenImage get relax => const AssetGenImage('assets/images/relax.png');

  /// File path: assets/images/running.png
  AssetGenImage get running => const AssetGenImage('assets/images/running.png');

  /// File path: assets/images/sad_face.png
  AssetGenImage get sadFace =>
      const AssetGenImage('assets/images/sad_face.png');

  /// File path: assets/images/support_center.png
  AssetGenImage get supportCenter =>
      const AssetGenImage('assets/images/support_center.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        emptyData,
        finish,
        intro1,
        intro2,
        intro3,
        logo,
        logoContainer,
        operator,
        relax,
        running,
        sadFace,
        supportCenter
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider() => AssetImage(_assetName);

  String get path => _assetName;

  String get keyName => _assetName;
}

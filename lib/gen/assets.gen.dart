/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class $AssetsAnimationsGen {
  const $AssetsAnimationsGen();

  /// File path: assets/animations/clear-day.json
  LottieGenImage get clearDay =>
      const LottieGenImage('assets/animations/clear-day.json');

  /// File path: assets/animations/clear.json
  LottieGenImage get clear =>
      const LottieGenImage('assets/animations/clear.json');

  /// File path: assets/animations/cloudy.json
  LottieGenImage get cloudy =>
      const LottieGenImage('assets/animations/cloudy.json');

  /// File path: assets/animations/drizzle.json
  LottieGenImage get drizzle =>
      const LottieGenImage('assets/animations/drizzle.json');

  /// File path: assets/animations/mist.json
  LottieGenImage get mist =>
      const LottieGenImage('assets/animations/mist.json');

  /// File path: assets/animations/overcast.json
  LottieGenImage get overcast =>
      const LottieGenImage('assets/animations/overcast.json');

  /// File path: assets/animations/partly-cloudy-day.json
  LottieGenImage get partlyCloudyDay =>
      const LottieGenImage('assets/animations/partly-cloudy-day.json');

  /// File path: assets/animations/rain.json
  LottieGenImage get rain =>
      const LottieGenImage('assets/animations/rain.json');

  /// File path: assets/animations/sun-hot.json
  LottieGenImage get sunHot =>
      const LottieGenImage('assets/animations/sun-hot.json');

  /// List of all assets
  List<LottieGenImage> get values => [
        clearDay,
        clear,
        cloudy,
        drizzle,
        mist,
        overcast,
        partlyCloudyDay,
        rain,
        sunHot
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/cloud.png
  AssetGenImage get cloud => const AssetGenImage('assets/images/cloud.png');

  /// File path: assets/images/humidity.png
  AssetGenImage get humidity =>
      const AssetGenImage('assets/images/humidity.png');

  /// File path: assets/images/rainy.png
  AssetGenImage get rainy => const AssetGenImage('assets/images/rainy.png');

  /// File path: assets/images/sky-night.gif
  AssetGenImage get skyNight =>
      const AssetGenImage('assets/images/sky-night.gif');

  /// File path: assets/images/sun.png
  AssetGenImage get sun => const AssetGenImage('assets/images/sun.png');

  /// File path: assets/images/sunrise.png
  AssetGenImage get sunrise => const AssetGenImage('assets/images/sunrise.png');

  /// File path: assets/images/sunset.png
  AssetGenImage get sunset => const AssetGenImage('assets/images/sunset.png');

  /// File path: assets/images/thermometer.png
  AssetGenImage get thermometer =>
      const AssetGenImage('assets/images/thermometer.png');

  /// File path: assets/images/whirlwind.png
  AssetGenImage get whirlwind =>
      const AssetGenImage('assets/images/whirlwind.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        cloud,
        humidity,
        rainy,
        skyNight,
        sun,
        sunrise,
        sunset,
        thermometer,
        whirlwind
      ];
}

class Assets {
  Assets._();

  static const String package = 'weather_app';

  static const $AssetsAnimationsGen animations = $AssetsAnimationsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  static const String package = 'weather_app';

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
    @Deprecated('Do not specify package for a generated library asset')
    String? package = package,
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

  ImageProvider provider({
    AssetBundle? bundle,
    @Deprecated('Do not specify package for a generated library asset')
    String? package = package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => 'packages/weather_app/$_assetName';
}

class LottieGenImage {
  const LottieGenImage(this._assetName);

  final String _assetName;

  static const String package = 'weather_app';

  LottieBuilder lottie({
    Animation<double>? controller,
    bool? animate,
    FrameRate? frameRate,
    bool? repeat,
    bool? reverse,
    LottieDelegates? delegates,
    LottieOptions? options,
    void Function(LottieComposition)? onLoaded,
    LottieImageProviderFactory? imageProviderFactory,
    Key? key,
    AssetBundle? bundle,
    Widget Function(BuildContext, Widget, LottieComposition?)? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    double? width,
    double? height,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    @Deprecated('Do not specify package for a generated library asset')
    String? package = package,
    bool? addRepaintBoundary,
    FilterQuality? filterQuality,
    void Function(String)? onWarning,
  }) {
    return Lottie.asset(
      _assetName,
      controller: controller,
      animate: animate,
      frameRate: frameRate,
      repeat: repeat,
      reverse: reverse,
      delegates: delegates,
      options: options,
      onLoaded: onLoaded,
      imageProviderFactory: imageProviderFactory,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      package: package,
      addRepaintBoundary: addRepaintBoundary,
      filterQuality: filterQuality,
      onWarning: onWarning,
    );
  }

  String get path => _assetName;

  String get keyName => 'packages/weather_app/$_assetName';
}

// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart' as _lottie;

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

  /// File path: assets/animations/snowy.json
  LottieGenImage get snowy =>
      const LottieGenImage('assets/animations/snowy.json');

  /// File path: assets/animations/sun-hot.json
  LottieGenImage get sunHot =>
      const LottieGenImage('assets/animations/sun-hot.json');

  /// File path: assets/animations/thundery.json
  LottieGenImage get thundery =>
      const LottieGenImage('assets/animations/thundery.json');

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
    snowy,
    sunHot,
    thundery,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/app_icon.png
  AssetGenImage get appIcon =>
      const AssetGenImage('assets/images/app_icon.png');

  /// File path: assets/images/cloud.png
  AssetGenImage get cloud => const AssetGenImage('assets/images/cloud.png');

  /// File path: assets/images/humidity.png
  AssetGenImage get humidity =>
      const AssetGenImage('assets/images/humidity.png');

  /// File path: assets/images/night.gif
  AssetGenImage get night => const AssetGenImage('assets/images/night.gif');

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
    appIcon,
    cloud,
    humidity,
    night,
    rainy,
    skyNight,
    sun,
    sunrise,
    sunset,
    thermometer,
    whirlwind,
  ];
}

class Assets {
  const Assets._();

  static const String package = 'weather_app';

  static const $AssetsAnimationsGen animations = $AssetsAnimationsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  static const String package = 'weather_app';

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

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
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    @Deprecated('Do not specify package for a generated library asset')
    String? package = package,
    FilterQuality filterQuality = FilterQuality.medium,
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
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => 'packages/weather_app/$_assetName';
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}

class LottieGenImage {
  const LottieGenImage(this._assetName, {this.flavors = const {}});

  final String _assetName;
  final Set<String> flavors;

  static const String package = 'weather_app';

  _lottie.LottieBuilder lottie({
    Animation<double>? controller,
    bool? animate,
    _lottie.FrameRate? frameRate,
    bool? repeat,
    bool? reverse,
    _lottie.LottieDelegates? delegates,
    _lottie.LottieOptions? options,
    void Function(_lottie.LottieComposition)? onLoaded,
    _lottie.LottieImageProviderFactory? imageProviderFactory,
    Key? key,
    AssetBundle? bundle,
    Widget Function(BuildContext, Widget, _lottie.LottieComposition?)?
    frameBuilder,
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
    _lottie.LottieDecoder? decoder,
    _lottie.RenderCache? renderCache,
    bool? backgroundLoading,
  }) {
    return _lottie.Lottie.asset(
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
      decoder: decoder,
      renderCache: renderCache,
      backgroundLoading: backgroundLoading,
    );
  }

  String get path => _assetName;

  String get keyName => 'packages/weather_app/$_assetName';
}

// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// @dart = 2.8

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

import 'colors.dart';
import 'text_theme.dart';

/// A characterization of the of a [TextTheme]'s glyphs that is used to define
/// its localized [TextStyle] geometry for [ThemeData.textTheme].
///
/// The script category defines the overall geometry of a [TextTheme] for
/// the [Typography.geometryThemeFor] method in terms of the
/// three language categories defined in <https://material.io/go/design-typography>.
///
/// Generally speaking, font sizes for [ScriptCategory.tall] and
/// [ScriptCategory.dense] scripts - for text styles that are smaller than the
/// title style - are one unit larger than they are for
/// [ScriptCategory.englishLike] scripts.
enum ScriptCategory {
  /// The languages of Western, Central, and Eastern Europe and much of
  /// Africa are typically written in the Latin alphabet. Vietnamese is a
  /// notable exception in that, while it uses a localized form of the Latin
  /// writing system, its accented glyphs can be much taller than those
  /// found in Western European languages. The Greek and Cyrillic writing
  /// systems are very similar to Latin.
  englishLike,

  /// Language scripts that require extra line height to accommodate larger
  /// glyphs, including Chinese, Japanese, and Korean.
  dense,

  /// Language scripts that require extra line height to accommodate
  /// larger glyphs, including South and Southeast Asian and
  /// Middle-Eastern languages, like Arabic, Hindi, Telugu, Thai, and
  /// Vietnamese.
  tall,
}

/// The color and geometry [TextTheme]s for Material apps.
///
/// The text themes provided by the overall [Theme], like
/// [ThemeData.textTheme], are based on the current locale's
/// [MaterialLocalizations.scriptCategory] and are created
/// by merging a color text theme, [black] or [white]
/// and a geometry text theme, one of [englishLike], [dense],
/// or [tall], depending on the locale.
///
/// To lookup a localized text theme use
/// `Theme.of(context).textTheme` or
/// `Theme.of(context).primaryTextTheme` or
/// `Theme.of(context).accentTextTheme`.
///
/// The color text themes are [blackMountainView], [whiteMountainView],
/// [blackCupertino], and [whiteCupertino]. The Mountain View theme [TextStyle]s
/// are based on the Roboto fonts as used on Android. The Cupertino themes are
/// based on the [San Francisco
/// font](https://developer.apple.com/ios/human-interface-guidelines/visual-design/typography/)
/// fonts as used by Apple on iOS.
///
/// Two sets of geometry themes are provided: 2014 and 2018. The 2014 themes
/// correspond to the original version of the Material Design spec and are
/// the defaults. The 2018 themes correspond the second iteration of the
/// specification and feature different font sizes, font weights, and
/// letter spacing values.
///
/// By default, [ThemeData.typography] is `Typography.material2014(platform:
/// platform)` which uses [englishLike2014], [dense2014] and [tall2014]. To use
/// the 2018 text theme geometries, specify a value using the [material2018]
/// constructor:
///
/// ```dart
/// typography: Typography.material2018(platform: platform)
/// ```
///
/// See also:
///
///  * [ThemeData.typography], which can be used to configure the
///    text themes used to create [ThemeData.textTheme],
///    [ThemeData.primaryTextTheme], [ThemeData.accentTextTheme].
///  * <https://material.io/design/typography/>
@immutable
class Typography with Diagnosticable {
  /// Creates a typography instance.
  ///
  /// This constructor is identical to [Typography.material2014]. It is
  /// deprecated because the 2014 material design defaults used by that
  /// constructor are obsolete. The current material design specification
  /// recommendations are those reflected by [Typography.material2018].
  @Deprecated(
      'The default Typography constructor defaults to the 2014 material design defaults. '
      'Applications are urged to migrate to Typography.material2018(), or, if the 2014 defaults '
      'are desired, to explicitly request them using Typography.material2014(). '
      'This feature was deprecated after v1.13.8.')
  factory Typography({
    TargetPlatform platform,
    TextTheme black,
    TextTheme white,
    TextTheme englishLike,
    TextTheme dense,
    TextTheme tall,
  }) = Typography.material2014;

  /// Creates a typography instance using material design's 2014 defaults.
  ///
  /// If [platform] is [TargetPlatform.iOS] or [TargetPlatform.macOS], the
  /// default values for [black] and [white] are [blackCupertino] and
  /// [whiteCupertino] respectively. Otherwise they are [blackMountainView] and
  /// [whiteMountainView]. If [platform] is null then both [black] and [white]
  /// must be specified.
  ///
  /// The default values for [englishLike], [dense], and [tall] are
  /// [englishLike2014], [dense2014], and [tall2014].
  factory Typography.material2014({
    TargetPlatform platform = TargetPlatform.android,
    TextTheme black,
    TextTheme white,
    TextTheme englishLike,
    TextTheme dense,
    TextTheme tall,
  }) {
    assert(platform != null || (black != null && white != null));
    return Typography._withPlatform(
      platform,
      black,
      white,
      englishLike ?? englishLike2014,
      dense ?? dense2014,
      tall ?? tall2014,
    );
  }

  /// Creates a typography instance using material design's 2018 defaults.
  ///
  /// If [platform] is [TargetPlatform.iOS] or [TargetPlatform.macOS], the
  /// default values for [black] and [white] are [blackCupertino] and
  /// [whiteCupertino] respectively. Otherwise they are [blackMountainView] and
  /// [whiteMountainView]. If [platform] is null then both [black] and [white]
  /// must be specified.
  ///
  /// The default values for [englishLike], [dense], and [tall] are
  /// [englishLike2018], [dense2018], and [tall2018].
  factory Typography.material2018({
    TargetPlatform platform = TargetPlatform.android,
    TextTheme black,
    TextTheme white,
    TextTheme englishLike,
    TextTheme dense,
    TextTheme tall,
  }) {
    assert(platform != null || (black != null && white != null));
    return Typography._withPlatform(
      platform,
      black,
      white,
      englishLike ?? englishLike2018,
      dense ?? dense2018,
      tall ?? tall2018,
    );
  }

  factory Typography._withPlatform(
    TargetPlatform platform,
    TextTheme black,
    TextTheme white,
    TextTheme englishLike,
    TextTheme dense,
    TextTheme tall,
  ) {
    assert(platform != null || (black != null && white != null));
    assert(englishLike != null);
    assert(dense != null);
    assert(tall != null);
    switch (platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        black ??= blackCupertino;
        white ??= whiteCupertino;
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        black ??= blackMountainView;
        white ??= whiteMountainView;
        break;
      case TargetPlatform.windows:
        black ??= blackRedmond;
        white ??= whiteRedmond;
        break;
      case TargetPlatform.linux:
        black ??= blackHelsinki;
        white ??= whiteHelsinki;
        break;
    }
    return Typography._(black, white, englishLike, dense, tall);
  }

  const Typography._(
      this.black, this.white, this.englishLike, this.dense, this.tall)
      : assert(black != null),
        assert(white != null),
        assert(englishLike != null),
        assert(dense != null),
        assert(tall != null);

  /// A material design text theme with dark glyphs.
  ///
  /// This [TextTheme] should provide color but not geometry (font size,
  /// weight, etc). A text theme's geometry depends on the locale. To look
  /// up a localized [TextTheme], use the overall [Theme], for example:
  /// `Theme.of(context).textTheme`.
  ///
  /// The [englishLike], [dense], and [tall] text theme's provide locale-specific
  /// geometry.
  final TextTheme black;

  /// A material design text theme with light glyphs.
  ///
  /// This [TextTheme] provides color but not geometry (font size, weight, etc).
  /// A text theme's geometry depends on the locale. To look up a localized
  /// [TextTheme], use the overall [Theme], for example:
  /// `Theme.of(context).textTheme`.
  ///
  /// The [englishLike], [dense], and [tall] text theme's provide locale-specific
  /// geometry.
  final TextTheme white;

  /// Defines text geometry for [ScriptCategory.englishLike] scripts, such as
  /// English, French, Russian, etc.
  ///
  /// This text theme is merged with either [black] or [white], depending
  /// on the overall [ThemeData.brightness], when the current locale's
  /// [MaterialLocalizations.scriptCategory] is [ScriptCategory.englishLike].
  ///
  /// To look up a localized [TextTheme], use the overall [Theme], for
  /// example: `Theme.of(context).textTheme`.
  final TextTheme englishLike;

  /// Defines text geometry for dense scripts, such as Chinese, Japanese
  /// and Korean.
  ///
  /// This text theme is merged with either [black] or [white], depending
  /// on the overall [ThemeData.brightness], when the current locale's
  /// [MaterialLocalizations.scriptCategory] is [ScriptCategory.dense].
  ///
  /// To look up a localized [TextTheme], use the overall [Theme], for
  /// example: `Theme.of(context).textTheme`.
  final TextTheme dense;

  /// Defines text geometry for tall scripts, such as Farsi, Hindi, and Thai.
  ///
  /// This text theme is merged with either [black] or [white], depending
  /// on the overall [ThemeData.brightness], when the current locale's
  /// [MaterialLocalizations.scriptCategory] is [ScriptCategory.tall].
  ///
  /// To look up a localized [TextTheme], use the overall [Theme], for
  /// example: `Theme.of(context).textTheme`.
  final TextTheme tall;

  /// Returns one of [englishLike], [dense], or [tall].
  TextTheme geometryThemeFor(ScriptCategory category) {
    assert(category != null);
    switch (category) {
      case ScriptCategory.englishLike:
        return englishLike;
      case ScriptCategory.dense:
        return dense;
      case ScriptCategory.tall:
        return tall;
    }
    return null;
  }

  /// Creates a copy of this [Typography] with the given fields
  /// replaced by the non-null parameter values.
  Typography copyWith({
    TextTheme black,
    TextTheme white,
    TextTheme englishLike,
    TextTheme dense,
    TextTheme tall,
  }) {
    return Typography._(
      black ?? this.black,
      white ?? this.white,
      englishLike ?? this.englishLike,
      dense ?? this.dense,
      tall ?? this.tall,
    );
  }

  /// Linearly interpolate between two [Typography] objects.
  ///
  /// {@macro dart.ui.shadow.lerp}
  static Typography lerp(Typography a, Typography b, double t) {
    return Typography._(
      TextTheme.lerp(a.black, b.black, t),
      TextTheme.lerp(a.white, b.white, t),
      TextTheme.lerp(a.englishLike, b.englishLike, t),
      TextTheme.lerp(a.dense, b.dense, t),
      TextTheme.lerp(a.tall, b.tall, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is Typography &&
        other.black == black &&
        other.white == white &&
        other.englishLike == englishLike &&
        other.dense == dense &&
        other.tall == tall;
  }

  @override
  int get hashCode {
    return hashValues(
      black,
      white,
      englishLike,
      dense,
      tall,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final Typography defaultTypography = Typography.material2014();
    properties.add(DiagnosticsProperty<TextTheme>('black', black,
        defaultValue: defaultTypography.black));
    properties.add(DiagnosticsProperty<TextTheme>('white', white,
        defaultValue: defaultTypography.white));
    properties.add(DiagnosticsProperty<TextTheme>('englishLike', englishLike,
        defaultValue: defaultTypography.englishLike));
    properties.add(DiagnosticsProperty<TextTheme>('dense', dense,
        defaultValue: defaultTypography.dense));
    properties.add(DiagnosticsProperty<TextTheme>('tall', tall,
        defaultValue: defaultTypography.tall));
  }

  /// A material design text theme with dark glyphs based on Roboto.
  ///
  /// This [TextTheme] provides color but not geometry (font size, weight, etc).
  static const TextTheme blackMountainView = whiteMountainView;

  /// A material design text theme with light glyphs based on Roboto.
  ///
  /// This [TextTheme] provides color but not geometry (font size, weight, etc).
  static const TextTheme whiteMountainView = TextTheme(
    headline1: TextStyle(
        debugLabel: 'whiteMountainView headline1',
        fontFamily: 'Roboto',
        inherit: true,
        color: Colors.white70,
        decoration: TextDecoration.none),
    headline2: TextStyle(
        debugLabel: 'whiteMountainView headline2',
        fontFamily: 'Roboto',
        inherit: true,
        color: Colors.white70,
        decoration: TextDecoration.none),
    headline3: TextStyle(
        debugLabel: 'whiteMountainView headline3',
        fontFamily: 'Roboto',
        inherit: true,
        color: Colors.white70,
        decoration: TextDecoration.none),
    headline4: TextStyle(
        debugLabel: 'whiteMountainView headline4',
        fontFamily: 'Roboto',
        inherit: true,
        color: Colors.white70,
        decoration: TextDecoration.none),
    headline5: TextStyle(
        debugLabel: 'whiteMountainView headline5',
        fontFamily: 'Roboto',
        inherit: true,
        color: Colors.white,
        decoration: TextDecoration.none),
    headline6: TextStyle(
        debugLabel: 'whiteMountainView headline6',
        fontFamily: 'Roboto',
        inherit: true,
        color: Colors.white,
        decoration: TextDecoration.none),
    bodyText1: TextStyle(
        debugLabel: 'whiteMountainView bodyText1',
        fontFamily: 'Roboto',
        inherit: true,
        color: Colors.white,
        decoration: TextDecoration.none),
    bodyText2: TextStyle(
        debugLabel: 'whiteMountainView bodyText2',
        fontFamily: 'Roboto',
        inherit: true,
        color: Colors.white,
        decoration: TextDecoration.none),
    subtitle1: TextStyle(
        debugLabel: 'whiteMountainView subtitle1',
        fontFamily: 'Roboto',
        inherit: true,
        color: Colors.white,
        decoration: TextDecoration.none),
    subtitle2: TextStyle(
        debugLabel: 'whiteMountainView subtitle2',
        fontFamily: 'Roboto',
        inherit: true,
        color: Colors.white,
        decoration: TextDecoration.none),
    caption: TextStyle(
        debugLabel: 'whiteMountainView caption',
        fontFamily: 'Roboto',
        inherit: true,
        color: Colors.white70,
        decoration: TextDecoration.none),
    button: TextStyle(
        debugLabel: 'whiteMountainView button',
        fontFamily: 'Roboto',
        inherit: true,
        color: Colors.white,
        decoration: TextDecoration.none),
    overline: TextStyle(
        debugLabel: 'whiteMountainView overline',
        fontFamily: 'Roboto',
        inherit: true,
        color: Colors.white,
        decoration: TextDecoration.none),
  );

  /// A material design text theme with dark glyphs based on Segoe UI.
  ///
  /// This [TextTheme] provides color but not geometry (font size, weight, etc).
  static const TextTheme blackRedmond = whiteMountainView;

  /// A material design text theme with light glyphs based on Segoe UI.
  ///
  /// This [TextTheme] provides color but not geometry (font size, weight, etc).
  static const TextTheme whiteRedmond = whiteMountainView;

  static const List<String> _helsinkiFontFallbacks = <String>[
    'Ubuntu',
    'Cantarell',
    'DejaVu Sans',
    'Liberation Sans',
    'Arial'
  ];

  /// A material design text theme with dark glyphs based on Roboto, with
  /// fallback fonts that are likely (but not guaranteed) to be installed on
  /// Linux.
  ///
  /// This [TextTheme] provides color but not geometry (font size, weight, etc).
  static const TextTheme blackHelsinki = whiteMountainView;

  /// A material design text theme with light glyphs based on Roboto, with fallbacks of DejaVu Sans, Liberation Sans and Arial.
  ///
  /// This [TextTheme] provides color but not geometry (font size, weight, etc).
  static const TextTheme whiteHelsinki = whiteMountainView;

  /// A material design text theme with dark glyphs based on San Francisco.
  ///
  /// This [TextTheme] provides color but not geometry (font size, weight, etc).
  static const TextTheme blackCupertino = whiteMountainView;

  /// A material design text theme with light glyphs based on San Francisco.
  ///
  /// This [TextTheme] provides color but not geometry (font size, weight, etc).
  static const TextTheme whiteCupertino = whiteMountainView;

  /// Defines text geometry for [ScriptCategory.englishLike] scripts, such as
  /// English, French, Russian, etc.
  static const TextTheme englishLike2014 = whiteMountainView;

  /// Defines text geometry for [ScriptCategory.englishLike] scripts, such as
  /// English, French, Russian, etc.
  ///
  /// The font sizes, weights, and letter spacings in this version match the
  /// [latest Material Design specification](https://material.io/go/design-typography#typography-styles).
  static const TextTheme englishLike2018 = whiteMountainView;

  /// Defines text geometry for dense scripts, such as Chinese, Japanese
  /// and Korean.
  static const TextTheme dense2014 = whiteMountainView;

  /// Defines text geometry for dense scripts, such as Chinese, Japanese
  /// and Korean.
  ///
  /// The font sizes, weights, and letter spacings in this version match the
  /// latest [Material Design specification](https://material.io/go/design-typography#typography-styles).
  static const TextTheme dense2018 = whiteMountainView;

  /// Defines text geometry for tall scripts, such as Farsi, Hindi, and Thai.
  static const TextTheme tall2014 = whiteMountainView;

  /// Defines text geometry for tall scripts, such as Farsi, Hindi, and Thai.
  ///
  /// The font sizes, weights, and letter spacings in this version match the
  /// latest [Material Design specification](https://material.io/go/design-typography#typography-styles).
  static const TextTheme tall2018 = whiteMountainView;
}

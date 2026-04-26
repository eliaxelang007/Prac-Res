import 'package:flutter/material.dart';

double doubleLerp(double a, double b, double t) {
  final range = b - a;
  return a + (range * t);
}

class DesignValues extends ThemeExtension<DesignValues> {
  final double zero = 0;
  final double one = 1;

  final double verySmall;
  final double small;
  final double semiSmall;
  final double medium;
  final double semiLarge;
  final double large;
  final double veryLarge;

  final double verySmallPercent;
  final double smallPercent;
  final double semiSmallPercent;
  final double mediumPercent;
  final double semiLargePercent;
  final double largePercent;
  final double veryLargePercent;

  const DesignValues({
    this.verySmall = 4.0,
    this.small = 8.0,
    this.semiSmall = 12.0,
    this.medium = 16.0,
    this.semiLarge = 24.0,
    this.large = 32.0,
    this.veryLarge = 48.0,

    this.verySmallPercent = ((10 / 8) / 10) * 1, // 0.125
    this.smallPercent = ((10 / 8) / 10) * 2, // 0.25
    this.semiSmallPercent = ((10 / 8) / 10) * 3, // 0.375
    this.mediumPercent = ((10 / 8) / 10) * 4, // 0.5
    this.semiLargePercent = ((10 / 8) / 10) * 5, // 0.625
    this.largePercent = ((10 / 8) / 10) * 6, // 0.75
    this.veryLargePercent = ((10 / 8) / 10) * 7, // 0.875
  });

  @override
  ThemeExtension<DesignValues> copyWith({
    double? none,
    double? verySmall,
    double? small,
    double? semiSmall,
    double? medium,
    double? semiLarge,
    double? large,
    double? veryLarge,

    double? verySmallPercent,
    double? smallPercent,
    double? semiSmallPercent,
    double? mediumPercent,
    double? semiLargePercent,
    double? largePercent,
    double? veryLargePercent,
  }) {
    return DesignValues(
      verySmall: verySmall ?? this.verySmall,
      small: small ?? this.small,
      semiSmall: semiSmall ?? this.semiSmall,
      medium: medium ?? this.medium,
      semiLarge: semiLarge ?? this.semiLarge,
      large: large ?? this.large,
      veryLarge: veryLarge ?? this.veryLarge,

      verySmallPercent: verySmallPercent ?? this.veryLargePercent,
      smallPercent: smallPercent ?? this.smallPercent,
      semiSmallPercent: semiSmallPercent ?? this.semiSmallPercent,
      mediumPercent: mediumPercent ?? this.mediumPercent,
      semiLargePercent: semiLargePercent ?? this.semiLargePercent,
      largePercent: largePercent ?? this.largePercent,
      veryLargePercent: veryLargePercent ?? this.veryLargePercent,
    );
  }

  @override
  DesignValues lerp(DesignValues? other, double t) {
    if (other is! DesignValues) {
      return this;
    }

    return DesignValues(
      verySmall: doubleLerp(verySmall, other.verySmall, t),
      small: doubleLerp(small, other.small, t),
      semiSmall: doubleLerp(semiSmall, other.semiSmall, t),
      medium: doubleLerp(medium, other.medium, t),
      semiLarge: doubleLerp(semiLarge, other.semiLarge, t),
      large: doubleLerp(large, other.large, t),
      veryLarge: doubleLerp(veryLarge, other.veryLarge, t),

      verySmallPercent: doubleLerp(verySmallPercent, other.verySmallPercent, t),
      smallPercent: doubleLerp(smallPercent, other.smallPercent, t),
      semiSmallPercent: doubleLerp(semiSmallPercent, other.semiSmallPercent, t),
      mediumPercent: doubleLerp(mediumPercent, other.mediumPercent, t),
      semiLargePercent: doubleLerp(semiLargePercent, other.semiLargePercent, t),
      largePercent: doubleLerp(largePercent, other.largePercent, t),
      veryLargePercent: doubleLerp(veryLargePercent, other.veryLargePercent, t),
    );
  }
}

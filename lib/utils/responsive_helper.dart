import 'package:flutter/material.dart';

class ResponsiveHelper {
  static const double mobileSmall = 360;
  static const double mobileMedium = 400;
  static const double mobileLarge = 600;
  static const double tablet = 900;
  static const double desktop = 1200;

  static bool isMobileSmall(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileSmall;

  static bool isMobileMedium(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileSmall &&
      MediaQuery.of(context).size.width < mobileMedium;

  static bool isMobileLarge(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileMedium &&
      MediaQuery.of(context).size.width < mobileLarge;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileLarge &&
      MediaQuery.of(context).size.width < tablet;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tablet;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileLarge;

  // Get responsive value based on screen size
  static T responsiveValue<T>(
    BuildContext context, {
    required T mobile,
    T? mobileLarge,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop(context) && desktop != null) return desktop;
    if (isTablet(context) && tablet != null) return tablet;
    if (isMobileLarge(context) && mobileLarge != null) return mobileLarge;
    return mobile;
  }

  // Get screen width
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  // Get screen height
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  // Get responsive font size
  static double fontSize(BuildContext context, double baseSize) {
    final width = screenWidth(context);
    if (width < mobileSmall) return baseSize * 0.9;
    if (width < mobileMedium) return baseSize * 0.95;
    if (width >= tablet) return baseSize * 1.1;
    return baseSize;
  }

  // Get responsive padding
  static EdgeInsets padding(
    BuildContext context, {
    double mobile = 16,
    double? tablet,
    double? desktop,
  }) {
    final value = responsiveValue(
      context,
      mobile: mobile,
      tablet: tablet ?? mobile * 1.5,
      desktop: desktop ?? mobile * 2,
    );
    return EdgeInsets.all(value);
  }

  // Get responsive horizontal padding
  static EdgeInsets horizontalPadding(
    BuildContext context, {
    double mobile = 16,
    double? tablet,
    double? desktop,
  }) {
    final value = responsiveValue(
      context,
      mobile: mobile,
      tablet: tablet ?? mobile * 1.5,
      desktop: desktop ?? mobile * 2,
    );
    return EdgeInsets.symmetric(horizontal: value);
  }

  // Get responsive vertical padding
  static EdgeInsets verticalPadding(
    BuildContext context, {
    double mobile = 16,
    double? tablet,
    double? desktop,
  }) {
    final value = responsiveValue(
      context,
      mobile: mobile,
      tablet: tablet ?? mobile * 1.5,
      desktop: desktop ?? mobile * 2,
    );
    return EdgeInsets.symmetric(vertical: value);
  }

  // Get responsive spacing
  static SizedBox spacing(
    BuildContext context, {
    double mobile = 16,
    double? tablet,
    double? desktop,
  }) {
    final value = responsiveValue(
      context,
      mobile: mobile,
      tablet: tablet ?? mobile * 1.5,
      desktop: desktop ?? mobile * 2,
    );
    return SizedBox(height: value);
  }

  // Get responsive horizontal spacing
  static SizedBox horizontalSpacing(
    BuildContext context, {
    double mobile = 16,
    double? tablet,
    double? desktop,
  }) {
    final value = responsiveValue(
      context,
      mobile: mobile,
      tablet: tablet ?? mobile * 1.5,
      desktop: desktop ?? mobile * 2,
    );
    return SizedBox(width: value);
  }

  // Get grid crossAxisCount based on screen size
  static int gridCrossAxisCount(BuildContext context) {
    if (isDesktop(context)) return 4;
    if (isTablet(context)) return 3;
    return 2;
  }

  // Get responsive icon size
  static double iconSize(BuildContext context, double baseSize) {
    final width = screenWidth(context);
    if (width < mobileSmall) return baseSize * 0.85;
    if (width >= tablet) return baseSize * 1.2;
    return baseSize;
  }

  // Get responsive border radius
  static BorderRadius borderRadius(BuildContext context, double baseRadius) {
    final value = responsiveValue(
      context,
      mobile: baseRadius,
      tablet: baseRadius * 1.2,
      desktop: baseRadius * 1.5,
    );
    return BorderRadius.circular(value);
  }
}

// Widget wrapper for responsive layouts
class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveWidget({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    if (ResponsiveHelper.isDesktop(context) && desktop != null) {
      return desktop!;
    }
    if (ResponsiveHelper.isTablet(context) && tablet != null) {
      return tablet!;
    }
    return mobile;
  }
}

// Responsive padding widget
class ResponsivePadding extends StatelessWidget {
  final Widget child;
  final double mobile;
  final double? tablet;
  final double? desktop;

  const ResponsivePadding({
    super.key,
    required this.child,
    this.mobile = 16,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ResponsiveHelper.padding(
        context,
        mobile: mobile,
        tablet: tablet,
        desktop: desktop,
      ),
      child: child,
    );
  }
}

// Responsive container with max width for large screens
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final EdgeInsets? padding;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.maxWidth = 1200,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: padding != null
            ? Padding(padding: padding!, child: child)
            : child,
      ),
    );
  }
}


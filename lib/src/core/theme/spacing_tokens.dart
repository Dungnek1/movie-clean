/// Spacing tokens following a base 4px scale
/// Used throughout the app for consistent spacing and layout
class Spacing {
  Spacing._();

  // Micro spacing
  static const double xxs = 2.0;  // 0.5 units
  static const double xs = 4.0;   // 1 unit
  static const double sm = 8.0;   // 2 units
  static const double md = 12.0;  // 3 units
  static const double lg = 16.0;  // 4 units
  static const double xl = 24.0;  // 6 units
  static const double xxl = 32.0; // 8 units
  static const double xxxl = 48.0; // 12 units

  // Common use cases
  static const double cardPadding = lg;      // 16px
  static const double pagePadding = lg;      // 16px
  static const double sectionSpacing = xl;   // 24px
  static const double gridGap = md;          // 12px
  static const double listItemSpacing = md;  // 12px
}

/// Border radius tokens for consistent rounded corners
class BorderRadii {
  BorderRadii._();

  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double circle = 999.0;

  // Common use cases
  static const double card = md;       // 12px
  static const double button = sm;     // 8px
  static const double input = sm;      // 8px
  static const double banner = lg;     // 16px
}

/// Icon size tokens for consistent icon sizing
class IconSizes {
  IconSizes._();

  static const double sm = 16.0;
  static const double md = 24.0;
  static const double lg = 32.0;
  static const double xl = 48.0;

  // Common use cases
  static const double defaultIcon = md;     // 24px
  static const double inlineIcon = sm;      // 16px
  static const double heroAction = lg;      // 32px
  static const double emptyState = xl;      // 48px
}

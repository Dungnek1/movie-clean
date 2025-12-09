# CineStream Design Guidelines

## Overview
CineStream is a Flutter-based movie streaming application with a Netflix-inspired dark theme aesthetic. This document establishes comprehensive design standards for consistent, accessible, and visually stunning user experiences.

---

## Color System

### Primary Palette
```dart
// Brand Colors
Primary Red: #E50914 (AppColors.primary)
Secondary Red: #B81D24 (AppColors.secondary)

// Background & Surface
Background: #000000 (AppColors.background)
Surface: #141414 (AppColors.surface)
Surface Elevated: #1F1F1F (recommended addition)

// Text
Text Primary: #FFFFFF (AppColors.textPrimary)
Text Secondary: #B3B3B3 (AppColors.textSecondary)
Text Tertiary: #808080 (recommended addition)
```

### Semantic Colors
```dart
// Status & Feedback
Success: #46D369
Warning: #FFA500
Error: #E50914 (reuse primary)
Info: #0099FF

// Rating & Highlights
Star Rating: #FFA500 (Colors.amber[700])
Highlight: #FFFFFF with 10-20% opacity

// Interactive States
Hover Overlay: #FFFFFF 10% opacity
Pressed Overlay: #FFFFFF 20% opacity
Focus Border: #E50914
Disabled: #808080
```

### Usage Guidelines
- **Primary Red (#E50914)**: CTAs, play buttons, active states, brand emphasis
- **Background (#000000)**: App background, maximizes OLED contrast
- **Surface (#141414)**: Cards, elevated components, content containers
- **Text Primary (#FFFFFF)**: Headings, titles, primary content
- **Text Secondary (#B3B3B3)**: Metadata, descriptions, supporting text

### Accessibility
- **Minimum contrast ratio**: 4.5:1 for normal text, 3:1 for large text (WCAG 2.1 AA)
- Primary Red on black background: 5.8:1 ✓
- White text on black background: 21:1 ✓
- Secondary text (#B3B3B3) on black: 9.4:1 ✓

---

## Typography System

### Type Scale
```dart
// Display (Hero sections)
Display Large: 32px, Bold, Line height 1.2
Display Medium: 28px, Bold, Line height 1.2
Display Small: 24px, Bold, Line height 1.3

// Headings
Headline Large: 24px, Bold, Line height 1.3
Headline Medium: 20px, Bold, Line height 1.4 (AppTypography.headline)
Headline Small: 18px, Bold, Line height 1.4

// Body Text
Body Large: 16px, Regular, Line height 1.6
Body Medium: 14px, Regular, Line height 1.6 (AppTypography.body)
Body Small: 12px, Regular, Line height 1.5

// Labels & Captions
Label: 12px, Medium, Line height 1.5
Caption: 10px, Regular, Line height 1.4
```

### Font Weights
- **Regular**: 400 (body text, descriptions)
- **Medium**: 500 (labels, subtle emphasis)
- **Bold**: 700 (headings, titles, CTAs)

### Typography Hierarchy
1. **Page Title**: Headline Large (24px Bold)
2. **Section Headers**: Headline Medium (20px Bold)
3. **Card Titles**: Body Large (16px Medium) or Headline Small (18px Bold)
4. **Body Content**: Body Medium (14px Regular)
5. **Metadata**: Caption (10-12px Regular)

### Current Issues in Implementation
- Inconsistent font sizes (20px, 16px, 14px used without clear hierarchy)
- Missing type scale definitions
- No line-height specifications
- Hardcoded text styles instead of theme references

---

## Spacing System

### Base Unit: 4px

### Spacing Scale
```dart
// Micro spacing
Space XXS: 2px  (0.5 units)
Space XS: 4px   (1 unit)
Space SM: 8px   (2 units)
Space MD: 12px  (3 units)
Space LG: 16px  (4 units)
Space XL: 24px  (6 units)
Space XXL: 32px (8 units)
Space XXXL: 48px (12 units)

// Component-specific
Card Padding: 16px (LG)
Page Padding: 16px (LG)
Section Spacing: 24px (XL)
Grid Gaps: 12px (MD)
```

### Layout Principles
- **Consistent padding**: 16px for pages/cards
- **Predictable gaps**: 12px for grids, 8-12px for lists
- **Vertical rhythm**: Multiples of 8px for vertical spacing
- **Optical balance**: Adjust spacing based on visual weight, not just math

### Current Issues
- Inconsistent padding (10px, 12px, 16px used interchangeably)
- No defined spacing tokens
- Magic numbers throughout codebase

---

## Component Design Patterns

### Movie Card
**Specifications:**
- Aspect Ratio: 2:3 (portrait poster)
- Border Radius: 12px
- Shadow: 0px 6px 12px rgba(0,0,0,0.25)
- Image height: 200px (grid), flexible (horizontal carousel)
- Padding: 10px internal (should be 12px)
- Hover state: Elevation increase, subtle scale (1.03)

**States:**
- Default: Base card with shadow
- Hover: Elevated shadow, scale transform
- Pressed: Reduced elevation, opacity 0.9
- Loading: Shimmer placeholder (grey.800/700)
- Error: Grey container with broken_image icon

### Hero Banner
**Specifications:**
- Height: 220px (should be responsive: 40-50vh on mobile, 60vh on tablet+)
- Border Radius: 16px
- Gradient Overlay: Linear, bottom-to-top, black87 to transparent
- Content Padding: 16px
- Button Spacing: 12px horizontal

**Elements:**
- Poster Image: Full bleed with gradient overlay
- Title: 20px Bold, white
- Overview: 14px Regular, white70, 2 lines max
- CTAs: Play (elevated), More Info (outlined)

### Search Input
**Specifications:**
- Height: 48px (minimum touch target)
- Border Radius: 8px
- Padding: 12px horizontal, 8px vertical
- Border: 1px solid white24 (default), primary red (focused)

**States:**
- Default: White24 border
- Focused: Primary red border, elevation shadow
- Filled: Maintains focus styling
- Disabled: Grey border, reduced opacity

### Bottom Navigation
**Specifications:**
- Height: 56px (Material Design standard)
- Background: Black (#000000)
- Selected Color: Primary Red (#E50914)
- Unselected Color: White70 (#FFFFFF B3)
- Icon Size: 24px
- Label: 12px Medium

---

## Layout & Grid System

### Breakpoints
```dart
// Mobile-first approach
Mobile: 0-599px (default)
Tablet: 600-1023px
Desktop: 1024-1439px
Large Desktop: 1440px+
```

### Grid Specifications

**Movie Grid (Portrait)**
- Mobile: 2 columns
- Tablet: 3-4 columns
- Desktop: 5-6 columns
- Cross Axis Spacing: 12px
- Main Axis Spacing: 12px
- Aspect Ratio: 0.62 (2:3 poster)

**Horizontal Carousels**
- Item Width: 140px (mobile), 160px (tablet+)
- Item Height: 220px (mobile), 240px (tablet+)
- Spacing: 12px
- Scroll Physics: Platform-specific momentum

### Responsive Patterns
- **Mobile**: Single column, stacked sections, bottom nav
- **Tablet**: 2-3 columns, side nav option, increased spacing
- **Desktop**: Multi-column layouts, persistent side nav, larger imagery

### Current Issues
- No responsive breakpoint definitions
- Fixed dimensions (140px, 220px) don't scale
- Missing tablet/desktop optimizations

---

## Accessibility Standards

### Touch Targets
- Minimum size: 48x48dp (Material Design)
- Recommended: 56x56dp for primary actions
- Spacing between targets: 8dp minimum

### Color Contrast
- Normal text (14-18px): 4.5:1 minimum
- Large text (18px+ or 14px+ bold): 3:1 minimum
- Interactive components: 3:1 minimum
- Current palette meets WCAG 2.1 AA ✓

### Focus Management
- Visible focus indicators: 2px solid primary red
- Logical tab order: Top-to-bottom, left-to-right
- Skip links: Implement for main content
- Screen reader labels: All interactive elements

### Motion & Animation
- Respect `prefers-reduced-motion`
- Duration: 200-300ms for micro-interactions
- Easing: Cubic bezier for natural movement
- Disable parallax for motion sensitivity

### Semantic HTML/Widgets
- Proper heading hierarchy (h1-h6 equivalents)
- ARIA labels for icon-only buttons
- Alt text for all images (CachedNetworkImage semanticLabel)
- Semantic roles for custom widgets

### Current Issues
- Some touch targets below 48dp (e.g., text buttons)
- No focus indicators defined
- Missing semantic labels
- No reduced-motion considerations

---

## Iconography

### Icon Style
- Outlined icons (Material Design)
- Size: 24px (default), 16px (inline), 32px (hero actions)
- Color: Inherit from context or explicit semantic color

### Common Icons
- Home: `Icons.home`
- Search: `Icons.search`
- Downloads: `Icons.download`
- Profile: `Icons.person`
- Play: `Icons.play_arrow`
- Info: `Icons.info_outline`
- Star (rating): `Icons.star`
- Close: `Icons.close`
- More: `Icons.more_vert`

### Usage Guidelines
- Consistent sizing within context
- Pair with labels for clarity
- Use semantic colors (warning, error, success)
- Ensure 3:1 contrast ratio minimum

---

## Animations & Micro-interactions

### Animation Principles
- **Purpose-driven**: Every animation serves a function
- **Subtle**: Enhance, don't distract
- **Performance**: 60fps, GPU-accelerated
- **Consistent timing**: 200-300ms for UI transitions

### Common Animations
```dart
// Page Transitions
Duration: 250ms
Curve: Curves.easeInOut
Type: Fade + Slide (vertical for modals, horizontal for pages)

// Card Hover/Press
Duration: 150ms
Scale: 1.0 → 1.03 (hover)
Shadow: Elevation 4 → 8 (hover)

// Loading States
Shimmer: 1500ms loop
Progress Indicators: Indeterminate circular

// Button Press
Duration: 100ms
Scale: 1.0 → 0.97 (press)
Opacity: 1.0 → 0.9 (press)
```

### Micro-interactions
- **Pull-to-refresh**: Custom branded animation
- **Like/Favorite**: Heart scale + color pulse
- **Video scrubbing**: Preview thumbnail on seek
- **Search typing**: Debounced with visual feedback
- **Scroll reveal**: Fade-in sections on scroll

### Current Issues
- No defined animation standards
- Missing page transitions (using NoTransitionPage)
- No hover states implemented
- No motion preferences handling

---

## Navigation Patterns

### Bottom Navigation (Mobile)
- 4 primary destinations: Home, Search, Downloads, Profile
- Persistent across primary routes
- Active state: Primary red icon + label
- Hidden on secondary routes (detail, player)

### App Bar
- Height: 56dp (standard)
- Background: Black
- Elevation: 0 (flat design)
- Title: Centered or left-aligned (platform convention)
- Actions: Right-aligned icons

### Routing Strategy
- **Primary routes**: Bottom nav destinations
- **Detail routes**: Full-screen overlays with back navigation
- **Modal routes**: Player, settings, overlays
- **Deep linking**: Support for content sharing

### Current Implementation
- Bottom nav works correctly
- NoTransitionPage removes all animations (poor UX)
- Missing breadcrumb/hierarchy indicators
- No deep link handling

---

## Loading & Empty States

### Loading States
**Skeleton Screens (Preferred)**
```dart
Shimmer effect:
- Base Color: grey.800
- Highlight Color: grey.700
- Duration: 1500ms
- Shape: Matches final content
```

**Progress Indicators**
- Circular: Centered, primary color
- Linear: Top of screen, indeterminate
- Duration: Show after 300ms delay

### Empty States
**Components:**
- Icon: Large (48-64px), grey color
- Heading: "No [content] yet"
- Description: Helpful context
- Action: Primary CTA (if applicable)

**Examples:**
- No search results: "Không tìm thấy" + search icon
- Empty downloads: "No downloads" + add prompt
- Error state: Error icon + retry button

### Error States
- Clear error message (user-friendly language)
- Icon indicating error type
- Retry action button
- Optional support contact link

### Current Implementation
- Good: Shimmer loading for images
- Missing: Skeleton screens for content sections
- Inconsistent: Error messages (some in Vietnamese, some in English)
- No retry mechanisms

---

## Imagery & Media

### Image Specifications
**Movie Posters:**
- Aspect Ratio: 2:3 (portrait)
- Recommended Resolution: 500x750px minimum
- Format: JPEG (optimized), WebP (preferred)
- Lazy Loading: CachedNetworkImage with shimmer

**Hero Banners:**
- Aspect Ratio: 16:9 (landscape)
- Resolution: 1280x720px minimum
- Format: JPEG/WebP
- Overlay: Required gradient for text readability

**Profile Images:**
- Aspect Ratio: 1:1 (square)
- Resolution: 200x200px minimum
- Format: JPEG/WebP
- Fallback: Initials or generic icon

### Image Optimization
- Lazy loading: All off-screen images
- Caching: CachedNetworkImage with 30-day cache
- Progressive loading: Low-quality placeholder → full quality
- Error handling: Fallback to placeholder

### Video Player
- Aspect Ratio: Maintain source ratio
- Controls: BetterPlayer default + custom branding
- Quality selection: Auto + manual options
- Subtitles: Optional, user-controlled
- PiP support: On supported platforms

---

## Theme Configuration

### Material 3 Implementation
```dart
ThemeData.dark().copyWith(
  colorScheme: ColorScheme.dark(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    background: AppColors.background,
    surface: AppColors.surface,
  ),
  useMaterial3: true,

  // Add missing properties:
  textTheme: AppTypography.textTheme,
  elevatedButtonTheme: AppButtonStyles.elevated,
  outlinedButtonTheme: AppButtonStyles.outlined,
  inputDecorationTheme: AppInputStyles.theme,
)
```

### Component Themes
**Button Themes:**
- Elevated: Primary color, white text, 8px radius
- Outlined: White border, white text, 8px radius
- Text: Primary color text, no background

**Input Themes:**
- Border: 1px white24, 8px radius
- Focused: Primary red border
- Filled: Surface color background
- Padding: 16px horizontal, 12px vertical

### Dark Theme Principles
- True black background (#000000) for OLED efficiency
- High contrast white text (#FFFFFF)
- Subtle surface elevation (#141414)
- Minimal color usage (brand red for emphasis)

---

## Vietnamese Language Support

### Font Considerations
- Ensure font supports Vietnamese diacritics: ă, â, đ, ê, ô, ơ, ư, etc.
- Recommended: Roboto (default Material), Inter, SF Pro (iOS)
- Line-height: 1.6 minimum for readability with accents

### Text Handling
- UTF-8 encoding throughout
- Proper capitalization (Vietnamese title case differs from English)
- Text wrapping: Avoid breaking compound words
- Locale-specific formatting (dates, numbers)

### Current Implementation
- Mixed Vietnamese/English labels (inconsistent)
- Need translation strategy: i18n/l10n
- No locale detection or switching

---

## Performance Guidelines

### Image Performance
- Lazy load all images
- Use CachedNetworkImage (already implemented ✓)
- Compress images: 80% JPEG quality
- Serve appropriate sizes (responsive images)

### Animation Performance
- Use GPU-accelerated properties (transform, opacity)
- Avoid layout thrashing (size, position changes)
- Limit simultaneous animations (3-4 max)
- Profile with Flutter DevTools

### List Performance
- Use ListView.builder for dynamic lists ✓
- Implement pagination (infinite scroll)
- Cache item heights for smooth scrolling
- Limit grid cross-axis count on large screens

### State Management
- Riverpod AsyncValue for loading states ✓
- Cache fetched data appropriately
- Debounce search input (300ms)
- Optimize provider rebuilds

---

## Design Tokens (Recommended Implementation)

### Create Token Classes
```dart
// spacing_tokens.dart
class Spacing {
  static const xxs = 2.0;
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 24.0;
  static const xxl = 32.0;
  static const xxxl = 48.0;
}

// typography_tokens.dart
class Typography {
  static const displayLarge = TextStyle(...);
  static const headlineMedium = TextStyle(...);
  // etc.
}

// radius_tokens.dart
class BorderRadii {
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 24.0;
  static const circle = 999.0;
}
```

---

## Design Checklist

### Before Implementing Any UI Component:
- [ ] Define component specifications (size, spacing, colors)
- [ ] Consider all states (default, hover, focus, disabled, error, loading)
- [ ] Ensure accessibility (contrast, touch targets, labels)
- [ ] Plan responsive behavior (mobile, tablet, desktop)
- [ ] Use design tokens instead of magic numbers
- [ ] Add loading and error states
- [ ] Test with real content (long text, missing images)
- [ ] Validate against this guideline document

### Code Review Checklist:
- [ ] Uses theme properties, not hardcoded colors
- [ ] Implements proper spacing system
- [ ] Accessible to screen readers
- [ ] Responsive across breakpoints
- [ ] Handles loading/error states
- [ ] Consistent with existing patterns
- [ ] Performant (profiled if necessary)

---

## Future Enhancements

### Design System Maturity
1. Create comprehensive component library
2. Implement design token system
3. Add Storybook/Widgetbook for component showcase
4. Establish design QA process
5. Create designer-developer handoff documentation

### Advanced Features
- Dark/Light theme toggle (currently dark-only)
- Custom theme creation (user personalization)
- Animation preference settings
- Accessibility preference panel
- High contrast mode

---

## References & Inspiration

### Design Systems
- Material Design 3: https://m3.material.io/
- Netflix Design: https://brand.netflix.com/
- Apple HIG: https://developer.apple.com/design/

### Tools
- Flutter Documentation: https://docs.flutter.dev/
- Accessibility: WCAG 2.1 Guidelines
- Color Contrast: WebAIM Contrast Checker

---

**Document Version:** 1.0
**Last Updated:** 2025-12-09
**Maintainer:** UI/UX Design Team

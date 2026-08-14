---
name: Falex High-Performance Interface
colors:
  surface: '#f7fafc'
  surface-dim: '#d7dadc'
  surface-bright: '#f7fafc'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f1f4f6'
  surface-container: '#ebeef0'
  surface-container-high: '#e5e9eb'
  surface-container-highest: '#e0e3e5'
  on-surface: '#181c1e'
  on-surface-variant: '#44474c'
  inverse-surface: '#2d3133'
  inverse-on-surface: '#eef1f3'
  outline: '#74777d'
  outline-variant: '#c4c6cd'
  surface-tint: '#4f6073'
  primary: '#041627'
  on-primary: '#ffffff'
  primary-container: '#1a2b3c'
  on-primary-container: '#8192a7'
  inverse-primary: '#b7c8de'
  secondary: '#545f72'
  on-secondary: '#ffffff'
  secondary-container: '#d5e0f7'
  on-secondary-container: '#586377'
  tertiary: '#00162c'
  on-tertiary: '#ffffff'
  tertiary-container: '#002b4e'
  on-tertiary-container: '#4894e2'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#d2e4fb'
  primary-fixed-dim: '#b7c8de'
  on-primary-fixed: '#0b1d2d'
  on-primary-fixed-variant: '#38485a'
  secondary-fixed: '#d8e3fa'
  secondary-fixed-dim: '#bcc7dd'
  on-secondary-fixed: '#111c2c'
  on-secondary-fixed-variant: '#3c475a'
  tertiary-fixed: '#d2e4ff'
  tertiary-fixed-dim: '#9fcaff'
  on-tertiary-fixed: '#001d37'
  on-tertiary-fixed-variant: '#00497e'
  background: '#f7fafc'
  on-background: '#181c1e'
  surface-variant: '#e0e3e5'
typography:
  display-lg:
    fontFamily: Inter
    fontSize: 48px
    fontWeight: '700'
    lineHeight: 56px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '600'
    lineHeight: 40px
    letterSpacing: -0.01em
  headline-lg-mobile:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
  headline-md:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
  headline-sm:
    fontFamily: Inter
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
  body-lg:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-sm:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-md:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.05em
  data-mono:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '500'
    lineHeight: 20px
    letterSpacing: -0.01em
rounded:
  sm: 0.125rem
  DEFAULT: 0.25rem
  md: 0.375rem
  lg: 0.5rem
  xl: 0.75rem
  full: 9999px
spacing:
  unit: 4px
  container-padding-mobile: 1rem
  container-padding-desktop: 2rem
  gutter: 1.5rem
  stack-xs: 0.25rem
  stack-sm: 0.5rem
  stack-md: 1rem
  stack-lg: 1.5rem
---

## Brand & Style

The design system is engineered for high-stakes logistics and financial oversight. The brand personality is **authoritative, precise, and frictionless**, aiming to instill a sense of absolute control and reliability in the user. 

The visual style follows **Modern Corporate Functionalism**. It prioritizes clarity and data density through a systematic grid, utilizing subtle depth and clean borders to organize complex information sets. By balancing utility-driven layouts with refined finishing touches—such as micro-interactions and intentional whitespace—the UI ensures that professional users can navigate high volumes of data without cognitive fatigue. The emotional response is one of "calm productivity" and "unshakeable efficiency."

## Colors

The palette is anchored by "Trust & Efficiency" tones.
- **Deep Navy (Primary):** Used for structural navigation, headers, and primary branding to convey stability and institutional trust.
- **Slate Grey (Secondary):** Used for sub-headers, iconography, and supporting text to maintain a sophisticated, low-strain hierarchy.
- **Action Blue (CTA):** A high-vibrancy blue reserved strictly for interactive elements, primary actions, and progress indicators.
- **Neutral/Surface:** A range of cool greys (from #F7FAFC to #E2E8F0) creates the background layering needed to separate distinct data modules.
- **Semantic Colors:** Rigorous application of Green (Success), Orange (Warning), and Red (Error) for real-time logistics status and financial alerts.

## Typography

The typography system utilizes **Inter** for its exceptional legibility in data-heavy environments. The scale is built on a tight melodic ratio to maintain high information density while preserving hierarchy. 

- **Numerical Data:** For financial figures and tracking numbers, use `data-mono` (Inter with tabular lining figures) to ensure vertical alignment in tables.
- **Labels:** Small, uppercase labels with slight letter spacing are used for metadata and table headers to distinguish them from actionable content.
- **Weight Usage:** Reserve Bold (700) for displays; Medium (500/600) for UI controls and section headers; and Regular (400) for all instructional and body text.

## Layout & Spacing

This design system employs a **Fixed-Fluid Hybrid Grid**. 
- **Desktop:** A 12-column grid with a max-width of 1440px. Gutters are fixed at 24px to ensure data density remains high without looking crowded.
- **Tablet:** An 8-column grid with 16px margins.
- **Mobile:** A 4-column fluid grid.

The spacing scale is strictly based on a **4px base unit**. Component internals (padding/margins) should always be multiples of 4. Use "compact" spacing for data tables (8px vertical padding) and "spacious" spacing for marketing or onboarding screens (24px+ vertical padding).

## Elevation & Depth

To maintain a "Professional & Clean" look, this design system avoids heavy shadows, instead using **Tonal Layering and Crisp Outlines**.

1.  **Level 0 (Base):** The primary background color (#F7FAFC).
2.  **Level 1 (Cards/Sections):** White (#FFFFFF) surfaces with a 1px border (#E2E8F0). This is the default state for data modules.
3.  **Level 2 (Active/Floating):** A very soft, diffused shadow (0px 4px 12px rgba(26, 43, 60, 0.05)) used for dropdowns, modals, and active tooltips.
4.  **Interactive States:** On hover, cards should not "lift" with shadows, but rather transition their border color to the Secondary Slate Grey or Primary Navy to indicate focus.

## Shapes

The shape language is **Structured and Geometric**. By using a "Soft" (0.25rem) corner radius, the UI maintains a professional, serious architectural feel while avoiding the "sharpness" of pure 90-degree angles.

- **Standard Elements:** Buttons, Input Fields, and Chips use a 4px (0.25rem) radius.
- **Containers:** Large data cards and modals use an 8px (0.5rem) radius to frame content effectively.
- **Interactive Indicators:** Checkboxes and Radio buttons follow the standard 4px and circular rules respectively.

## Components

### Buttons & Actions
- **Primary:** Solid Action Blue (#3182CE) with white text. High-contrast, no gradient.
- **Secondary:** Transparent background with a 1px Navy border and Navy text.
- **Ghost:** No border or background; text turns Action Blue on hover.

### Data Cards
- White background, 1px #E2E8F0 border.
- Headers should have a subtle bottom divider.
- Use a "Label/Value" stack for financial metrics, where the Label is `label-md` and the Value is `body-lg` (Medium weight).

### List Views & Tables
- Zebra-striping is discouraged. Use thin 1px horizontal dividers instead.
- Hover states on rows should use a light tint of Action Blue (5% opacity) to provide clear feedback.

### Input Fields
- **Default State:** White background, 1px #CBD5E0 border.
- **Focus State:** 1px Action Blue border with a 2px soft blue outer glow (ring).
- **Labeling:** Labels are always positioned above the input field, never inside as placeholders, to maintain accessibility.

### Chips & Badges
- Used for status (e.g., "In Transit", "Paid").
- Use a "Subtle Filled" style: a light background tint of the semantic color with high-contrast text of the same hue (e.g., Light Green background with Dark Green text).
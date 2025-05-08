# Changelog - CDC Mall App Development

## May 8, 2025

### 🛠️ UI Improvements

#### Promotional Banner Fixes

- Fixed text overflow issues in promotional banners
- Reduced font size for banner description (from 14px to 12px)
- Added text overflow handling with ellipsis
- Limited description text to max 2 lines
- Adjusted flex ratio between text and image sections (3:2)
- Set fixed height to ensure consistent display
- Added sizing constraints to button to prevent overflow
- Reduced button padding to fit smaller space

### 📊 JSON Data Integration

#### Added

- Integrated JSON data for promotional banners
- Created `PromoBannerService` to load and parse banner data from JSON
- Enhanced `Image.network` with error and loading handlers for better UX
- Updated `HomeBloc` to load promo banners from JSON file
- Added JSON assets to pubspec.yaml for proper bundling

## May 5, 2025

### 🚀 Initial Setup & Home UI Implementation

#### Project Structure

- Created core project structure following best practices:
  - `/lib/core/theme` - For app-wide theming
  - `/lib/features/home` - Feature-based architecture for home page
  - `/lib/shared/widgets` - Shared widgets across the app

#### Theme Setup

- Created `AppTheme` class with Material 3 support
- Defined brand colors (black primary color, orange accent color)
- Configured custom text styles and component themes

#### Dependencies

- Added Flutter Bloc (`flutter_bloc: 9.1.1`) for state management
- Added Equatable (`equatable: 2.0.7`) for value equality

#### Models & Data

- Created data models for the app:
  - `Category` - For shop categories
  - `Product` - For product listings
  - `PromoBanner` - For promotional banners
- Implemented `DummyDataProvider` for mock data

#### UI Components

- Created reusable widgets:
  - `SearchBarWidget` - Custom search bar with filter button
  - `SectionHeaderWidget` - Section titles with "See all" action
  - `PromoBannerWidget` - Banner carousel for promotions
  - `CategoryWidget` - Circular category selector
  - `ProductCardWidget` - Product display with price and actions

#### Home Page

- Implemented `HomePage` with sections:
  - App bar with notification icon
  - Search functionality
  - "Popular Item" carousel with banners
  - "Shop by category" horizontal list
  - "New In" product listing
- Added proper spacing and styling to match design
- Implemented pagination dots for banner carousel

#### State Management

- Set up `HomeBloc` with Flutter Bloc
- Implemented events and states for home page data loading
- Connected UI components to bloc state

#### Assets Configuration

- Created `assets/images` directory
- Added asset configuration to `pubspec.yaml`
- Used placeholder images for categories and products

#### Features

- Added favorite toggle functionality for products
- Implemented "Shop now" button for promotional banners

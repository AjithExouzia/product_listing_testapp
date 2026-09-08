# Product Listing App

A modern Flutter e-commerce application featuring product listing, search, filtering, favorites, and shopping cart functionality built with clean architecture and BLoC pattern.

## 🚀 Setup & Run Instructions

### Prerequisites
- Flutter 3.7.2+
- Dart 3.7.2+
- Android SDK / iOS SDK (for deployment)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd product_listing_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

4. **Build for release** (optional)
   ```bash
   # Android
   flutter build apk

   # iOS
   flutter build ios
   ```

## 🔌 API Used

**Fake Store API** - https://fakestoreapi.com

### Endpoints Utilized:
- `GET /products` - Fetch all products
- `GET /products/categories` - Fetch available categories
- `GET /products/category/{category}` - Fetch products by category
- `GET /products/{id}` - Fetch single product details

**API Features:**
- No authentication required
- Free to use
- ~20 products with realistic e-commerce data
- Includes pricing, descriptions, ratings, and images

## 📱 Key Features

✅ **Product Listing** - Browse products with grid display
✅ **Search** - Real-time product search by title
✅ **Category Filtering** - Filter by 4 categories (electronics, jewelery, men's/women's clothing)
✅ **Product Details** - Full product information with ratings and descriptions
✅ **Shopping Cart** - Add/remove items with quantity control
✅ **Favorites** - Save favorite products with persistence
✅ **Bottom Navigation** - Navigate between Home, Cart, Orders, Wallet, Profile screens
✅ **Responsive Design** - Works on mobile, tablet, and desktop screens
✅ **Pull-to-Refresh** - Manually refresh product list
✅ **Persistent Storage** - Cart and favorites saved with SharedPreferences
✅ **Image Caching** - Network images cached for better performance

## 🏗️ Architecture

**Clean Architecture with BLoC Pattern:**

```
lib/
├── bloc/              # State management (ProductBloc, CartCubit, FavoritesCubit)
├── models/            # Data models (Product, CartItem, Rating)
├── services/          # API & local storage services
├── screens/           # Full-screen widgets
├── widgets/           # Reusable components
├── routes/            # GoRouter navigation
└── main.dart          # App entry point
```

**State Management:**
- **ProductBloc** - Manages product data, filtering, and search
- **CartCubit** - Manages shopping cart state
- **FavoritesCubit** - Manages favorite products

## ⚙️ Dependencies

- **flutter_bloc** (8.1.3) - State management
- **go_router** (13.0.0) - Navigation with deep linking
- **http** (1.1.0) - API calls
- **shared_preferences** (2.2.2) - Local data persistence
- **cached_network_image** (3.3.0) - Image caching
- **equatable** (2.0.5) - Value object comparison

## 📋 Assumptions & Time-Saving Shortcuts

Due to time constraints, the following decisions were made:

### 1. **Placeholder Screens**
- Orders, Wallet, and Profile screens are UI placeholders
- They display static content showing "No data yet"
- **Rationale:** Core shopping functionality (products, cart, favorites) prioritized

### 2. **Authentication Skipped**
- No user login/signup implemented
- User data is hardcoded (Andrew Ainsley)
- **Rationale:** Focus on product display and cart management

### 3. **Mock Payment Processing**
- Checkout button exists but has no backend integration
- No actual payment gateway connected
- **Rationale:** Payment processing requires separate backend setup

### 4. **Limited Filtering**
- Only category and search-based filtering implemented
- No price range, rating filters, or sorting options
- **Rationale:** Core filtering functionality covers main use cases

### 5. **Basic Order History**
- No order persistence or order history tracking
- Orders screen is placeholder only
- **Rationale:** Would require additional backend tables and API endpoints

### 6. **Network Image Only**
- User profile image loaded from network URL only
- No fallback image asset included
- **Rationale:** Unsplash image demonstrates network image loading capability

### 7. **Simple Reviews Display**
- Shows rating count and average, but no individual reviews
- **Rationale:** Focus on main product information and purchasing flow

### 8. **Category Cache Only**
- Uses in-memory caching (no persistent category cache)
- **Rationale:** Simple solution for improved performance on tab switching

## 🔄 Responsive Design

- **Mobile (< 600px):** 2-column grid, optimized spacing
- **Tablet (600-900px):** 3-column grid, increased padding
- **Desktop (≥ 900px):** Adaptive layouts

All screens use `MediaQuery` for responsive sizing of fonts, images, and spacing.

## 🛠️ Testing the App

1. **Product Browsing:**
   - App loads all products automatically
   - Scroll and view product grid

2. **Search:**
   - Type in search bar to filter products by title
   - Clear button removes search query

3. **Category Filtering:**
   - Tap "All" to show all products
   - Tap category names to filter (electronics, jewelery, etc.)

4. **Cart Management:**
   - Tap "Add to Cart" on any product
   - Navigate to Cart via bottom nav bar
   - Adjust quantities or remove items

5. **Favorites:**
   - Tap heart icon to add to favorites
   - View favorites from Favorites screen
   - Access via home screen heart icon

## 📝 Notes

- All data is fetched from the Fake Store API (no backend required)
- Cart and favorites persist across app sessions
- Images are cached automatically for better performance
- Pull-to-refresh available on home screen

## 📄 License

This project is created for educational/interview purposes.

---

**Last Updated:** September 2026
**Flutter Version:** 3.7.2+
**Status:** Ready for GitHub Submission ✅

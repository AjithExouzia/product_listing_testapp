# Quick Start Guide

## ⚡ Get Started in 2 Minutes

### Step 1: Install Dependencies
```bash
cd c:\Users\ACER\StudioProjects\product_listing_app
flutter pub get
```

### Step 2: Run the App
```bash
flutter run
```

That's it! 🎉

## What to Expect

### On First Launch
- App loads and displays a loading indicator
- Products are fetched from Fake Store API (https://fakestoreapi.com)
- Products appear in a 2-column grid with images, titles, ratings, and prices

### Features to Try

#### 1. **Search Products**
   - Tap the search bar at the top
   - Type any product name (e.g., "shirt", "phone", "watch")
   - Results filter in real-time

#### 2. **Filter by Category**
   - Scroll down to "Most Popular" section
   - Tap category tabs (All, electronics, jewelery, men's clothing, women's clothing)
   - Grid updates with filtered products

#### 3. **Add to Favorites**
   - Tap the heart icon on any product card
   - Heart fills and product is saved to favorites
   - Favorites persist even after app restart

#### 4. **View Product Details**
   - Tap on any product card
   - See full description, larger image, detailed rating
   - Adjust quantity with +/- buttons
   - Tap "Add to Cart"

#### 5. **Add to Cart**
   - From detail screen: adjust quantity and tap "Add to Cart"
   - From home screen: just tap the card to see details
   - Cart count badge appears in top-right corner
   - Cart items persist across app sessions

#### 6. **Category Icons**
   - Below the search bar are quick category shortcuts
   - Tap any icon to filter by that category
   - Works with the category filter tabs

## Project Architecture Overview

```
User Interface (Screens & Widgets)
           ↓
      BLoC/Cubit (State Management)
           ↓
      Services (API & Storage)
           ↓
    External APIs & Device Storage
```

## Key Technologies

| Component | Technology | Purpose |
|-----------|-----------|---------|
| State Management | BLoC/Cubit | Product filtering, cart, favorites |
| Navigation | GoRouter | Screen transitions |
| Networking | http | API requests |
| Storage | SharedPreferences | Cart & favorites persistence |
| Caching | CachedNetworkImage | Efficient image loading |

## File Organization

```
lib/
├── main.dart              ← App startup
├── bloc/                  ← Business logic
├── screens/               ← UI screens
├── widgets/               ← Reusable components
├── models/                ← Data structures
├── services/              ← API & storage
└── routes/                ← Navigation config
```

## Common Tasks

### To modify search behavior
→ Edit `lib/bloc/product_bloc.dart` - `_onSearchProducts` method

### To change product card layout
→ Edit `lib/widgets/product_card.dart`

### To add new API endpoints
→ Add methods to `lib/services/product_api_service.dart`

### To change color scheme
→ Edit `lib/main.dart` - ThemeData

### To add new screens
→ Create in `lib/screens/` and add route in `lib/main.dart`

## Troubleshooting

### "flutter: not found"
- Install Flutter SDK: https://flutter.dev/docs/get-started/install
- Add Flutter to PATH

### App crashes on startup
- Run `flutter clean`
- Run `flutter pub get`
- Run `flutter run` again

### Products not loading
- Check internet connection
- Verify API is accessible: https://fakestoreapi.com/products
- Check that package imports are correct

### Images not showing
- They load from the internet - ensure you have data/WiFi
- CachedNetworkImage has a placeholder while loading

## Next Steps

1. **Explore the code**: Check `IMPLEMENTATION_NOTES.md` for architecture decisions
2. **Run tests**: Set up widget and unit tests (recommended)
3. **Customize**: Change colors, add features, improve UX
4. **Deploy**: Build APK for Android or IPA for iOS

## Documentation Files

- **README.md** - Complete project documentation
- **IMPLEMENTATION_NOTES.md** - Architecture & design decisions
- **FILE_STRUCTURE.md** - Directory layout and file reference
- **QUICK_START.md** - This file!

---

**Questions?** Check the README.md or IMPLEMENTATION_NOTES.md for detailed information.

Happy coding! 🚀

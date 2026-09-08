# Product Listing App

A modern Flutter e-commerce application that fetches and displays products from the Fake Store API with a clean, user-friendly interface.

## Features

✅ **Product Listing** - Display products in a responsive 2-column grid layout  
✅ **Search Functionality** - Real-time search to filter products by title  
✅ **Category Filtering** - Filter products by category with intuitive UI  
✅ **Product Details** - View full product information on a dedicated detail screen  
✅ **Cart Management** - Add products to cart with quantity selection and persistence  
✅ **Favorites** - Mark products as favorites with persistent storage  
✅ **State Management** - Clean architecture using BLoC for products and Cubit for cart/favorites  
✅ **Error Handling** - Comprehensive error states with retry functionality  
✅ **Loading States** - Smooth loading indicators and empty state handling  
✅ **Local Storage** - Persist cart and favorites using SharedPreferences  

## UI Design

The app matches the provided reference design with:
- Header section with greeting and notification icons
- Search bar with filter button
- Category icon grid for quick filtering
- "Most Popular" section with category tabs
- Product cards showing image, title, rating, and price
- Favorite/heart icons on each product card
- Clean, modern design with consistent spacing and typography

## Project Structure

```
lib/
├── main.dart                 # App entry point with BLoC setup
├── bloc/                     # State management
│   ├── product_bloc.dart     # BLoC for product data and filtering
│   ├── product_event.dart    # Events for ProductBloc
│   ├── product_state.dart    # States for ProductBloc
│   ├── cart_cubit.dart       # Cubit for cart management
│   ├── favorites_cubit.dart  # Cubit for favorites
├── models/                   # Data models
│   ├── product.dart          # Product model with JSON serialization
│   ├── cart_item.dart        # Cart item model
├── screens/                  # UI screens
│   ├── home_screen.dart      # Main product listing screen
│   ├── product_detail_screen.dart  # Product detail page
├── widgets/                  # Reusable widgets
│   ├── product_card.dart     # Product card component
│   ├── search_bar.dart       # Search bar widget
│   ├── category_filter.dart  # Category filter tabs
│   ├── category_icon_grid.dart # Category icons grid
├── services/                 # External services
│   ├── product_api_service.dart    # API calls to Fake Store
│   ├── local_storage_service.dart  # Local storage operations
└── routes/                   # Navigation
    └── app_router.dart       # GoRouter configuration
```

## API Used

**Fake Store API** - `https://fakestoreapi.com`

Endpoints used:
- `GET /products` - Fetch all products
- `GET /products/:id` - Fetch specific product
- `GET /products/category/:category` - Fetch products by category
- `GET /products/categories` - Fetch all available categories

## Dependencies

- **flutter_bloc**: ^8.1.3 - State management
- **bloc**: ^8.1.1 - BLoC library
- **equatable**: ^2.0.5 - Value equality
- **go_router**: ^13.0.0 - Navigation and routing
- **http**: ^1.1.0 - HTTP requests
- **shared_preferences**: ^2.2.2 - Local storage
- **cached_network_image**: ^3.3.0 - Image caching and loading

## State Management Rationale

**Why BLoC + Cubit?**

- **BLoC for ProductBloc**: Complex business logic involving multiple events and states (fetching, filtering, searching). BLoC is ideal for handling these transformations.
- **Cubit for Cart & Favorites**: Simpler state management (just adding/removing items and persisting). Cubit is more lightweight and perfect for these use cases.
- Both rely on `equatable` for proper state comparison and hot reload support.

## Technical Highlights

### Null Safety
- Full null safety implementation throughout the codebase
- Proper use of nullable types with null checking

### Error Handling
- Try-catch blocks in API service layer
- Error states in BLoC with user-friendly messages
- Retry functionality on error screens

### Code Organization
- Clear separation of concerns: UI, business logic, data, and services
- Reusable widget components
- Index files for clean imports
- Meaningful names for all variables and functions

### Widget Composition
- Small, focused widgets
- Proper use of StatelessWidget and StatefulWidget
- Responsive layouts with GridView and SingleChildScrollView

## Features Implemented

### Core Requirements
✅ Fetch products from Fake Store API  
✅ 2-column product grid with images, titles, ratings, prices  
✅ Search bar to filter products by title  
✅ Category filter tabs  
✅ Product detail screen with full information  
✅ Navigation between screens  
✅ Add to cart functionality with state management  
✅ Favorite/heart toggle (non-functional UI)  
✅ Loading, error, and empty states  



This project is for demonstration purposes.

---

**Developer Notes**: This is a clean, well-organized solution focusing on code quality and proper architecture over pixel-perfect UI. The app demonstrates proper use of Flutter best practices, state management, and API integration.

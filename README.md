# MagiKart-Grocery-App 🛒
*A Flutter Portfolio Project*

**MagiKart** is a modern grocery shopping application built with Flutter that demonstrates clean architecture, efficient state management, and intuitive UI design. This project showcases implementation of a complete e-commerce solution with user authentication, product catalog, and shopping cart functionality.

---

## 👨‍💻 About the Project

This app allows users to:
- Log in to their account with email and password
- Browse through a variety of grocery products
- Add items to their shopping cart
- Manage product quantities in real-time
- View order subtotals with automatic calculations
- Experience a consistent, themed UI across all screens

It demonstrates my ability to create production-ready mobile applications with focus on performance, user experience, and maintainability.

---

## 🔧 Technologies & Packages Used

- **Flutter** — Primary framework for cross-platform development
- [`provider`](https://pub.dev/packages/provider) — For efficient state management
- [`sqflite`](https://pub.dev/packages/sqflite) — For local database operations
- [`cached_network_image`](https://pub.dev/packages/cached_network_image) — For loading and caching product images
- [`badges`](https://pub.dev/packages/badges) — For cart indicator on the app bar

---

## 📁 Project Structure

```
lib/
├── db/                    # Database models and helper
│   ├── cart_model.dart    # Cart data model
│   └── db_helper.dart     # SQLite database operations
├── list/                  # Product data
│   └── grocery_list.dart  # Sample grocery product data
├── providers/             # State management
│   └── cart_provider.dart # Cart state provider
├── screens/               # App screens
│   ├── cart.dart          # Shopping cart screen
│   ├── home_screen.dart   # Main product listing screen  
│   └── login_page.dart    # Authentication screen
├── widgets/               # Reusable UI components
├── app_theme.dart         # Theme configuration
└── main.dart              # App entry point
```

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (2.0 or higher)
- Dart SDK (2.12 or higher)
- Android Studio / VS Code
- Android/iOS emulator or physical device

### Installation Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/magikart-grocery-app.git
   ```
2. Navigate to the project directory:
   ```bash
   cd magikart-grocery-app
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

---

## 🎯 What This Project Demonstrates

- 🔐 User authentication system with validation
- 📱 Responsive and intuitive UI design
- 💾 Local data persistence with SQLite
- 🧩 Reusable components and clean architecture
- 🔄 State management using Provider pattern
- 🛒 Complete shopping cart functionality
- 🎨 Consistent theming across the application

---

## 🛠️ Built With

- [Flutter](https://flutter.dev/) - UI toolkit for building natively compiled applications
- [Provider](https://pub.dev/packages/provider) - State management solution
- [SQLite](https://pub.dev/packages/sqflite) - Local database for cart persistence
- [Cached Network Image](https://pub.dev/packages/cached_network_image) - Loading and caching network images
- [Badges](https://pub.dev/packages/badges) - Badge implementation for cart indicator

---

## 🙋‍♂️ About Me

Hi! I'm Hamza, a Flutter developer passionate about building intuitive mobile apps with clean architecture and beautiful UIs.
This app is part of my developer portfolio.

📧 Email: hamzabutthb553.hb@gmail.com

💼 LinkedIn: linkedin.com/in/hamza-flutterdev

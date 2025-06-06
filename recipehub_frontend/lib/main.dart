import 'package:flutter/material.dart';

// PRIMARY, SECONDARY, ACCENT colors from requirements
const Color kPrimaryColor = Color(0xFFFF7043); // deep orange
const Color kSecondaryColor = Color(0xFFFFF3E0); // light peach
const Color kAccentColor = Color(0xFF388E3C); // green

// Dark Theme equivalents: high contrast, good legibility
const Color kPrimaryDarkColor = Color(0xFFFFA270);   // lighter orange for primary elements on dark
const Color kSecondaryDarkColor = Color(0xFF222325); // dark grey for backgrounds
const Color kSurfaceDarkColor = Color(0xFF292C31);   // for cards, surfaces
const Color kOnPrimaryDark = Color(0xFF222325);      // text on primary
const Color kAccentDarkColor = Color(0xFF6DD47E);    // lighter green accent

void main() {
  runApp(const RecipeHubApp());
}

// PUBLIC_INTERFACE
class RecipeHubApp extends StatelessWidget {
  const RecipeHubApp({super.key});

  // PUBLIC_INTERFACE
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecipeHub',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.transparent, // for gradient
        colorScheme: ColorScheme.light(
          primary: kPrimaryColor,
          secondary: kAccentColor,
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: kAccentColor,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: Colors.grey,
        ),
        cardColor: Colors.white,
        iconTheme: const IconThemeData(color: kAccentColor),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: kPrimaryDarkColor,
        scaffoldBackgroundColor: Colors.transparent, // for gradient
        colorScheme: ColorScheme.dark(
          primary: kPrimaryDarkColor,
          secondary: kAccentDarkColor,
          surface: kSurfaceDarkColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: kAccentDarkColor,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: kSurfaceDarkColor,
          selectedItemColor: kPrimaryDarkColor,
          unselectedItemColor: Colors.grey[400],
        ),
        cardColor: kSurfaceDarkColor,
        iconTheme: const IconThemeData(color: kAccentDarkColor),
      ),
      themeMode: ThemeMode.system, // Responds to system setting by default
      home: const RecipeHubHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// The main container (stub) where feature screens would be swapped in as needed
// PUBLIC_INTERFACE
class RecipeHubHomePage extends StatelessWidget {
  const RecipeHubHomePage({super.key});

  // PUBLIC_INTERFACE
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final bool isDark = brightness == Brightness.dark;
    final ColorScheme colorScheme = theme.colorScheme;

    // Gradient that adapts to theme for background
    final Gradient backgroundGradient = isDark
        ? LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              kPrimaryDarkColor.withAlpha((0.85 * 255).toInt()),
              kSecondaryDarkColor.withAlpha((0.95 * 255).toInt()),
              kAccentDarkColor.withAlpha((0.85 * 255).toInt()),
            ],
            stops: const [0.05, 0.7, 1.0],
          )
        : LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              kPrimaryColor.withAlpha((0.90 * 255).toInt()),
              kSecondaryColor.withAlpha((0.90 * 255).toInt()),
              kAccentColor.withAlpha((0.70 * 255).toInt()),
            ],
            stops: const [0.03, 0.7, 1],
          );

    return Stack(
      children: [
        // Gradient background container covers the whole screen
        Container(
          decoration: BoxDecoration(
            gradient: backgroundGradient,
          ),
        ),
        // Scaffold is transparent so gradient shows behind all content
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('RecipeHub'),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Center(
            child: Text(
              'Welcome to RecipeHub!',
              style: TextStyle(
                fontSize: 24,
                color: isDark
                    ? Colors.white
                    : colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            // Pages not implemented; icons shown for concept
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorites'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add), label: 'Add Recipe'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'
              ),
            ],
            currentIndex: 0, // Highlight Home for now
            onTap: (_) {},
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ],
    );
  }
}

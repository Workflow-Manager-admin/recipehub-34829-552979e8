import 'package:flutter/material.dart';

// PUBLIC_INTERFACE
void main() {
  /// Entry point for the RecipeHub application.
  runApp(const RecipeHubApp());
}

/// RecipeHubApp is the root widget for the RecipeHub application.
/// Applies a light theme using the specified color scheme.
class RecipeHubApp extends StatelessWidget {
  const RecipeHubApp({super.key});

  /// PUBLIC_INTERFACE
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecipeHub',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFFFF7043),
        scaffoldBackgroundColor: const Color(0xFFFFF3E0),
        colorScheme: ColorScheme.light(
          primary: const Color(0xFFFF7043),
          secondary: const Color(0xFFFFF3E0),
          tertiary: const Color(0xFF388E3C),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFF7043),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF388E3C),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFFFFF3E0),
          selectedItemColor: Color(0xFFFF7043),
          unselectedItemColor: Color(0xFF888888),
          showUnselectedLabels: true,
        ),
        cardColor: Colors.white,
      ),
      home: const RecipeHubMainContainer(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// Enum for navigation tabs.
enum RecipeHubTab { home, favorites, add, profile }

/// RecipeHubMainContainer configures the layout as described,
/// including search bar, carousel, category cards, and bottom tab bar.
/// It uses an [IndexedStack] to maintain the state of each tab's content.
class RecipeHubMainContainer extends StatefulWidget {
  const RecipeHubMainContainer({super.key});

  /// PUBLIC_INTERFACE
  @override
  State<RecipeHubMainContainer> createState() => _RecipeHubMainContainerState();
}

class _RecipeHubMainContainerState extends State<RecipeHubMainContainer> {
  RecipeHubTab _currentTab = RecipeHubTab.home;

  // Switch between the main screens for the navigation tabs.
  void _onTabSelected(int index) {
    setState(() {
      _currentTab = RecipeHubTab.values[index];
    });
  }

  /// PUBLIC_INTERFACE
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentTab.index,
        children: const [
          _HomeScreen(),
          _FavoritesScreen(),
          _AddRecipeScreen(),
          _ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab.index,
        onTap: _onTabSelected,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Add Recipe',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

/// HomeScreen displays the discovery UI: search bar, carousel, and categories.
class _HomeScreen extends StatelessWidget {
  const _HomeScreen();

  /// PUBLIC_INTERFACE
  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color accent = Theme.of(context).colorScheme.tertiary;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search recipes, ingredients, or categories',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 4),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            // Featured Carousel (Placeholder)
            SizedBox(
              height: 180,
              child: PageView(
                controller: PageController(viewportFraction: 0.9),
                children: List.generate(
                  3,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        color: primary.withAlpha(((0.15 + .1 * index) * 255).toInt()),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            // Placeholder for images
                            Icon(
                              Icons.fastfood,
                              size: 80,
                              color: accent.withAlpha((0.2 * 255).toInt()),
                            ),
                            Positioned(
                              left: 16,
                              top: 16,
                              child: Text(
                                'Featured Recipe ${index + 1}',
                                style: TextStyle(
                                  color: primary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Category Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Categories',
                style: TextStyle(
                  color: accent,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 110,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: const [
                  _CategoryCard(
                    icon: Icons.local_pizza_outlined,
                    label: 'Pizza',
                    color: Color(0xFFFFA726),
                  ),
                  _CategoryCard(
                    icon: Icons.rice_bowl_outlined,
                    label: 'Asian',
                    color: Color(0xFF42A5F5),
                  ),
                  _CategoryCard(
                    icon: Icons.lunch_dining,
                    label: 'Healthy',
                    color: Color(0xFF66BB6A),
                  ),
                  _CategoryCard(
                    icon: Icons.icecream_outlined,
                    label: 'Desserts',
                    color: Color(0xFFAB47BC),
                  ),
                  _CategoryCard(
                    icon: Icons.local_cafe_outlined,
                    label: 'Drinks',
                    color: Color(0xFFD84315),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Placeholder for trending/latest recipes section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Trending Recipes',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Trending recipes list (future extensibility)
            ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemCount: 3,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, i) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                elevation: 1,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: accent.withAlpha((0.2 * 255).toInt()),
                    child: Icon(Icons.restaurant_menu_outlined, color: accent),
                  ),
                  title: Text('Recipe ${i + 1}'),
                  subtitle: Text('Short description or tags...'),
                  trailing: Icon(Icons.chevron_right, color: primary),
                  onTap: () {
                    // In the future, navigate to recipe detail.
                  },
                ),
              ),
            ),
            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
}

/// CategoryCard widget for a recipe category in horizontal list.
class _CategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _CategoryCard(
      {required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: GestureDetector(
        onTap: () {
          // In the future, filter/browse recipes by category.
        },
        child: Container(
          width: 90,
          decoration: BoxDecoration(
            color: color.withAlpha((.1 * 255).toInt()),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: color.withAlpha((.33 * 255).toInt()), width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 34),
              const SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(fontWeight: FontWeight.w600, color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// FavoritesScreen displays saved recipes.
/// Extensible for favorites management.
class _FavoritesScreen extends StatelessWidget {
  const _FavoritesScreen();

  /// PUBLIC_INTERFACE
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Your favorite recipes will appear here!',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );
  }
}

/// AddRecipeScreen for users to add a new recipe.
/// Extensible for recipe creation UI.
class _AddRecipeScreen extends StatelessWidget {
  const _AddRecipeScreen();

  /// PUBLIC_INTERFACE
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Create your own recipe!',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );
  }
}

/// ProfileScreen for user profile & recipe sharing options.
/// Extensible for user account management and shared recipes.
class _ProfileScreen extends StatelessWidget {
  const _ProfileScreen();

  /// PUBLIC_INTERFACE
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Profile and sharing options coming soon!',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );
  }
}

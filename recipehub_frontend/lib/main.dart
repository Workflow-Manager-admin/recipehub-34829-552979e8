import 'package:flutter/material.dart';

// PUBLIC_INTERFACE
void main() {
  runApp(const RecipeHubApp());
}

// PUBLIC_INTERFACE
class RecipeHubApp extends StatelessWidget {
  const RecipeHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecipeHub',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF7043)),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFFF3E0),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black87,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          shadowColor: Colors.black26,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFFF7043), brightness: Brightness.dark),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          color: Colors.grey[850],
          surfaceTintColor: Colors.grey,
          shadowColor: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

// Mock recipe data model
class Recipe {
  final String name;
  final String category;
  final String imageUrl;
  final String description;

  const Recipe({
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.description,
  });
}

// Example list of mock recipes
final List<Recipe> mockRecipes = [
  Recipe(
    name: "Classic Pancakes",
    category: "Breakfast",
    imageUrl: "https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=400&q=80",
    description: "Fluffy, golden pancakes for a perfect start.",
  ),
  Recipe(
    name: "Caprese Salad",
    category: "Salad",
    imageUrl: "https://images.unsplash.com/photo-1464306076886-debca5e8a6b0?auto=format&fit=crop&w=400&q=80",
    description: "Fresh mozzarella, tomatoes and basil.",
  ),
  Recipe(
    name: "Spicy Ramen",
    category: "Noodles",
    imageUrl: "https://images.unsplash.com/photo-1502741338009-cac2772e18bc?auto=format&fit=crop&w=400&q=80",
    description: "A bowl of spicy, savory ramen noodles.",
  ),
  Recipe(
    name: "Berry Smoothie",
    category: "Drinks",
    imageUrl: "https://images.unsplash.com/photo-1519864600265-abb224a5f74c?auto=format&fit=crop&w=400&q=80",
    description: "A refreshing blend of mixed berries.",
  ),
  Recipe(
    name: "Chocolate Cake",
    category: "Dessert",
    imageUrl: "https://images.unsplash.com/photo-1542444459-db68ac1c90b9?auto=format&fit=crop&w=400&q=80",
    description: "Rich, moist, and chocolatey.",
  ),
  Recipe(
    name: "Avocado Toast",
    category: "Snack",
    imageUrl: "https://images.unsplash.com/photo-1551183053-bf91a1d81141?auto=format&fit=crop&w=400&q=80",
    description: "Whole grain bread with smashed avocado.",
  ),
];

// PUBLIC_INTERFACE
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Responsively determine number of columns based on width
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "RecipeHub",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFFF7043)
          ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = constraints.maxWidth < 600
              ? 2
              : (constraints.maxWidth < 900 ? 3 : 4);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              itemCount: mockRecipes.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final recipe = mockRecipes[index];
                return RecipeCard(recipe: recipe);
              },
            ),
          );
        }
      ),
      bottomNavigationBar: const RecipeHubBottomNav(),
    );
  }
}

// PUBLIC_INTERFACE
class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.brightness == Brightness.dark ? Colors.white : Colors.black87;

    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // In future: Navigate to details
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Tapped on '${recipe.name}'"))
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Recipe image
            AspectRatio(
              aspectRatio: 4 / 3,
              child: recipe.imageUrl.startsWith('http')
                  ? Image.network(
                      recipe.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.image_not_supported, size: 48),
                          ),
                    )
                  : Image.asset(
                      recipe.imageUrl,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                recipe.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: textColor
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
              child: Text(
                recipe.category,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: const Color(0xFF388E3C),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 6),
              child: Text(
                recipe.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: textColor.withAlpha((0.75 * 255).toInt()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// PUBLIC_INTERFACE
class RecipeHubBottomNav extends StatelessWidget {
  const RecipeHubBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    // Defaults to Home tab (index 0)
    return BottomNavigationBar(
      currentIndex: 0,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: const Color(0xFFFF7043),
      unselectedItemColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[500]
          : Colors.black54,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: "Favorites"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline),
          label: "Add"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile"
        ),
      ],
      onTap: (index) {
        // TODO: Implement navigation on tap
        if (index != 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Navigation is not yet implemented.'))
          );
        }
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).cardColor,
      elevation: 8,
    );
  }
}

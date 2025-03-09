import 'package:flutter/material.dart';
import 'package:rentapp/core/assets/app_images.dart';

class CategoryList extends StatefulWidget {
  final Function(String) onCategorySelected;

  const CategoryList({super.key, required this.onCategorySelected});

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  String? selectedCategory; // ✅ Stores selected category (null = all cars)

  final List<Map<String, String>> categories = [
    {"image": AppImages.mercedesLogo, "name": "Mercedes"},
    {"image": AppImages.rollsroyceLogo, "name": "Rolls Royce"},
    {"image": AppImages.bmwLogo, "name": "BMW"},
    {"image": AppImages.audiLogo, "name": "Audi"},
    {"image": AppImages.toyotaLogo, "name": "Toyota"},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children:
            categories.map((category) {
              final isSelected = category["name"] == selectedCategory;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCategory =
                        isSelected
                            ? null
                            : category["name"]!; // ✅ Toggle selection
                  });
                  widget.onCategorySelected(
                    selectedCategory ?? "",
                  ); // ✅ Send empty string if deselected
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Container(
                        height: isSelected ? 65 : 60,
                        width: isSelected ? 65 : 60,
                        decoration: BoxDecoration(
                          color: Colors.white, // ✅ Highlight selection
                          border: Border.all(
                            color: isSelected ? Colors.black : Colors.white,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(category["image"]!),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        category["name"]!,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: Colors.black, // ✅ Highlight text
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}

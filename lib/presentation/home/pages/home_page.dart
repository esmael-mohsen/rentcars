import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentapp/core/assets/app_images.dart';
import 'package:rentapp/presentation/home/widgets/car_cart.dart';
import 'package:rentapp/presentation/home/widgets/catigory_list.dart';
import 'package:rentapp/presentation/home/bloc/car_bloc.dart';
import 'package:rentapp/presentation/home/bloc/car_state.dart';
import 'package:rentapp/presentation/home/bloc/car_events.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = ""; // ✅ Stores search text
  String selectedCategory = ""; // ✅ Stores selected category

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Container(
          margin: const EdgeInsets.all(10.0),
          child: Image.asset(AppImages.logo, scale: 2.5),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      cursorColor: Colors.black,
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                        context.read<CarBloc>().add(
                          SearchCars(name: value, category: selectedCategory),
                        );
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.grey[200],
                        filled: true,
                        hintText: "Search Cars...",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    CategoryList(
                      onCategorySelected: (category) {
                        setState(() {
                          selectedCategory = category;
                        });
                        context.read<CarBloc>().add(
                          SearchCars(name: searchQuery, category: category),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // ✅ Wrap SliverGrid with BlocBuilder
            BlocBuilder<CarBloc, CarState>(
              builder: (context, state) {
                if (state is CarLoading) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Center(child: CircularProgressIndicator(color: Colors.black,)),
                      ),
                    ),
                  );
                } else if (state is CarError) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          "Error: ${state.message}",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  );
                } else if (state is CarLoaded) {
                  return SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => LayoutBuilder(
                          builder: (context, constraints) {
                            return SizedBox(
                              height: 250,
                              child: CarCart(
                                car: state.cars[index],
                              ), // ✅ Use filtered cars
                            );
                          },
                        ),
                        childCount: state.cars.length,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                    ),
                  );
                }
                return SliverToBoxAdapter(); // Empty state
              },
            ),
          ],
        ),
      ),
    );
  }
}

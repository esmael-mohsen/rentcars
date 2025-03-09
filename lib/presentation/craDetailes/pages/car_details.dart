import 'package:flutter/material.dart';
import 'package:rentapp/core/assets/app_images.dart';
import 'package:rentapp/data/models/car_model.dart';
import 'package:rentapp/presentation/craDetailes/widgets/car_cart.dart';
import 'package:rentapp/presentation/craDetailes/widgets/more_card.dart';
import 'package:rentapp/presentation/mapsDetails/pages/maps_details_page.dart';

class CarDetailsPage extends StatefulWidget {
  final CarModel car;

  const CarDetailsPage({super.key, required this.car});

  @override
  State<CarDetailsPage> createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 1, end: 1.5).animate(_controller!)
      ..addListener(() {
        setState(() {});
      });
    _controller!.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller!.forward();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InfoCarCart(car: widget.car),
            SizedBox(height: context.screenHeight(0.02)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: _buildInfoRow(context),
            ),
            SizedBox(height: context.screenHeight(0.02)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: _buildMoreCards(),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: () => Navigator.pop(context),
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Theme.of(context).iconTheme.color,
              size: 20,
            ),
          ),
        ),
      ),
      title: Text(
        widget.car.model,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 19,
          color: Colors.black87,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildInfoRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _buildUserCard(context)),
        SizedBox(width: context.screenWidth(0.05)),
        Expanded(child: _buildMapCard(context)),
      ],
    );
  }

  Widget _buildUserCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _boxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(AppImages.user),
          ),
          const SizedBox(height: 10),
          const Text(
            'Jane Cooper',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 5),
          const Text(
            '\$4,253',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildMapCard(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MapsDetailsPage(car: widget.car)),
        );
      },
      child: Container(
        height: context.screenWidth(0.45),
        decoration: _boxDecoration(),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Transform.scale(
            scale: _animation!.value,
            child: Image.asset(AppImages.maps, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

  Widget _buildMoreCards() {
    return Column(
      children: List.generate(
        3,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: MoreCard(car: widget.car),
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 5,
          spreadRadius: 2,
          offset: Offset(0, 3),
        ),
      ],
    );
  }
}

// ✅ Move this extension to `utils.dart` for reusability.
extension ScreenSize on BuildContext {
  double screenHeight(double ratio) => MediaQuery.of(this).size.height * ratio;
  double screenWidth(double ratio) => MediaQuery.of(this).size.width * ratio;
}

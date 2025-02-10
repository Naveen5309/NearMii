import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VIP Membership Dialog',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("VIP Membership Dialog")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const VIPMembershipDialog(),
            );
          },
          child: const Text("Show Dialog"),
        ),
      ),
    );
  }
}

class VIPMembershipDialog extends StatelessWidget {
  const VIPMembershipDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: SvgPicture.asset(
                  Assets.icCloseCircle,
                  colorFilter: const ColorFilter.mode(
                    AppColor.primary,
                    BlendMode.srcIn,
                  ),
                ),
                onPressed: () => back(context),
              ),
            ),
            SvgPicture.asset(Assets.iconVip),
            const SizedBox(height: 10),
            const Text(
              "VIP Membership",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Lorem ipsum dolor sit amet consectetur. Dui etiam tempus scelerisque donec.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.green.shade700,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Row(
                    children: [
                      AppText(
                        text: "\$120",
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      AppText(
                        text: " /month",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: List.generate(
                      4,
                      (index) => const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Icon(Icons.check, color: Colors.white),
                            SizedBox(width: 5),
                            AppText(
                                text: "Lorem ipsum dolor sit amet consectetur.",
                                fontSize: 12,
                                color: AppColor.primary),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text("Buy Now"),
            ),
          ],
        ),
      ),
    );
  }
}

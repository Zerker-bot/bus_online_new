import "package:bus_online/components/customer_panel.dart";
import "package:bus_online/components/driver_panel.dart";
import "package:bus_online/components/reverse_border_radius.dart";
import "package:bus_online/controllers/dang_ki_controller.dart";
import "package:bus_online/pages/dang_ki/danh_sach_dang_ki.dart";
import "package:bus_online/pages/personal.dart";
import "package:bus_online/services/auth_service.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:heroicons/heroicons.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int bottomSelectedIndex = 0;
  final AuthService auth = AuthService();

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  void onPageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void onBottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(
        index,
        duration: Duration(microseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black12, spreadRadius: 5, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: NavigationBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            indicatorColor: Colors.transparent,
            destinations: [
              NavigationDestination(
                icon: HeroIcon(
                  HeroIcons.home,
                  style:
                      bottomSelectedIndex == 0
                          ? HeroIconStyle.solid
                          : HeroIconStyle.outline,
                ),
                label: 'Home',
              ),
              if(!auth.isDriver()) NavigationDestination(
                icon: HeroIcon(
                  HeroIcons.ticket,
                  style:
                      bottomSelectedIndex == 1
                          ? HeroIconStyle.solid
                          : HeroIconStyle.outline,
                ),
                label: 'Vé',
              ),
              NavigationDestination(
                icon: HeroIcon(
                  HeroIcons.user,
                  style:
                      bottomSelectedIndex == 2
                          ? HeroIconStyle.solid
                          : HeroIconStyle.outline,
                ),
                label: 'Cá nhân',
              ),
            ],
            selectedIndex: bottomSelectedIndex,
            onDestinationSelected: (int index) {
              onBottomTapped(index);
            },
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          ),
        ),
      ),
      body: SafeArea(
        child: PageView(
          controller: pageController,
          onPageChanged: (index) {
            onPageChanged(index);
          },
          children: <Widget>[
            HomePage(),
            if(!auth.isDriver()) DanhSachDangKi(),
            PersonalPage(),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final AuthService auth = AuthService();
  final DangKiVeController controller = Get.put(DangKiVeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
            left: 0,
            right: 0,
            child: ReverseBorderRadius(
              radius: 50,
              color: Colors.white,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                  ),
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: MediaQuery.of(context).size.width * 0.075,
            right: MediaQuery.of(context).size.width * 0.075,
            child: Text(
              'Xin chào,\n${auth.getName()}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
          Positioned.fill(
            top: 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: auth.isDriver() ? DriverPanel() : CustomerPanel(),
            ),
          ),
        ],
      ),
    );
  }
}

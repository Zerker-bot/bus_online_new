import "package:bus_online/pages/personal.dart";
// import "package:bus_online/pages/service.dart";
import "package:bus_online/pages/message.dart";
// import "package:bus_online/services/auth_service.dart";
import 'package:bus_online/components/service_item.dart';
import "package:bus_online/services/auth_service.dart";
import 'package:bus_online/storage/user_storage.dart';
import "package:flutter/material.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int bottomSelectedIndex = 0;

  AuthService auth = AuthService();

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

  String getUserName() {
    return auth.getName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: NavigationBar(
            surfaceTintColor: Colors.white,
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
              NavigationDestination(
                icon: Icon(Icons.notifications_none),
                label: 'Thông báo',
              ),
              // NavigationDestination(
              //   icon: Icon(Icons.segment_rounded),
              //   label: 'Dịch vụ',
              // ),
              NavigationDestination(
                icon: Icon(Icons.perm_identity),
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
            HomePage(userName: getUserName()),
            MessagePage(),
            // ServicePage(),
            PersonalPage(),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key, this.userName});

  final String? userName;

  final AuthService auth = AuthService();

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
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
              ),
            ),
          ),
          Positioned(
            top: 220,
            left: MediaQuery.of(context).size.width * 0.075,
            right: MediaQuery.of(context).size.width * 0.075,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: MediaQuery.of(context).size.width * 0.075,
            right: MediaQuery.of(context).size.width * 0.075,
            child: Text(
              'Xin chào,\n$userName',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 135,
            left: MediaQuery.of(context).size.width * 0.075,
            right: MediaQuery.of(context).size.width * 0.075,
            child: Text(
              'Bạn muốn đi đâu?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 160,
            left: MediaQuery.of(context).size.width * 0.075,
            right: MediaQuery.of(context).size.width * 0.075,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Tìm kiếm địa điểm...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 350,
            left: 0,
            right: 0, 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Dịch vụ',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (auth.getRole() == "driver"
                          ? const Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              ServiceItem(
                                logoPath: 'assets/images/leather-jacket-1.png',
                                title: 'Dashboard',
                                routePath: '/dashboard',
                                primary: true,
                              ),
                              ServiceItem(
                                logoPath: 'assets/images/leather-jacket-1.png',
                                title: 'Xem lịch trình xe bus',
                                routePath: '/tuyen',
                              ),
                            ],
                          )
                          : const Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              ServiceItem(
                                logoPath: 'assets/images/leather-jacket-1.png',
                                title: 'Đăng kí chuyến xe',
                                routePath: '/danh-sach-dang-ki',
                                primary: true,
                              ),
                              ServiceItem(
                                logoPath: 'assets/images/leather-jacket-1.png',
                                title: 'Xem lịch trình xe bus',
                                routePath: '/tuyen',
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


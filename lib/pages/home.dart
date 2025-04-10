import "package:bus_online/pages/personal.dart";
import "package:bus_online/pages/service.dart";
import "package:bus_online/pages/message.dart";
import "package:bus_online/services/auth_service.dart";
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
      pageController.animateToPage(index, duration: Duration(microseconds: 500), curve: Curves.ease);
    });
  }

  String getUserName() {
    final user = auth.getUser();
    if ( user == null ) return "";
    final metadata = user.userMetadata;
    if ( metadata == null ) return "";
    return metadata["name"];
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
              NavigationDestination(
                icon: Icon(Icons.segment_rounded),
                label: 'Dịch vụ',
              ),
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
          children: 
              <Widget>[
                HomePage(userName: getUserName(),),
                MessagePage(),
                ServicePage(),
                PersonalPage(),
              ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key, this.userName});

  final String? userName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Xin chào bạn!',
            style: TextStyle(color: Color(0xFF626262), fontSize: 18),
          ),
          Text(
            '$userName',
            style: const TextStyle(
              color: Color(0xFFF9A000),
              fontSize: 27,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 260,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              child: Image.network(
                'https://cdn1.img.sputniknews.vn/img/07e6/02/03/13560397_84:0:1417:1000_1920x0_80_0_0_c74c0dc5e7acbe1783ca22be16fbbbef.jpg',
                fit: BoxFit.fitHeight,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) {
                    return child;
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

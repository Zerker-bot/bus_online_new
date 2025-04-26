import "package:bus_online/components/custom_button.dart";
import "package:bus_online/components/full_width_button.dart";
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
              NavigationDestination(
                icon: HeroIcon(
                  HeroIcons.ticket,
                  style:
                      bottomSelectedIndex == 1
                          ? HeroIconStyle.solid
                          : HeroIconStyle.outline,
                ),
                label: 'Vé',
              ),
              // NavigationDestination(
              //   icon: Icon(Icons.segment_rounded),
              //   label: 'Dịch vụ',
              // ),
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
            DanhSachDangKi(),
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
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 10,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Đặt vé ngay",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        height: 70,
                        width: double.infinity,
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
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xFFd7d9fc),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: HeroIcon(
                                    HeroIcons.map,
                                    style: HeroIconStyle.solid,
                                    size: 20,
                                    color: Color(0xFF1320ed),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Tuyến',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    width: 200,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Obx(
                                      () => DropdownMenu(
                                        width: 200,
                                        menuStyle: MenuStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                                Colors.white,
                                              ),
                                        ),
                                        controller:
                                            controller.tuyenTextController,
                                        dropdownMenuEntries:
                                            controller.listOfTuyen.map((
                                              element,
                                            ) {
                                              return DropdownMenuEntry(
                                                value: element,
                                                label: element.tenTuyen,
                                              );
                                            }).toList(),
                                        onSelected: controller.setTuyen,
                                        hintText: "Chọn tuyến đường",
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w800,
                                        ),
                                        trailingIcon: SizedBox.shrink(),
                                        inputDecorationTheme:
                                            const InputDecorationTheme(
                                              constraints: BoxConstraints(
                                                maxHeight: 20,
                                              ),
                                              isDense: true,
                                              border: InputBorder.none,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 70,
                        width: double.infinity,
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
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xFFe8fcff),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: HeroIcon(
                                    HeroIcons.paperAirplane,
                                    style: HeroIconStyle.solid,
                                    size: 20,
                                    color: Color(0xFF6ec9e3),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Trạm đi',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    width: 200,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Obx(
                                      () => DropdownMenu(
                                        width: 200,
                                        menuStyle: MenuStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                                Colors.white,
                                              ),
                                        ),
                                        controller:
                                            controller.tramDiTextController,
                                        dropdownMenuEntries:
                                            controller.listOfTram.map((
                                              element,
                                            ) {
                                              return DropdownMenuEntry(
                                                value: element,
                                                label: element.tenTram,
                                              );
                                            }).toList(),
                                        onSelected: controller.setTramDi,
                                        hintText: "Chọn trạm đi",
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w800,
                                        ),
                                        trailingIcon: SizedBox.shrink(),
                                        inputDecorationTheme:
                                            const InputDecorationTheme(
                                              constraints: BoxConstraints(
                                                maxHeight: 20,
                                              ),
                                              isDense: true,
                                              border: InputBorder.none,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 70,
                        width: double.infinity,
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
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xFFfcf0ff),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: HeroIcon(
                                    HeroIcons.mapPin,
                                    style: HeroIconStyle.solid,
                                    size: 20,
                                    color: Color(0xFFb48feb),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Trạm đến',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    width: 200,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Obx(
                                      () => DropdownMenu(
                                        width: 200,
                                        menuStyle: MenuStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                                Colors.white,
                                              ),
                                        ),
                                        controller:
                                            controller.tramDenTextController,
                                        dropdownMenuEntries:
                                            controller.listOfTram.map((
                                              element,
                                            ) {
                                              return DropdownMenuEntry(
                                                value: element,
                                                label: element.tenTram,
                                              );
                                            }).toList(),
                                        onSelected: controller.setTramDen,
                                        hintText: "Chọn trạm đến",
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w800,
                                        ),
                                        trailingIcon: SizedBox.shrink(),
                                        inputDecorationTheme:
                                            const InputDecorationTheme(
                                              constraints: BoxConstraints(
                                                maxHeight: 20,
                                              ),
                                              isDense: true,
                                              border: InputBorder.none,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
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
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFf4f2fb),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Icon(
                                        Icons.directions_walk,
                                        color: Color(0xFF8495e2),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Số lượng',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          CustomButton(
                                            onPressed: () {
                                              controller
                                                  .decreaseNumberOfTicket();
                                            },
                                            width: 27,
                                            shadow: BoxShadow(),
                                            padding: EdgeInsets.all(5),
                                            borderRadius: Radius.circular(100),
                                            child: const Icon(
                                              Icons.remove,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Obx(
                                            () => Text(
                                              '${controller.numberOfTicket.value}',
                                              style: const TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          CustomButton(
                                            onPressed: () {
                                              controller
                                                  .increaseNumberOfTicket();
                                            },
                                            width: 27,
                                            shadow: BoxShadow(),
                                            padding: EdgeInsets.all(5),
                                            borderRadius: Radius.circular(100),
                                            child: const Icon(
                                              Icons.add,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFfdf1f1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: HeroIcon(
                                        HeroIcons.calendar,
                                        style: HeroIconStyle.solid,
                                        size: 20,
                                        color: Color(0xFFff7488),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Thời gian',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        width: 200,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: Obx(
                                          () => DropdownMenu(
                                            width: 200,
                                            menuStyle: MenuStyle(
                                              backgroundColor:
                                                  WidgetStatePropertyAll(
                                                    Colors.white,
                                                  ),
                                            ),
                                            controller:
                                                controller
                                                    .chuyenXeTextController,
                                            dropdownMenuEntries:
                                                controller.listOfChuyenXe.map((
                                                  element,
                                                ) {
                                                  return DropdownMenuEntry(
                                                    value: element,
                                                    label:
                                                        controller
                                                                    .chieuDiCuaHanhKhach
                                                                    .value ==
                                                                "di"
                                                            ? element.gioLuotDi
                                                            : element.gioLuotVe,
                                                  );
                                                }).toList(),
                                            onSelected: controller.setChuyenXe,
                                            hintText: "Chọn thời gian",
                                            textStyle: TextStyle(
                                              fontWeight: FontWeight.w800,
                                            ),
                                            trailingIcon: SizedBox.shrink(),
                                            inputDecorationTheme:
                                                const InputDecorationTheme(
                                                  constraints: BoxConstraints(
                                                    maxHeight: 20,
                                                  ),
                                                  isDense: true,
                                                  border: InputBorder.none,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              child: FullWidthButton(
                                onPressed: () {
                                  if (!controller.kiemTraTuyenDaChon() ||
                                      !controller.kiemTraTramDaChon() ||
                                      !controller.kiemTraTramHopLe() ||
                                      !controller.kiemTraSoLuongVeDaChon() ||
                                      !controller.kiemTraChuyenXeDaChon()) {
                                    return;
                                  }
                                  Get.toNamed('/xac-nhan');
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Đi đến xác nhận',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      size: 27,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 20,
                    top: 200,
                    child: CustomButton(
                      onPressed: () {
                        controller.swapTram();
                      },
                      width: 50,
                      shadow: BoxShadow(
                        color: Color.fromRGBO(100, 100, 111, 0.2),
                        blurRadius: 29,
                        spreadRadius: 0,
                        offset: Offset(0, 7),
                      ),
                      borderRadius: Radius.circular(20),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: HeroIcon(
                          HeroIcons.arrowsUpDown,
                          style: HeroIconStyle.solid,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

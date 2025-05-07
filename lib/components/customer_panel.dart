import 'package:bus_online/components/custom_button.dart';
import 'package:bus_online/components/full_width_button.dart';
import 'package:bus_online/controllers/dang_ki_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';

class CustomerPanel extends StatelessWidget {
  CustomerPanel({super.key});

  final DangKiVeController controller = Get.put(DangKiVeController());

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                    Expanded(
                      child: Column(
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
                            height: 20,
                            decoration: BoxDecoration(color: Colors.white),
                            child: Obx(
                              () => DropdownMenu(
                                width: double.infinity,
                                menuStyle: MenuStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                    Colors.white,
                                  ),
                                ),
                                controller: controller.tuyenTextController,
                                dropdownMenuEntries:
                                    controller.listOfTuyen.map((element) {
                                      return DropdownMenuEntry(
                                        value: element,
                                        label: element.tenTuyen,
                                      );
                                    }).toList(),
                                onSelected: controller.setTuyen,
                                hintText: "Chọn tuyến đường",
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                menuHeight: 150,
                                trailingIcon: SizedBox.shrink(),
                                inputDecorationTheme: const InputDecorationTheme(
                                  constraints: BoxConstraints(maxHeight: 20),
                                  isDense: true,
                                  isCollapsed: true,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                    Expanded(
                      child: Column(
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
                            height: 20,
                            decoration: BoxDecoration(color: Colors.white),
                            child: Obx(
                              () => DropdownMenu(
                                width: double.infinity,
                                menuStyle: MenuStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                    Colors.white,
                                  ),
                                ),
                                controller: controller.tramDiTextController,
                                dropdownMenuEntries:
                                    controller.listOfTram.map((element) {
                                      return DropdownMenuEntry(
                                        value: element,
                                        label: element.tenTram,
                                      );
                                    }).toList(),
                                onSelected: controller.setTramDi,
                                hintText: "Chọn trạm đi",
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                menuHeight: 150,
                                trailingIcon: SizedBox.shrink(),
                                inputDecorationTheme: const InputDecorationTheme(
                                  alignLabelWithHint: false,
                                  constraints: BoxConstraints(maxHeight: 20),
                                  isDense: true,
                                  isCollapsed: true,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                    Expanded(
                      child: Column(
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
                            height: 20,
                            decoration: BoxDecoration(color: Colors.white),
                            child: Obx(
                              () => DropdownMenu(
                                width: double.infinity,
                                menuStyle: MenuStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                    Colors.white,
                                  ),
                                ),
                                controller: controller.tramDenTextController,
                                dropdownMenuEntries:
                                    controller.listOfTram.map((element) {
                                      return DropdownMenuEntry(
                                        value: element,
                                        label: element.tenTram,
                                      );
                                    }).toList(),
                                onSelected: controller.setTramDen,
                                hintText: "Chọn trạm đến",
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  overflow: TextOverflow.ellipsis
                                ),
                                menuHeight: 150,
                                trailingIcon: SizedBox.shrink(),
                                inputDecorationTheme: const InputDecorationTheme(
                                  constraints: BoxConstraints(maxHeight: 20),
                                  isDense: true,
                                  isCollapsed: true,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                    controller.decreaseNumberOfTicket();
                                  },
                                  width: 30,
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
                                    controller.increaseNumberOfTicket();
                                  },
                                  width: 30,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              decoration: BoxDecoration(color: Colors.white),
                              child: Obx(
                                () => DropdownMenu(
                                  width: 200,
                                  menuStyle: MenuStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                      Colors.white,
                                    ),
                                  ),
                                  controller: controller.chuyenXeTextController,
                                  dropdownMenuEntries:
                                      controller.listOfChuyenXe.map((element) {
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
                            style: TextStyle(color: Colors.white, fontSize: 16),
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
              color: Color.fromRGBO(0, 0, 0, 0.24),
              blurRadius: 8,
              spreadRadius: 0,
              offset: Offset(0, 3),
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
    );
  }
}

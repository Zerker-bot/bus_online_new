import 'package:bus_online/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/full_width_button.dart';

class Dashboard extends StatelessWidget {

  final DashboardController controller = Get.put(DashboardController());

  Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: const Text("Quét mã QR"),
          ),
          body: Column(
            children:
            [
              Obx(() => Expanded(
                child: ListView.separated(
                padding: const EdgeInsets.all(10),
                itemCount: controller.danhSachThongBao.length,
                itemBuilder: (context, index) {
                  final thongBao = controller.danhSachThongBao[index];
                  return Container(
                    padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
                    decoration: BoxDecoration(
                      color: Color(0xffff5723),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            thongBao,
                            style: const TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.black),
                          onPressed: () {

                              controller.danhSachThongBao.removeAt(index);

                          },
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 5),
                ),
              )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child:   FullWidthButton(
                    onPressed: () {
                      Get.toNamed('/scanner');
                    },
                    backgroundColor: const Color(0xff18a5df),
                    child: const Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.qr_code_scanner,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Quét mã',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    )),
              ),
          ]

          ),

    );
  }
}

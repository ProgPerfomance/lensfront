import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:newlensfront/view/main/services/services_by_category_view.dart';

import '../../controller/services_controller.dart';

class AllCategoriesView extends GetView<ServicesController> {
  final bool services;
  const AllCategoriesView({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    Get.put(ServicesController());
    controller.getCategoriesList();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                8.heightBox,
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        List.generate(controller.categories.length, (index) {
                      final item = controller.categories[index];
                      List pods = item['pods'];
                      return pods.isNotEmpty
                          ? ExpansionTile(
                              tilePadding: EdgeInsets.zero,
                              title: Text(
                                item['category'],
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                ),
                              ),
                              children: List.generate(
                                  pods.length,
                                  (ind) => Container(
                                      alignment: Alignment.centerLeft,
                                      width: MediaQuery.of(context).size.width,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 4),
                                        child: GestureDetector(
                                            onTap: () {
                                              controller.categoryId.value =
                                                  pods[ind]['id'];
                                              services == false
                                                  ? Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AllServicesByCategoryView(
                                                                categoryName: pods[
                                                                        ind][
                                                                    'category'],
                                                              )))
                                                  : {
                                                      controller.searchCategory
                                                              .value =
                                                          pods[ind]['category'],
                                                      controller
                                                          .getAllServices(''),
                                                      Navigator.pop(context)
                                                    };
                                            },
                                            child: Text(pods[ind]['category'])),
                                      ))),
                            )
                          : Container(
                              alignment: Alignment.centerLeft,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: GestureDetector(
                                  onTap: () {
                                    controller.category.value =
                                        item['category'];
                                    controller.categoryId.value = item['id'];
                                    services == false
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AllServicesByCategoryView(
                                                      categoryName:
                                                          item['category'],

                                                    )))
                                        : {
                                            controller.searchCategory.value =
                                                item['category'],
                                            controller.getAllServices(''),
                                            Navigator.pop(context)
                                          };
                                  },
                                  child: Text(item['category']),
                                ),
                              ));
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

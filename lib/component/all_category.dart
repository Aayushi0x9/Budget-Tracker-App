import 'package:budget_tracker_app/controller/category_controller.dart';
import 'package:budget_tracker_app/helper/db_helper.dart';
import 'package:budget_tracker_app/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

CategoryController controller = Get.put(CategoryController());
GlobalKey<FormState> formKey = GlobalKey<FormState>();
TextEditingController textController = TextEditingController();

class AllCategory extends StatelessWidget {
  const AllCategory({super.key});
  @override
  Widget build(BuildContext context) {
    controller.fetchCategoryData();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        children: [
          TextField(
            onChanged: (value) {
              controller.searchData(search: value);
            },
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                labelText: 'Search Category',
                hintText: 'Search...'),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: GetBuilder<CategoryController>(builder: (context) {
              return FutureBuilder(
                  future: controller.allCategory,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error : ${snapshot.error}'),
                      );
                    } else if (snapshot.hasData) {
                      List<CategoryModel> allCategoryList = snapshot.data ?? [];

                      return allCategoryList.isNotEmpty
                          ? ListView.builder(
                              itemCount: allCategoryList.length,
                              itemBuilder: (context, index) {
                                final data = allCategoryList[index];
                                return Card(
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 20,
                                      child: Icon(controller
                                          .categoryList[data.image]['icon']),
                                    ),
                                    title: Text('${data.name}'),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              controller.deleteCategory(
                                                  id: data.id);
                                            },
                                            icon: const Icon(Icons.delete)),
                                        IconButton(
                                            onPressed: () {
                                              textController.text = data.name;
                                              Get.bottomSheet(
                                                Container(
                                                  width: double.infinity,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 16,
                                                          left: 16,
                                                          top: 16,
                                                          bottom: 40),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(20),
                                                      topRight:
                                                          Radius.circular(20),
                                                    ),
                                                  ),
                                                  child: Form(
                                                    key: formKey,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        TextFormField(
                                                          controller:
                                                              textController,
                                                          validator: (value) =>
                                                              value!.isEmpty
                                                                  ? 'Required category name'
                                                                  : null,
                                                          decoration:
                                                              InputDecoration(
                                                                  prefixIcon:
                                                                      const Icon(
                                                                          Icons
                                                                              .category_outlined),
                                                                  focusColor: Colors
                                                                      .deepPurpleAccent,
                                                                  labelText:
                                                                      'Category',
                                                                  hintText:
                                                                      'Enter Any Category...',
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            60),
                                                                  )),
                                                          textInputAction:
                                                              TextInputAction
                                                                  .send,
                                                        ),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        Expanded(
                                                          child:
                                                              GridView.builder(
                                                            itemCount: controller
                                                                .categoryList
                                                                .length,
                                                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount:
                                                                    4,
                                                                crossAxisSpacing:
                                                                    10,
                                                                mainAxisSpacing:
                                                                    10),
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return GetBuilder<
                                                                      CategoryController>(
                                                                  builder:
                                                                      (controller) {
                                                                return InkWell(
                                                                  onTap: () {
                                                                    controller.getSelectedCategoryInd(
                                                                        index:
                                                                            index);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: (controller.getCategorySelectedIndex !=
                                                                                null)
                                                                            ? (controller.getCategorySelectedIndex == index)
                                                                                ? Colors.grey
                                                                                : Colors.transparent
                                                                            : (index == data.image)
                                                                                ? Colors.grey
                                                                                : Colors.transparent,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        GridTile(
                                                                      footer: Center(
                                                                          child: Text(
                                                                        controller.categoryList[index]
                                                                            [
                                                                            'category'],
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      )),
                                                                      child:
                                                                          Icon(
                                                                        controller.categoryList[index]
                                                                            [
                                                                            'icon'],
                                                                        size:
                                                                            30,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            FloatingActionButton
                                                                .extended(
                                                              onPressed:
                                                                  () async {
                                                                if (formKey
                                                                        .currentState!
                                                                        .validate() &&
                                                                    controller
                                                                            .getCategorySelectedIndex !=
                                                                        null) {
                                                                  String
                                                                      category =
                                                                      textController
                                                                          .text;
                                                                  int image =
                                                                      controller
                                                                          .getCategorySelectedIndex!;
                                                                  CategoryModel model = CategoryModel(
                                                                      id: data
                                                                          .id,
                                                                      name: textController
                                                                          .text,
                                                                      image:
                                                                          image);
                                                                  int? res = await DBHelper
                                                                      .dbHelper
                                                                      .updateCategory(
                                                                          model:
                                                                              model);
                                                                  controller
                                                                      .fetchCategoryData();
                                                                  if (res !=
                                                                      null) {
                                                                    controller
                                                                        .update();
                                                                    Get.snackbar(
                                                                      'Updated',
                                                                      '$category category is updated',
                                                                      colorText:
                                                                          Colors
                                                                              .white,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .green,
                                                                    );
                                                                  } else {
                                                                    Get.snackbar(
                                                                      'Failed',
                                                                      '$category category update is failed...',
                                                                      colorText:
                                                                          Colors
                                                                              .white,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red,
                                                                    );
                                                                  }
                                                                } else {
                                                                  Get.snackbar(
                                                                    'Required!!',
                                                                    'Required Category and image!!',
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red,
                                                                    colorText:
                                                                        Colors
                                                                            .white,
                                                                  );
                                                                }
                                                                textController
                                                                    .clear();
                                                              },
                                                              label: const Text(
                                                                  'Add Category'),
                                                              icon: const Icon(Icons
                                                                  .add_shopping_cart_rounded),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            icon: const Icon(Icons.edit)),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : const Center(
                              child: Text('Any Category Not added yet...!!'),
                            );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  });
            }),
          ),
        ],
      ),
    );
  }
}

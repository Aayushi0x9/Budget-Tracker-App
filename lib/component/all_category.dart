import 'package:budget_tracker_app/controller/category_controller.dart';
import 'package:budget_tracker_app/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

CategoryController controller = Get.put(CategoryController());

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
                                      child: Icon((controller
                                              .categoryList[index] ==
                                          allCategoryList[index]) as IconData?),
                                    ),
                                    title: Text('${data.name}'),
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

import 'package:budget_tracker_app/controller/category_controller.dart';
import 'package:budget_tracker_app/helper/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

GlobalKey<FormState> formKey = GlobalKey<FormState>();

class CategoryComp extends StatelessWidget {
  const CategoryComp({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    CategoryController controller = Get.put(CategoryController());
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      height: double.infinity,
      width: double.infinity,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: textController,
              validator: (value) =>
                  value!.isEmpty ? 'Required category name' : null,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.category_outlined),
                  focusColor: Colors.deepPurpleAccent,
                  labelText: 'Category',
                  hintText: 'Enter Any Category...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(60),
                  )),
              textInputAction: TextInputAction.send,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView.builder(
                itemCount: controller.category.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  return GetBuilder<CategoryController>(builder: (controller) {
                    return InkWell(
                      onTap: () {
                        controller.getSelectedCategoryInd(index: index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: controller.getCategorySelectedIndex == index
                              ? Colors.grey.withOpacity(0.3)
                              : Colors.transparent,
                        ),
                        child: GridTile(
                          footer: Center(
                              child: Text(
                            controller.category[index]['category'],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          child: Icon(
                            controller.category[index]['icon'],
                            size: 30,
                          ),
                        ),
                      ),
                    );
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton.extended(
                  onPressed: () async {
                    if (formKey.currentState!.validate() &&
                        controller.getCategorySelectedIndex != null) {
                      String category = textController.text;
                      String assetPath = 'assets/icons/gift.png';

                      ByteData byteData = await rootBundle.load(assetPath);

                      Uint8List image = byteData.buffer.asUint8List();

                      int? res = await DBHelper.dbHelper
                          .insertCategory(name: category, image: image);
                      Logger().i(res);
                      if (res != null) {
                        Get.showSnackbar(
                          const GetSnackBar(
                            title: 'insert....',
                            duration: Duration(seconds: 1),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } else {
                        Get.snackbar(
                          'Failed',
                          '$category category is Insertion failed...',
                          colorText: Colors.white,
                          backgroundColor: Colors.red,
                        );
                      }
                    } else {
                      Get.snackbar(
                        'Required!!',
                        'Required Category and image!!',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  },
                  label: const Text('Add Category'),
                  icon: const Icon(Icons.add_shopping_cart_rounded),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

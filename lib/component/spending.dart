import 'package:budget_tracker_app/controller/category_controller.dart';
import 'package:budget_tracker_app/controller/spend_controller.dart';
import 'package:budget_tracker_app/model/spend_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

TextEditingController descController = TextEditingController();
TextEditingController amountController = TextEditingController();

GlobalKey<FormState> spendingKey = GlobalKey<FormState>();

bool validateForm(SpendingController controller) {
  if (!spendingKey.currentState!.validate()) {
    return false;
  }
  if (controller.mode == null) {
    Get.snackbar("Error", "Please select a mode.",
        backgroundColor: Colors.red.shade300);
    return false;
  }
  if (controller.dateTime == null) {
    Get.snackbar("Error", "Please select a date.",
        backgroundColor: Colors.red.shade300);
    return false;
  }
  if (controller.spendingIndex == null) {
    Get.snackbar("Error", "Please select a category.",
        backgroundColor: Colors.red.shade300);
    return false;
  }
  return true;
}

class Spending extends StatelessWidget {
  const Spending({super.key});

  @override
  Widget build(BuildContext context) {
    SpendingController controller = Get.put(SpendingController());
    SpendingController spendingController = Get.put(SpendingController());
    CategoryController catController = Get.put(CategoryController());
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GetBuilder<SpendingController>(builder: (ctx) {
        return Form(
          key: spendingKey,
          child: Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white,
                      ),
                      color: Colors.white.withOpacity(0.2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TITLE',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        TextFormField(
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          controller: descController,
                          validator: (val) =>
                              val!.isEmpty ? "required desc...." : null,
                          decoration: InputDecoration(
                            hintText: "Enter spending description...",
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white,
                      ),
                      color: Colors.white.withOpacity(0.2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'DISCRIPTION',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        TextFormField(
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          controller: descController,
                          validator: (val) =>
                              val!.isEmpty ? "required desc...." : null,
                          decoration: InputDecoration(
                            hintText: "Enter spending description...",
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white,
                      ),
                      color: Colors.white.withOpacity(0.2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AMOUNT',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        TextFormField(
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          validator: (val) =>
                              val!.isEmpty ? "required amount...." : null,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                            ),
                            hintText: "Enter spending amount...",
                            border: InputBorder.none,
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: MediaQuery.sizeOf(context).width,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white,
                      ),
                      color: Colors.white.withOpacity(0.2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MODE',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          child: DropdownButton(
                            borderRadius: BorderRadius.circular(12),
                            icon: Icon(
                              Icons.arrow_drop_down_rounded,
                              color: Colors.white,
                            ),
                            dropdownColor: Colors.white.withOpacity(0.7),
                            value: controller.mode,
                            hint: const Text(
                              "Select",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: "online",
                                child: Text("Online"),
                              ),
                              DropdownMenuItem(
                                value: "offline",
                                child: Text("Offline"),
                              ),
                            ],
                            onChanged: controller.getSpendingMode,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white,
                      ),
                      color: Colors.white.withOpacity(0.2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'DATE',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2026),
                            );
                            if (date != null) {
                              controller.getSpendingDate(date: date);
                            }
                          },
                          child: Row(
                            children: [
                              if (controller.dateTime != null)
                                Text(
                                  "${controller.dateTime?.day}/${controller.dateTime?.month}/${controller.dateTime?.year}",
                                )
                              else
                                const Text(
                                  "DD/MM/YYYY",
                                  style: TextStyle(color: Colors.white),
                                ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.date_range,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider()
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 400,
                    child: GridView.builder(
                      itemCount: catController.categoryList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        return GetBuilder<CategoryController>(
                            builder: (controller) {
                          return GestureDetector(
                            onTap: () {
                              catController.getSelectedCategoryInd(
                                  index: index);
                              spendingController.getSpendingIndex(
                                index: index,
                                id: catController.getCategorySelectedIndex!,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white.withOpacity(0.5),
                                border: Border.all(
                                  color: controller.getCategorySelectedIndex ==
                                          index
                                      ? Colors.white
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: GridTile(
                                footer: Center(
                                    child: Text(
                                  controller.categoryList[index]['category'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                                child: Icon(
                                  controller.categoryList[index]['icon'],
                                  size: 30,
                                  color: Colors.white.withOpacity(0.8),
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
                        backgroundColor: Colors.white,
                        onPressed: () {
                          if (validateForm(controller)) {
                            controller.addSpendingData(
                              model: SpendingModel(
                                id: 0,
                                desc: descController.text,
                                amount: num.parse(amountController.text),
                                mode: controller.mode!,
                                date:
                                    "${controller.dateTime?.day}/${controller.dateTime?.month}/${controller.dateTime?.year}",
                                categoryId: controller.categoryId,
                              ),
                            );
                            descController.clear();
                            amountController.clear();
                            controller.getDefaultValue();
                          }
                        },
                        label: const Text(
                          "Add Spending",
                          style: TextStyle(
                            color: Color(0xff141326),
                          ),
                        ),
                        icon: Icon(Icons.add),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

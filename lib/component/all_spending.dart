import 'package:budget_tracker_app/component/all_category.dart';
import 'package:budget_tracker_app/controller/spend_controller.dart';
import 'package:budget_tracker_app/helper/db_helper.dart';
import 'package:budget_tracker_app/model/spend_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

SpendingController sController = Get.put(SpendingController());

class AllSpending extends StatelessWidget {
  const AllSpending({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DBHelper.dbHelper.fetchSpending(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<SpendingModel> spendingData = snapshot.data ?? [];

          return ListView.builder(
            itemCount: spendingData.length,
            itemBuilder: (context, index) {
              var data = SpendingModel(
                  id: spendingData[index].id,
                  desc: spendingData[index].desc,
                  amount: spendingData[index].amount,
                  mode: spendingData[index].mode,
                  date: spendingData[index].date,
                  categoryId: spendingData[index].categoryId);
              return Container(
                width: double.infinity,
                height: 250,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  // color: Colors.black87,
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/images/card.png',
                    ),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.only(top: 22, left: 50, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '            ${spendingData[index].desc}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                            Get.bottomSheet(
                              Container(
                                height: 300,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.all(20),
                                child: AllCategory(
                                
                              )
                            ),
                            );
                             },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            )),
                        IconButton(
                            onPressed: () {
                              sController.deleteSpending(
                                  id: spendingData[index].id);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "₹ ${spendingData[index].amount}",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text(
                          "DATE : ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          data.date,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FutureBuilder(
                      future: DBHelper.dbHelper
                          .fetchSingleCategory(id: data.categoryId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return (snapshot.data != null)
                              ? Text(
                                  snapshot.data!.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              : Container();
                        }
                        return Container();
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          controller.categoryList[data.categoryId]['icon'],
                          size: 30,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ActionChip(
                          color: WidgetStateProperty.all(
                            (data.mode == 'online')
                                ? Colors.green
                                : Colors.yellow,
                          ),
                          label: Text(data.mode),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

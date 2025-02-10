class SpendingModel {
  int id;
  String desc;
  num amount;
  String mode;
  String date;
  int categoryId;

  SpendingModel({
    required this.id,
    required this.desc,
    required this.amount,
    required this.mode,
    required this.date,
    required this.categoryId,
  });

  factory SpendingModel.formMap({required Map<String, dynamic> data}) {
    return SpendingModel(
      id: data['spend_id'],
      desc: data['spend_desc'],
      amount: data['spend_amount'],
      mode: data['spend_mode'],
      date: data['spend_date'],
      categoryId: data['spend_category_id'],
    );
  }
}

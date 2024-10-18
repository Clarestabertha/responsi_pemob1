class Hutang {
  int? id;
  String? person;
  var amount;
  String? status;
  Hutang({this.id, this.person, this.amount, this.status});
  factory Hutang.fromJson(Map<String, dynamic> obj) {
    return Hutang(
        id: obj['id'],
        person: obj['person'],
        amount: obj['amount'],
        status: obj['status']);
  }
}

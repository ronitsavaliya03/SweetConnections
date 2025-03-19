class UserModel{
  String? id;
  String? companyName;
  String? date;
  String? amount;
  String? description;
  String? status;

  UserModel({required this.id, required this.companyName, this.status, this.date, this.amount, this.description});

  static UserModel toUser(Map<String, dynamic> u){
    return UserModel(id: u['id'], companyName: u['companyName'],  status: u['status'],  date: u['date'],  amount: u['amount'],  description: u['description']);
  }

  Map<String, dynamic> toMap(){
    return {'id': this.id, 'companyName': this.companyName, 'status': this.status ?? "default", 'date': this.date ?? "default", 'amount': this.amount ?? "default", 'description': this.description ?? "default"};
  }

}

// "companyName": "Treutel Group",
// "date": "2024-09-16",
// "amount": "403.53",
// "description": "deposit transaction at Harvey - McGlynn using card ending with ***(...8727) for MDL 704.75 in account ***68673881",
// "status": "deposit",
// "id": "3"
class UserDataModel {
  int? id;
  int? userId;
  String? credits;
  var nameTitle;
  String? name;
  String? phone;
  String? cardId;
  var cardUrl;
  int? bankId = 0;
  String? branchNo;
  String? accountName;
  String? accountNumber;
  var bookBankUrl;
  int? status;
  var deletedAt;
  String? createdAt;
  String? updatedAt;

  UserDataModel(
      {this.id,
      this.userId,
      this.credits,
      this.nameTitle,
      this.name,
      this.phone,
      this.cardId,
      this.cardUrl,
      this.bankId,
      this.branchNo,
      this.accountName,
      this.accountNumber,
      this.bookBankUrl,
      this.status,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    userId = json['user_id'] ?? '';
    credits = json['credits'] ?? '';
    nameTitle = json['name_title'] ?? '';
    name = json['name'] ?? '';
    phone = json['phone'] ?? '';
    cardId = json['card_id'] ?? '';
    cardUrl = json['card_url'] ?? '';
    bankId = int.parse(json['bank_id']);
    branchNo = json['branch_no'] ?? '';
    accountName = json['account_name'] ?? '';
    accountNumber = json['account_number'] ?? '';
    bookBankUrl = json['book_bank_url'] ?? '';
    status = json['status'] ?? '';
    deletedAt = json['deleted_at'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['credits'] = this.credits;
    data['name_title'] = this.nameTitle;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['card_id'] = this.cardId;
    data['card_url'] = this.cardUrl;
    data['bank_id'] = this.bankId;
    data['branch_no'] = this.branchNo;
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    data['book_bank_url'] = this.bookBankUrl;
    data['status'] = this.status;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

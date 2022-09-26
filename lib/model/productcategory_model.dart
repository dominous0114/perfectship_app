class ProductCategory {
  int id;
  String name;

  ProductCategory({required this.id, required this.name});

  static final category = [
    //ProductCategory(id: 9999, name: null),
    ProductCategory(id: 0, name: 'เอกสาร'),
    ProductCategory(id: 1, name: 'อาหารแห้ง'),
    ProductCategory(id: 2, name: 'ของใช้'),
    ProductCategory(id: 3, name: 'อุปกรณ์ไอที'),
    ProductCategory(id: 4, name: 'เสื้อผ้า'),
    ProductCategory(id: 5, name: 'สื่อบันเทิง'),
    ProductCategory(id: 6, name: 'อะไหล่รถยนต์'),
    ProductCategory(id: 7, name: 'รองเท้า/กระเป๋า'),
    ProductCategory(id: 8, name: 'อุปกรณ์กีฬา'),
    ProductCategory(id: 9, name: 'เครื่องสำอางค์'),
    ProductCategory(id: 10, name: 'เฟอร์นิเจอร์'),
    ProductCategory(id: 11, name: 'ผลไม้'),
    ProductCategory(id: 99, name: 'อื่นๆ'),
  ];
}

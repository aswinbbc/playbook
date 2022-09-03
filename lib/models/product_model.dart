class Product {
  String? productName;
  int? price;
  String? discr;
  int? qua;
  Product.fromMap(Map<String, dynamic> data) {
    productName = data['product_name'];
    price = data['price'];
    discr = data['desc'];
    qua = data['quantity'];
  }

  Product({this.discr, this.price, this.productName, this.qua});
}

void main() {
  Map<String, dynamic> studentMap = {
    "roll_no": 1,
    "name": "aswin",
    "age": 12,
  };

  List<Map<String, dynamic>> marks = [
    {
      "roll_no": 1,
      "Subject": "maths",
      "mark": 89,
    },
    {
      "roll_no": 1,
      "Subject": "english",
      "mark": 90,
    },
    {
      "roll_no": 1,
      "Subject": "science",
      "mark": 55,
    },
  ];
}

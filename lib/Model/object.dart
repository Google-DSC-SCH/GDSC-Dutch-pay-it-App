// 구성원 클래스
class People {
  late String name;     // 구성원 이름
  late String menu;     // 먹은 메뉴
  late String shop;     // 식당 이름
  late int price;       // 총 금액
  late int number;      // 수량

  List<People> peoplelist = [];
}

// 메뉴 클래스
class Menu {
  late String MenuName;     // 메뉴이름
  late String shop;         // 메뉴별 식당이름
  late int number;          // 메뉴별 수량
  late int price;         // 메뉴별 가격
}


// 메뉴리스트 클래스
class MenuList {
  late String shop;   // 식당이름
  late String menuName;   // 메뉴이름
  late int menuCount;     // 메뉴별 수량
  late int price;     // 메뉴별 총가격 (개별메뉴가격 x 메뉴수량)
  late String peopleName;   // 메뉴별 더치페이 참여자 리스트
  late int peopleCount;     // 더치페이 참여 인원수

  // MenuList(String shop, String menuName, int menuCount, int price, String peopleName, int peopleCount) {
  //   this.shop = shop;
  //   this.menuName = menuName;
  //   this.menuCount = menuCount;
  //   this.price = price;
  //   this.peopleName = peopleName;
  //   this.peopleCount = peopleCount;
  // }

  MenuList(this.shop, this.menuName, this.menuCount, this.price, this.peopleName, this.peopleCount);


  // factory MenuList.fromJson(Map<String, dynamic> json) {
  //   return MenuList(
  //       shop: json['shop'],
  //       menuName: json['menuName'],
  //       menuCount: json['menuCount'],
  //       price: json['price'],
  //       peopleName: json['peopleName'],
  //       peopleCount: json['peopleCount']
  //   );
  //}
}


// 입력과 ML을 통해 전달할 메뉴정보 클래스
class Item {
  late String shop;   // 식당이름
  late String menuName; // 메뉴이름 from ML
  late int menuCount;   // 메뉴별 수량 from ML
  late int menuPrice;   // 메뉴별 가격 from ML
  late String peopleName;  // 구성원 리스트
  late int peopleCount;   // 구성원 수

  Item(this.shop, this.menuName, this.menuCount, this.menuPrice, this.peopleName, this.peopleCount);

  // factory Item.fromJson(Map<String, dynamic> json) {
  //   return Item(
  //       shop: json['shop'],
  //       menuName: json['menuName'],
  //       menuCount: json['menuCount'],
  //       menuPrice: json['menuPrice'],
  //       peopleName: json['peopleName'],
  //       peopleCount: json['peopleCount']
  //   );
  // }
}

// 정산서 클래스
class Bill {
  late final String shop;         // 식당이름
  late final String peopleName;   // 정산서 사람이름
  late final String menuName;     // 메뉴이름 - 인당
  late final int nPrice;       // 메뉴별 가격 - 인당
  late final int totalPrice;           // 인당 총 금액

  Bill({required this.shop, required this.peopleName, required this.menuName, required this.nPrice, required this.totalPrice});

  factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
        shop: json['shop'],
        peopleName: json['peopleName'],
        menuName: json['menuName'],
        nPrice: json['nPrice'],
        totalPrice: json['totalPrice']
    );
  }
}
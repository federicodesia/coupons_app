import 'dart:ui';

enum DiscountType{
  Quantity,
  Percentage,
}

enum AnimationType{
  Linear,
  Rotation,
}

const String imageRoute = "assets/images/coupons/";
const String companyImageRoute = "assets/images/companies/";

const String defaultDescription = "Back in 1945, a man named Ray Kroc discovered a small burger restaurant in California, and wrote the first page of our history. From humble beginnings as a small restaurant, we're proud to have become one of the world's leading food service brands with more than 36,000 restaurants in more than 100 countries.";

class Coupon{

  final String title;
  final DiscountType discountType;
  final double discount;
  final String companyImage;
  final String image;
  final Color backgroundColor;
  final AnimationType animationType;
  final String description;
  final String descriptionTitle;
  final String expirationDate;

  Coupon({
      required this.title, 
      this.discountType = DiscountType.Quantity,
      required this.discount,
      required this.companyImage,
      required this.image,
      required this.backgroundColor,
      this.animationType = AnimationType.Linear,
      this.description = defaultDescription,
      this.descriptionTitle = "Our story starts with one man.",
      this.expirationDate = "2020/06/31"
  });

  String get getImage => imageRoute + image;
  String get getCompanyImage => companyImageRoute + companyImage;
}

final List<Coupon> couponsList = <Coupon> [
  Coupon(
    title: "McDonald's french",
    discount: -5.00,
    companyImage: "McDonalds.png",
    image: "Chips.png",
    backgroundColor: Color(0xFF4AA596)
  ),

  Coupon(
    title: "Donuts",
    discount: -0.50,
    companyImage: "DunkinDonuts.png",
    image: "Donut.png",
    backgroundColor: Color(0xFFE0E7F8),
    animationType: AnimationType.Rotation
  ),

  Coupon(
    title: "Pizza",
    discount: -1.25,
    companyImage: "Domino.png",
    image: "Pizza.png",
    backgroundColor: Color(0xFFE5E3F2),
    animationType: AnimationType.Rotation
  ),

  Coupon(
    title: "iPhone",
    discountType: DiscountType.Percentage,
    discount: -15,
    companyImage: "Apple.png",
    image: "iPhone.png",
    backgroundColor: Color(0xFFD7E2F1),
    animationType: AnimationType.Rotation
  ),

  Coupon(
    title: "Cappuccino",
    discountType: DiscountType.Percentage,
    discount: -10,
    companyImage: "Starbucks.png",
    image: "Coffee.png",
    backgroundColor: Color(0xFFEFE9EB)
  ),

  Coupon(
    title: "Shoes",
    discountType: DiscountType.Percentage,
    discount: -30,
    companyImage: "Adidas.png",
    image: "Shoes.png",
    backgroundColor: Color(0xFFEBE9F1)
  ),

  Coupon(
    title: "Electric toothbrush",
    discountType: DiscountType.Percentage,
    discount: -18,
    companyImage: "Goby.png",
    image: "Toothbrush.png",
    backgroundColor: Color(0xFFEDDCEE)
  ),

  Coupon(
    title: "Game Consoles",
    discountType: DiscountType.Percentage,
    discount: -10,
    companyImage: "Sony.png",
    image: "PS5.png",
    backgroundColor: Color(0xFF191879)
  ),
];
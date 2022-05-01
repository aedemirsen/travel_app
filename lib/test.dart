import 'model/slide_model.dart';

class TEST {
  static Map<String, String> dests = {
    'Nevşehir': 'assets/images/nevsehir.jpg',
    'Muğla': 'assets/images/mugla.jpg',
    'Bolu': 'assets/images/bolu.jpg',
    'İstanbul': 'assets/images/ist.jpg'
  };

  static List<String> vacation = [
    'assets/images/river.jpg',
    'assets/images/forest.jpg',
    'assets/images/nature.jpg',
  ];

  static List<String> dropDownItems = [
    "İstanbul,Türkiye",
    "Kadıköy,İstanbul,Türkiye",
    "Çankaya,Ankara,Türkiye",
    "Bolu,Türkiye",
    "Gerede,Bolu,Türkiye",
    "Muğla,Türkiye",
    "Nevşehir,Türkiye",
    "Kumluca,Antalya,Türkiye"
  ];

  static List<SlideModel> slides = [];

  static setSlides() {
    SlideModel m1 = SlideModel();
    m1.url = 'assets/images/nevsehir.jpg';
    m1.location = 'Nevşehir';
    m1.title = "";
    m1.subTitle = "";
    m1.info = "Doğa ile iç içe bir tatil";
    SlideModel m2 = SlideModel();
    m2.url = 'assets/images/mugla.jpg';
    m2.location = 'Muğla';
    m2.title = "";
    m2.subTitle = "";
    m2.info = "Doğa ile iç içe bir tatil";
    SlideModel m3 = SlideModel();
    m3.url = 'assets/images/bolu.jpg';
    m3.location = 'Bolu';
    m3.title = "";
    m3.subTitle = "";
    m3.info = "Doğa ile iç içe bir tatil";

    slides.add(m1);
    slides.add(m2);
    slides.add(m3);
  }

  //account info
  static String userName = "Ahmet Emre Demirşen";
  static String email = "aedemirsen@gmail.com";
  static String phoneNumber = "552 321 79 60";
}

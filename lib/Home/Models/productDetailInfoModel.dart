import 'package:tkjidi/Request/httpRequest.dart';

class productDetailInfoDataModel {
  int time;
  int code;
  String msg;
  ProductDetailInfoModel data;

  productDetailInfoDataModel({this.time, this.code, this.msg, this.data});

  productDetailInfoDataModel.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new ProductDetailInfoModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class ProductDetailInfoModel {
  int id;
  String goodsId;
  String title;
  String dtitle;
  double originalPrice;
  double actualPrice;
  int shopType;
  int goldSellers;
  int monthSales;
  int twoHoursSales;
  int dailySales;
  int commissionType;
  String desc;
  int couponReceiveNum;
  String couponLink;
  String couponEndTime;
  String couponStartTime;
  double couponPrice;
  String couponConditions;
  int activityType;
  String createTime;
  String mainPic;
  String marketingMainPic;
  String sellerId;
  int cid;
  double discounts;
  double commissionRate;
  int couponTotalNum;
  int haitao;
  String activityStartTime;
  String activityEndTime;
  String shopName;
  int shopLevel;
  double descScore;
  int brand;
  int brandId;
  String brandName;
  int hotPush;
  String teamName;
  String itemLink;
  int tchaoshi;
  List detailPics;
  double dsrScore;
  double dsrPercent;
  double shipScore;
  double shipPercent;
  double serviceScore;
  double servicePercent;
  List<int> subcid;
  List imgs;
  String reimgs;
  int tbcid;
  int quanMLink;
  int hzQuanOver;
  int yunfeixian;
  int estimateAmount;

  ProductDetailInfoModel(
      {this.id,
      this.goodsId,
      this.title,
      this.dtitle,
      this.originalPrice,
      this.actualPrice,
      this.shopType,
      this.goldSellers,
      this.monthSales,
      this.twoHoursSales,
      this.dailySales,
      this.commissionType,
      this.desc,
      this.couponReceiveNum,
      this.couponLink,
      this.couponEndTime,
      this.couponStartTime,
      this.couponPrice,
      this.couponConditions,
      this.activityType,
      this.createTime,
      this.mainPic,
      this.marketingMainPic,
      this.sellerId,
      this.cid,
      this.discounts,
      this.commissionRate,
      this.couponTotalNum,
      this.haitao,
      this.activityStartTime,
      this.activityEndTime,
      this.shopName,
      this.shopLevel,
      this.descScore,
      this.brand,
      this.brandId,
      this.brandName,
      this.hotPush,
      this.teamName,
      this.itemLink,
      this.tchaoshi,
      this.detailPics,
      this.dsrScore,
      this.dsrPercent,
      this.shipScore,
      this.shipPercent,
      this.serviceScore,
      this.servicePercent,
      this.subcid,
      this.imgs,
      this.reimgs,
      this.tbcid,
      this.quanMLink,
      this.hzQuanOver,
      this.yunfeixian,
      this.estimateAmount});

  ProductDetailInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    goodsId = json['goodsId'];
    title = json['title'];
    dtitle = json['dtitle'];
    originalPrice = json['originalPrice'];
    actualPrice = json['actualPrice'];
    shopType = json['shopType'];
    goldSellers = json['goldSellers'];
    monthSales = json['monthSales'];
    twoHoursSales = json['twoHoursSales'];
    dailySales = json['dailySales'];
    commissionType = json['commissionType'];
    desc = json['desc'];
    couponReceiveNum = json['couponReceiveNum'];
    couponLink = json['couponLink'];
    couponEndTime = json['couponEndTime'];
    couponStartTime = json['couponStartTime'];
    couponPrice = json['couponPrice'];
    couponConditions = json['couponConditions'];
    activityType = json['activityType'];
    createTime = json['createTime'];
    mainPic = json['mainPic'];
    marketingMainPic = json['marketingMainPic'];
    sellerId = json['sellerId'];
    cid = json['cid'];
    discounts = json['discounts'];
    commissionRate = json['commissionRate'];
    couponTotalNum = json['couponTotalNum'];
    haitao = json['haitao'];
    activityStartTime = json['activityStartTime'];
    activityEndTime = json['activityEndTime'];
    shopName = json['shopName'];
    shopLevel = json['shopLevel'];
    descScore = json['descScore'];
    brand = json['brand'];
    brandId = json['brandId'];
    brandName = json['brandName'];
    hotPush = json['hotPush'];
    teamName = json['teamName'];
    itemLink = json['itemLink'];
    tchaoshi = json['tchaoshi'];
    List pics = json['detailPics'].toString().split(",");
    detailPics = [];
    for (var val in pics) {
      detailPics.add(fixImgUrl(val));
    }
    dsrScore = json['dsrScore'];
    dsrPercent = json['dsrPercent'];
    shipScore = json['shipScore'];
    shipPercent = json['shipPercent'];
    serviceScore = json['serviceScore'];
    servicePercent = json['servicePercent'];
    subcid = json['subcid'].cast<int>();
    List oImgs = json['imgs'].toString().split(',');
    imgs = [];
    for (var val in oImgs) {
      imgs.add(fixImgUrl(val));
    }
    reimgs = json['reimgs'];
    tbcid = json['tbcid'];
    quanMLink = json['quanMLink'];
    hzQuanOver = json['hzQuanOver'];
    yunfeixian = json['yunfeixian'];
    estimateAmount = json['estimateAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['goodsId'] = this.goodsId;
    data['title'] = this.title;
    data['dtitle'] = this.dtitle;
    data['originalPrice'] = this.originalPrice;
    data['actualPrice'] = this.actualPrice;
    data['shopType'] = this.shopType;
    data['goldSellers'] = this.goldSellers;
    data['monthSales'] = this.monthSales;
    data['twoHoursSales'] = this.twoHoursSales;
    data['dailySales'] = this.dailySales;
    data['commissionType'] = this.commissionType;
    data['desc'] = this.desc;
    data['couponReceiveNum'] = this.couponReceiveNum;
    data['couponLink'] = this.couponLink;
    data['couponEndTime'] = this.couponEndTime;
    data['couponStartTime'] = this.couponStartTime;
    data['couponPrice'] = this.couponPrice;
    data['couponConditions'] = this.couponConditions;
    data['activityType'] = this.activityType;
    data['createTime'] = this.createTime;
    data['mainPic'] = this.mainPic;
    data['marketingMainPic'] = this.marketingMainPic;
    data['sellerId'] = this.sellerId;
    data['cid'] = this.cid;
    data['discounts'] = this.discounts;
    data['commissionRate'] = this.commissionRate;
    data['couponTotalNum'] = this.couponTotalNum;
    data['haitao'] = this.haitao;
    data['activityStartTime'] = this.activityStartTime;
    data['activityEndTime'] = this.activityEndTime;
    data['shopName'] = this.shopName;
    data['shopLevel'] = this.shopLevel;
    data['descScore'] = this.descScore;
    data['brand'] = this.brand;
    data['brandId'] = this.brandId;
    data['brandName'] = this.brandName;
    data['hotPush'] = this.hotPush;
    data['teamName'] = this.teamName;
    data['itemLink'] = this.itemLink;
    data['tchaoshi'] = this.tchaoshi;
    data['detailPics'] = this.detailPics;
    data['dsrScore'] = this.dsrScore;
    data['dsrPercent'] = this.dsrPercent;
    data['shipScore'] = this.shipScore;
    data['shipPercent'] = this.shipPercent;
    data['serviceScore'] = this.serviceScore;
    data['servicePercent'] = this.servicePercent;
    data['subcid'] = this.subcid;
    data['imgs'] = this.imgs;
    data['reimgs'] = this.reimgs;
    data['tbcid'] = this.tbcid;
    data['quanMLink'] = this.quanMLink;
    data['hzQuanOver'] = this.hzQuanOver;
    data['yunfeixian'] = this.yunfeixian;
    data['estimateAmount'] = this.estimateAmount;
    return data;
  }
}

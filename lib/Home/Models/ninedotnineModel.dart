class ninedotnineListModel {
  int time;
  int code;
  String msg;
  NDNData data;

  ninedotnineListModel({this.time, this.code, this.msg, this.data});

  ninedotnineListModel.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      time = json['time'];
      code = json['code'];
      msg = json['msg'];
      data = json['data'] != null ? new NDNData.fromJson(json['data']) : null;
    }
  }

}

class NDNData {
  List<productInfoModel> list;
  int totalNum;
  String pageId;

  NDNData({this.list, this.totalNum, this.pageId});

  NDNData.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = new List();
      json['list'].forEach((v) {
        list.add(new productInfoModel.fromJson(v));
      });
    }
    totalNum = json['totalNum'];
    pageId = json['pageId'];
  }

}

class productInfoModel {
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
  String detailPics;
  double dsrScore;
  double dsrPercent;
  double shipScore;
  double shipPercent;
  double serviceScore;
  double servicePercent;
  List<int> subcid;
  int tbcid;
  int quanMLink;
  int hzQuanOver;
  int yunfeixian;
  double estimateAmount;

  productInfoModel(
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
      this.tbcid,
      this.quanMLink,
      this.hzQuanOver,
      this.yunfeixian,
      this.estimateAmount});

  productInfoModel.fromJson(Map<String, dynamic> json) {
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
    detailPics = json['detailPics'];
    dsrScore = json['dsrScore'];
    dsrPercent = json['dsrPercent'];
    shipScore = json['shipScore'];
    shipPercent = json['shipPercent'] < 0? 0:json['shipPercent'];
    serviceScore = json['serviceScore'];
    servicePercent = json['servicePercent'];
    subcid = json['subcid'].cast<int>();
    tbcid = json['tbcid'];
    quanMLink = json['quanMLink'];
    hzQuanOver = json['hzQuanOver'];
    yunfeixian = json['yunfeixian'];
    estimateAmount = json['estimateAmount'] < 0? 0:json['estimateAmount'];
  }
}

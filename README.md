# flutter_mall项目说明

...Flutter商城项目

## 2019-11-10
花了四天时间学习Flutter,然后准备着手做的第一个项目就是这个商城类APP.

用到了swip做轮播图,用provide做状态管理,用screenutil做屏幕适配.

可能后续还会有新的第三方库用上.

下次更新内容:

完成超级分类模块一级页面.

## 2019-11-11

今天早上完成了分类模块的一级页面,顺便把一些导致闪退的bug修复了一下,接下来下午完成个人中心页面(但是没有登录注册等接口...先用假数据吧).

## 2019-11-12

本来打算做个人中心的,发现缺少的数据实在太多就简单部了一个stack层叠视图就搁那了.用了几次Provide后发现,还真是好用啊哈哈

今天主要更新内容:

1.首页顶部appbar增加自定义搜索框

2.使用Fluro增加路由

3.增加商品详情页(/home/productDetail文件夹)

4.修复一些因数据缺失导致的BUG

5.数据重新建模

6.分类模块二级页面完成,增加路由(未实现商品列表页面)

## 2019-11-17更新内容:

1.UI推翻重做(首页布局调整,渐变式appbar,详情页监听滚动视图实现appbar的隐藏显示,分类二级分类修改成网格显示)

2.新增商品列表页面

3.详情页面数据以及功能完善

4.首页增加上拉加载下拉刷新

5.修改成沉浸式的状态栏

6.修复搜索框点击时页面缩进错乱的BUG

7.零七八碎的小东西也改了一堆

## 好用的工具包括插件在这里汇总一下:

网站:

https://javiercbk.github.io/json_to_dart/   json数据转化成dart语言的model

http://www.fluttericon.com/                 flutter的ICON库,可以比较方便的查到对应的ICON NAME

库:

'url_launcher'          支持HTTP/HTTPS/TEL/MAILTO/SMS

'fluro'                 路由

'provide'               状态管理

'flutter_screenutil'    屏幕适配

'flutter_swiper'        轮播图

'flutter_easyrefresh'   上拉下拉刷新

'cached_network_image'  缓存图片

'fluttertoast'          提示框

## 碰到的问题记录一下:

1.首页模块需要用到级联查询接口,类似查询一个热门活动列表后根据活动id查询对应活动商品.

但是如果直接用setstate通知发现会各种出bug,后来使用了futureBuilder才解决.(原因未知,也没查到资料,大概是线程问题吧)

2.singlechildScrollview嵌套listview,也会出BUG,原因是滑动代理会冲突.

3.Container使用了decoration装饰之后不可直接使用color ,需要在decoration里使用.(官方有说明,要么color==null 要么 decoration==null)

4.provide与provider还有providers 傻傻分不清.

5.bug调试没有那么方便.目前的调试只能通过断点,控制台输出的bug信息还没法做到一看就知道问题在哪,所以在开发过程中碰到crash bug时解决效率有点低.

6.使用Swiper必须要设置宽高,否则...

7.expand里就不要设置宽高了,冲突

8.路由跳转如果遇到跳转后bottombar没有消失,可以尝试把跳转传参时的context指定成页面根组件的context.

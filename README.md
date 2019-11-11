# flutter_mall项目说明
在入门了Flutter之后,只想说, 真的好方便好好用.....我可能爱上flutter了!

本人是flutter新手,如果项目中有什么写的不足的地方可以联系我Email:1033839995@qq.com

### /lib/Config //配置信息文件夹

..httpConfig.dart //存储http请求配置信息

..viewConfig.dart //存储视图配置信息

### /lib/Request //请求信息

..httpRequest.dart //接口请求信息以及验签方法

### /lib/Account //个人中心模块以及账号登录等页面

### /lib/Home //首页模块

### /lib/News //分类模块

## 2019-11-10
花了四天时间学习Flutter,然后准备着手做的第一个项目就是这个商城类APP.

用到了swip做轮播图,用provide做状态管理,用screenutil做屏幕适配.

可能后续还会有新的第三方库用上.

下次更新内容:

完成超级分类模块一级页面.

## 2019-11-11

今天早上完成了分类模块的一级页面,顺便把一些导致闪退的bug修复了一下,接下来下午完成个人中心页面(但是没有登录注册等接口...先用假数据吧).

## 碰到的问题记录一下:

1.首页模块需要用到级联查询接口,类似查询一个热门活动列表后根据活动id查询对应活动商品.

但是如果直接用setstate通知发现会各种出bug,后来使用了futureBuilder才解决.(原因未知,也没查到资料,大概是线程问题吧)

2.singlechildScrollview嵌套listview,也会出BUG,原因是滑动代理会冲突.

3.Container使用了decoration装饰之后不可直接使用color ,需要在decoration里使用.(官方有说明,要么color==null 要么 decoration==null)

4.provide与provider还有providers 傻傻分不清.

5.bug调试没有那么方便.目前的调试只能通过断点,控制台输出的bug信息还没法做到一看就知道问题在哪,所以在开发过程中碰到crash bug时解决效率有点低.




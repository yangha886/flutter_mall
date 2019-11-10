# flutter_mall项目说明
在入门了Flutter之后,只想说, 真的好方便好好用.....我可能爱上flutter了!

2019-11-10
花了四天时间学习Flutter,然后准备着手做的第一个项目就是这个商城类APP.
用到了swip做轮播图,用provide做状态管理,用screenutil做屏幕适配.
可能后续还会有新的第三方库用上.
下次更新内容:
完成超级分类模块一级页面.

碰到的问题记录一下:
1.首页模块需要用到级联查询接口,类似查询一个热门活动列表后根据活动id查询对应活动商品.
但是如果直接用setstate通知发现会各种出bug,后来使用了futureBuilder才解决.(原因未知,也没查到资料,大概是线程问题吧)
2.singlechildScrollview嵌套listview,也会出BUG,原因是滑动代理会冲突.
3.Container使用了decoration装饰之后不可直接使用color ,需要在decoration里使用.(官方有说明,要么color==null 要么 decoration==null)
4.provide与provider还有providers 傻傻分不清.
5.bug调试没有那么方便.目前的调试只能通过断点,控制台输出的bug信息还没法做到一看就知道问题在哪,所以在开发过程中碰到crash bug时解决效率有点低.


```
很多文章介绍的差不多
http://www.jianshu.com/p/0acc12c29c1b
http://niorgai.github.io/2016/03/20/Android-transulcent-status-bar/

但都有一个问题 在api 21以上
同时设置
windowTranslucentStatus  
windowDrawsSystemBarBackgrounds 
statusBarColor
是没用的，因为设置了 windowTranslucentStatus 之后就无法改变statusBarColor了,参考 :
http://stackoverflow.com/questions/22192291/how-to-change-the-status-bar-color-in-android
http://stackoverflow.com/questions/27856603/lollipop-draw-behind-statusbar-with-its-color-set-to-transparent



API19 开始有 
windowTranslucentStatus
windowTranslucentNavigation

对应代码
WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS  
WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION
用于设置系统栏透明并让内容可显示于系统栏下
statusbar 的颜色为
API19 从上到下的半透明渐变
API21 以上一般为半透明，但有些系统是完全透明的(魅族)

API21开始有
windowDrawsSystemBarBackgrounds
statusBarColor
navigationBarColor
用于设置系统栏的颜色，可设为透明
不能跟 windowTranslucentStatus 同时使用，不然不起效果
使用 windowDrawsSystemBarBackgrounds 属性后，如果要让界面可显示于系统栏下方，可代码设置
getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_STABLE | View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN);
这时跟 windowTranslucentStatus 很像 (DrawLayout 在设置 fitsSystemWindows 之后，其实就是内部做了添加View.SYSTEM_UI_FLAG_LAYOUT_STABLE | View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN 的处理)，但无法达到 windowTranslucentNavigation 效果 
需要研究一下如何使 Navigation 透明，同时又可以设置颜色(使用 windowTranslucentNavigation 后无法设置颜色)


####重要####
windowTranslucentStatus 以及设置 View.SYSTEM_UI_FLAG_LAYOUT_STABLE | View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
之后都会引起键盘弹出时 adjustResize 无效，只有在布局的顶层View设置了fitsSystemWindows之后才能解决问题(不要在主题中设置 fitsSystemWindows ,这会引起 Toast 的显示不正常，因为主题中的fitsSystemWindows 是针对 Window 的)


DrawLayout
1.通过 setOnApplyWindowInsetsListener 获得 Insets,并返回 consumeSystemWindowInsets,将 Insets 全部消费
2.在 onDraw 时通过之前获取的 Insests 绘制顶部半透明遮罩
3.在 onMeasure 时将 Insets 原样传递给所有子 View,而且在 measure 子 View 时也没有将 Insets 去除，所以相当于 DrawLayout 没有消费 Insets,只是获取了 Insets 的信息用于绘制系统栏区域

NavigationView
1.NavigationView 继承自 ScrimInsetsFrameLayout，ScrimInsetsFrameLayout 通过 setOnApplyWindowInsetsListener 获取 Insets 并返回consumeSystemWindowInsets，将 Insets 全部消费
2.在 draw 时绘制系统栏区域特定颜色
3.NavigationView 中并无法获取 Insets 信息(已被 ScrimInsetsFrameLayout 消费，且相应变量为私有)，在布局时也无法考虑 Insets，所以子 View 是会跑到系统栏下面的，通过 AndroidStudio 自动生成的例子中，
NavigationView 的 header 顶部是通过设置的定死的 padding 来防止 header 内容跑到 statusbar 下面的，通过这个也可看到，api>=21 时 statusbar 高度为 32dp
```

## 微信号：

![WeChat QRCode](https://github.com/Wspace5/SHMultiThreading/blob/master/Pictures/webwxgetmsgimg.jpeg?raw=true)
# 谈iOS多线程（NSThread、NSOperation、GCD）编程
[![Support](https://img.shields.io/badge/support-iOS%207%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios)&nbsp;
[![Travis](https://img.shields.io/travis/rust-lang/rust.svg)]()
[![GitHub release](https://img.shields.io/github/release/qubyte/rubidium.svg)]()
[![Github All Releases](https://img.shields.io/badge/download-3M Total-green.svg)](https://github.com/Wspace5/iOSMultiThreading/archive/master.zip)

![文章配图](https://github.com/Wspace5/SHMultiThreading/blob/master/Pictures/html-programming.jpg?raw=true)

![文章大纲](https://github.com/Wspace5/SHMultiThreading/blob/master/Pictures/SHMultiThreadDG.png?raw=true)
###1.Basic concepts
计算机操作系统都有的基本概念，以下概念简单描述。

1. 进程：一个具有一定独立功能的程序关于某个数据集合的一次运行活动。可以理解成一个运行中的应用程序。
2. 线程：程序执行流的最小单元，线程是进程中的一个实体。
3. 同步：只能在当前线程中按先后顺序依次执行，不开启新线程。
4. 异步：可以在当前线程开启多个新线程执行，可不按顺序执行。
5. 队列：装载线程任务的队形结构。
6. 并发：线程执行可以同时一起进行。
7. 串行：线程执行只能依次逐一先后有序的执行。

***注意 ⚠***
* 一个进程可有多个线程。
* 一个进程可有多个队列。
* 队列可分并发队列和串行队列。

###2.iOS多线程对比
#####1. NSThread
每个NSThread对象对应一个线程，真正最原始的线程。
1)  优点：NSThread 轻量级最低，相对简单。
2)  缺点：手动管理所有的线程活动，如生命周期、线程同步、睡眠等。
#####2. NSOperation 
自带线程管理的抽象类
1)  优点：自带线程周期管理，操作上可更注重自己的逻辑。
2)  缺点：面向对象的抽象类，只能实现它或者使用它定义好的两个子类：NSInvocationOpeartion 和 NSBlockOperation.
#####3. GCD 
Grand Central Dispatch (GCD)是Apple开发的一个多核编程的解决方法。
1)  优点：最高效，避开开发陷阱。
2)  缺点：基于C实现。
#####4. 如何选择 小结
1)  简单而安全多选择NSOperation实现多线程即可；
2)  处理大量并发数据，又追求性能效率的选择GCD；
3)  NSThread本人选择通常是做些小测试上使用，当然也可以基于此写个大程序。

###3.场景选择
1.
###4.使用方法

#####1.NSThread
**1.1) 三种实现开启线程方式：**
①
②
③
④
⑤
⑥
![NSThread多线程加载效果](https://github.com/Wspace5/SHMultiThreading/blob/master/Pictures/SHmultiThread1.gif?raw=true)
![NSOperation多线程加载效果](https://github.com/Wspace5/SHMultiThreading/blob/master/Pictures/SHmultiThread2.gif?raw=true)
![GCD多线程加载效果](https://github.com/Wspace5/SHMultiThreading/blob/master/Pictures/SHmultiThread3.gif?raw=true)

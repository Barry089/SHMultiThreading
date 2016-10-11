## 微信号：

![WeChat QRCode](https://github.com/Wspace5/SHMultiThreading/blob/master/Pictures/webwxgetmsgimg.jpeg?raw=true)
# 谈iOS多线程（NSThread、NSOperation、GCD）编程
[![Support](https://img.shields.io/badge/support-iOS%207%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios)&nbsp;
[![Travis](https://img.shields.io/travis/rust-lang/rust.svg)]()
[![GitHub release](https://img.shields.io/github/release/qubyte/rubidium.svg)]()
[![Github All Releases](https://img.shields.io/badge/download-3M Total-green.svg)](https://github.com/Wspace5/iOSMultiThreading/archive/master.zip)

![文章配图](https://github.com/Wspace5/SHMultiThreading/blob/master/Pictures/html-programming.jpg?raw=true)

![文章大纲](https://github.com/Wspace5/SHMultiThreading/blob/master/Pictures/SHMultiThreadDG.png?raw=true)
###一.Basic concepts  ![Tech: 前面加的#号个数表示字体放大程度](https://github.com/Wspace5/SHMultiThreading)

计算机操作系统都有的基本概念，以下概念简单描述。

1. 进程：一个具有一定独立功能的程序关于某个数据集合的一次运行活动。可以理解成一个运行中的应用程序。
2. 线程：程序执行流的最小单元，线程是进程中的一个实体。
3. 同步：只能在当前线程中按先后顺序依次执行，不开启新线程。
4. 异步：可以在当前线程开启多个新线程执行，可不按顺序执行。
5. 队列：装载线程任务的队形结构。
6. 并发：线程执行可以同时一起进行。
7. 串行：线程执行只能依次逐一先后有序的执行。![Tech warning: 标号的"."后面加个空格就能换行](https://github.com/Wspace5/SHMultiThreading)

***注意 ⚠***
* 一个进程可有多个线程。
* 一个进程可有多个队列。
* 队列可分并发队列和串行队列。

###二.iOS多线程对比
#####1. NSThread
每个NSThread对象对应一个线程，真正最原始的线程。
1) 优点：NSThread 轻量级最低，相对简单。
2) 缺点：手动管理所有的线程活动，如生命周期、线程同步、睡眠等。
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

###三.场景选择
1. **图片异步加载**。这种场景是最常见也是必不可少的。异步加载图片又分成两种，说明一下：
第一种，在UI主线程开启新线程加载图片，加载完成刷新UI；
第二种，依然是在主线程开启新线程，顺序不定的加载图片，加载完成刷新UI。
2. **创作工具上的异步**。这个跟上边任务条度道理
场景一，app本地创作10个章节内容
场景二，app本地创作列表中有3本小说未发表，同时发表创作列表中的3本小说，自然考虑**并行队列执行**发表。

###四.使用方法
第三标题场景选择内容实现 先留下一悬念，具体实现还是先熟知一下各自的API。
#####1.NSThread
**1.1) 三种实现开启线程方式：**
①.动态实例化
 
NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(loadImageSource:) object:imgUrl];
thread.threadPriority = 1; //设置线程的优先级(0.0 - 1.0, 1.0最高优先级)
[thread sstart];

②.静态实例化

[NSThread detachNewThreadSelector:@selector(loadImageSource:) toTarget:self withObject:imgUrl];

③.隐式实例化

[self performSelectorInBackground:@selector(loadImageSource:) withObject:imgUrl];

有了以上的知识点，可以试着编写场景中的“图片加载”的基本功能了。

**1.2) 使用这三种方式编写代码**
    
    //动态创建线程
- (void)dynamicCreateThread {
    [NSThread detachNewThreadSelector:@selector(loadImageSource:) toTarge:self withObject:imgUrl];
}
④
⑤
⑥
![NSThread多线程加载效果](https://github.com/Wspace5/SHMultiThreading/blob/master/Pictures/SHmultiThread1.gif?raw=true)
![NSOperation多线程加载效果](https://github.com/Wspace5/SHMultiThreading/blob/master/Pictures/SHmultiThread2.gif?raw=true)
![GCD多线程加载效果](https://github.com/Wspace5/SHMultiThreading/blob/master/Pictures/SHmultiThread3.gif?raw=true)

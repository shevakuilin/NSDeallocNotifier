#### 一个 NSMapTable strong-weak释放的可行性验证方案

NSMapTable 的 weak 自动释放并不像 Apple 描述的那么可靠(完全可以吐槽并不可靠，无论是weak-strong还是strong-weak亦或是其他类型)，所以参考了一些方案，实现了一个可以令其稳定释放的方案

<b>核心思路：</b>
- 创建一个自定义类 NSDeallocNotifier，该类在实例化构造时接收一个 block 作为参数，并在该类析构 (deinit/dealloc) 时执行该 block.
- 在需要 NSMapTable 添加对象时，实例化一个 NSDeallocNotifier，并在其回调块中执行 NSMapTable 的 remove 方法来删除其中的键/值对，也就是说在 NSDeallocNotifier 释放时，同时释放掉 NSMapTable 中的键/值对.
- 将实例化的 NSDeallocNotifier 以关联对象的方式，添加到键/值对上。保证当 weak 持有的键/值对象被 deinit/dealloc 时，所关联的 NSDeallocNotifier 也将被 deinit/dealloc，从而会触发 block，也就会跟着完全释放 NSMapTable 中的键/值对。




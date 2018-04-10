//
//  总结.h
//  CommonGCDFunc
//
//  Created by Yuan on 2018/4/9.
//  Copyright © 2018年 Yuan. All rights reserved.
//

#ifndef ___h
#define ___h

1.串行队列和并发队列均采用先进先出的顺序执行任务, 故在同一个队列中, 任务是按照顺序执行的
2.对于同步执行和异步执行：同步执行会等待任务结束后再返回，所以同步操作是有序的，它的操作顺序
  就是先进先出准则；异步执行再把任务放入队列后将直接返回而不等待务执行完毕，故异步操作是
  无序的。
3.串并行队列都是先进先出, 同步异步会影响到执行顺序

4.创建队列函数:
  dispatch_queue_create(<#const char * _Nullable label#>, <#dispatch_queue_attr_t  _Nullable attr#>)
  参数A: const char *   类型, 表示队列名称.  eg: const char * queueName = [@"queueName" UTF8String]
  参数B: 表示队列的优先级.  eg: DISPATCH_QUEUE_PRIORITY_HIGH, DISPATCH_QUEUE_PRIORITY_DEFAULT等

5.全局队列:
  dispatch_get_global_queue(<#long identifier#>, <#unsigned long flags#>)
  参数A: 表示队列的优先级
  参数B: 标记是为了未来使用保留的！所以这个参数应该永远指定为0 (文档)

6.栅栏函数:
  (1)栅栏函数不能使用全局并发队列, 必须是自己通过函数创建的并发队列 (文档有强调)

#endif /* ___h */

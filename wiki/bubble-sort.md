# 冒泡排序
> 它重复地走访过要排序的数列，一次比较两个元素，如果他们的顺序错误就把他们交换过来。走访数列的工作是重复地进行直到没有再需要交换，也就是说该数列已经排序完成。
这个算法的名字由来是因为越大的元素会经由交换慢慢“浮”到数列的顶端，故名冒泡排序

## 算法原理
冒泡排序算法的运作如下：（从后往前）
- 比较相邻的元素。如果第一个比第二个大，就交换他们两个。
- 对每一对相邻元素作同样的工作，从开始第一对到结尾的最后一对。在这一点，最后的元素应该会是最大的数。
- 针对所有的元素重复以上的步骤，除了最后一个。
- 持续每次对越来越少的元素重复上面的步骤，直到没有任何一对数字需要比较。

## 算法分析

### 时间复杂度
若文件的初始状态是正序的，一趟扫描即可完成排序。所需的关键字比较次数C和记录移动次数M均达到最小值Cmin = n - 1,Mmin = 0。
所以，冒泡排序最好的时间复杂度为O(n)。
若初始文件是反序的，需要进行n-1趟排序。每趟排序要进行n-i次关键字的比较(1≤i≤n-1)，且每次比较都必须移动记录三次来达到交换记录位置。在这种情况下，比较和移动次数均达到最大值：
- Cmax=n(n-1)/2 = O(n\*n)
- Mmax=3n(n-1)/2 = O(n\*n)

冒泡排序的最坏时间复杂度为O(n\*n)。
综上，因此冒泡排序总的平均时间复杂度为O(n\*n)。

### 算法稳定性
冒泡排序就是把小的元素往前调或者把大的元素往后调。比较是相邻的两个元素比较，交换也发生在这两个元素之间。所以，如果两个元素相等，我想你是不会再无聊地把他们俩交换一下的；如果两个相等的元素没有相邻，那么即使通过前面的两两交换把两个相邻起来，这时候也不会交换，所以相同元素的前后顺序并没有改变，所以冒泡排序是一种稳定排序算法。

```c
//
// Created by zhangrongxiang on 2018/3/4.
//

#include <stdio.h>

void bubble(int arr[], int n) {
    int i = 0, temp;
    for (; i < n - 1; i++) {
        if (arr[i] > arr[i + 1]) {
            temp = arr[i];
            arr[i] = arr[i + 1];
            arr[i + 1] = temp;
        }
    }
}

void bubbleSort(int arr[], int n) {
    int i = 0;
    for (i = n; i >= 1; i--) {
        bubble(arr, i);
    }
}
void bubbleSort2(int arr[], int n) {
    int i = 0, j = 0, temp;
    for (i = n - 1; i > 0; i--) {
        for (j = 0; j < i; j++) {
            if (arr[j] > arr[j + 1]) {
                temp = arr[j + 1];
                arr[j + 1] = arr[j];
                arr[j] = temp;
            }
        }
    }
}
int main() {
    int i = 0;
    int arr[] = {4, 3, 7, 5, 2, 6, 8, 1, 9, 0};
    bubbleSort(arr, 10);
    bubbleSort2(arr, 10);
    for (; i < 10; ++i) {
        printf("%d ", arr[i]);
    }
    return 0;
}
```

```php
<?php
/**
 * Created by PhpStorm.
 * User: zhangrongxiang
 * Date: 2018/3/4
 * Time: 下午7:27
 */
$arr = [ 4, 3, 5, 2, 6, 7, 1, 8 ];

function printArray( array $arr ) {
	$count = count( $arr );
	for ( $i = 0; $i < $count; $i ++ ) {
		echo $arr[ $i ] . ' ';
	}
	echo PHP_EOL;
}

function bubbleSort( array $arr ): array {
	$count = count( $arr );
	for ( $i = $count - 1; $i > 0; $i -- ) {
		for ( $j = 0; $j < $i; $j ++ ) {
			if ( $arr[ $j ] > $arr[ $j + 1 ] ) {
				$temp          = $arr[ $j + 1 ];
				$arr[ $j + 1 ] = $arr[ $j ];
				$arr[ $j ]     = $temp;
			}
		}
	}
	
	return $arr;
}

printArray( bubbleSort( $arr ) );
```

## See
- <https://baike.baidu.com/item/%E5%86%92%E6%B3%A1%E6%8E%92%E5%BA%8F/4602306?fr=aladdin>

### *All rights reserved*
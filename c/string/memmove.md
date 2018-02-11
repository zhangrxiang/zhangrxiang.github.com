# memmove
> - Move block of memory
> - Copies the values of num bytes from the location pointed by source to the memory block pointed by destination. Copying takes place as if an intermediate buffer were used, allowing the destination and source to overlap.
> - The underlying type of the objects pointed by both the source and destination pointers are irrelevant for this function; The result is a binary copy of the data.
> - The function does not check for any terminating null character in source - it always copies exactly num bytes.
> - To avoid overflows, the size of the arrays pointed by both the destination and source parameters, shall be at least num bytes.
> - 从 source 所指向的对象复制 num 个字节到 destination 所指向的对象。两个对象都被转译成 unsigned char 的数组。对象可以重叠：如同复制字符到临时数组，再从该数组到 destination 一般发生复制。
> - 从 source 复制 num 个字符到 destination，但是在重叠内存块这方面，memmove() 是比 memcpy() 更安全的方法。如果目标区域和源区域有重叠的话，memmove() 能够保证源串在被覆盖之前将重叠区域的字节拷贝到目标区域中，复制后源区域的内容会被更改。如果目标区域与源区域没有重叠，则和 memcpy() 函数功能相同。

- 若出现 destination 数组末尾后的访问则行为未定义。
- 若 destination 或 source 为空指针则行为未定义。

```c
void * memmove ( void * destination, const void * source, size_t num );
```

## Parameters
### destination
- Pointer to the destination array where the content is to be copied, type-casted to a pointer of type void*.
- 指向用于存储复制内容的目标数组，类型强制转换为 void* 指针。
- 指向复制目的对象的指针

### source
- Pointer to the source of data to be copied, type-casted to a pointer of type const void*.
- 指向要复制的数据源，类型强制转换为 void* 指针。
- 指向复制来源对象的指针

### num
- Number of bytes to copy.size_t is an unsigned integral type.
- 要被复制的字节数。
- 要复制的字节数

## Return Value
- destination is returned.
- 该函数返回一个指向目标存储区 destination 的指针。
- 返回 destination 的副本，本质为更底层操作的临时内存地址，在实际操作中不建议直接使用此地址，操作完成以后，真正有意义的地址是destination本身。

## Example
```c
//
// Created by zhangrongxiang on 2018/2/10.
//
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

int main() {
    char str[32] = "I am your GOD";
    char str2[32] = "Hello World";
    char str3[] = "void * memmove ( void * destination, const void * source, size_t num );";
    memmove(str2, str, strlen(str));
    printf("%s\n", str2);//I am your GOD
    memmove(str2, "hi\0hi", sizeof(str2));
    printf("%s\n", str2);//hi
    printf("%c%c%c%c\n", str2[3], str2[4], str2[5], str2[6]);//hi\0\0
    memmove(str, str3, sizeof(str) - 1);
    for (int i = 0; i < sizeof(str); ++i) {
        printf("%c", str[i]);
    }//void * memmove ( void * destina%
/////////////////////////////////////////////////////////////////////
    char str4[] = "1234567890";
    puts(str4);//1234567890
    memmove(str4 + 4, str4 + 3, 3); // 从 [4,5,6] 复制到 [5,6,7]
    puts(str4);//1234456890
////////////////////////////////////////////////////////////////////
    // 设置分配的内存的有效类型为 int
    int *p = malloc(3 * sizeof(int));   // 分配的内存无有效类型
    int arr[3] = {1, 2, 3};
    memmove(p, arr, 3 * sizeof(int));     // 分配的内存现在拥有有效类型
    printf("%d%d%d\n", p[0], p[1], p[2]);//123
    printf("%d%d%d\n", *p, *(p + 1), *(p + 2));//123
    return 0;
}
```

## 文章参考
- <http://zh.cppreference.com/w/c/string/byte/memmove>
- <http://www.cplusplus.com/reference/cstring/memmove/>
- <http://www.runoob.com/cprogramming/c-function-memmove.html>

### *转载注明出处*
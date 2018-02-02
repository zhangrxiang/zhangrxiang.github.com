# strncpy
> - Copies the first num characters of source to destination. If the end of the source C string (which is signaled by a null-character) is found before num characters have been copied, destination is padded with zeros until a total of num characters have been written to it.

> - No null-character is implicitly appended at the end of destination if source is longer than num. Thus, in this case, destination shall not be considered a null terminated C string (reading it as such would overflow).

> - 把 src 所指向的字符串复制到 dest，最多复制 n 个字符。当 src 的长度小于 n 时，dest 的剩余部分将用空字节填充。

```c
char *strncpy(char *destination, const char *source, size_t num)
```
## Parameters
### destination
- Pointer to the destination array where the content is to be copied.
- 指向用于存储复制内容的目标数组。

### source
- C string to be copied.
- 要复制的字符串。

### num
- Maximum number of characters to be copied from source.size_t is an unsigned integral type.
- 要从源中复制的字符数。

## Return Value
- destination is returned.
- 该函数返回最终复制的字符串。

> 复制 src 所指向的字符数组的至多 count 个字符（包含空终止字符，但不包含后随空字符的任何字符）到 dest 所指向的字符数组。
 - 若在完全复制整个 src 数组前抵达 count ，则结果的字符数组不是空终止的。
 - 若在复制来自 src 的空终止字符后未抵达 count ，则写入额外的空字符到 dest ，直至写入总共 count 个字符。
 - 若字符数组重叠，若 dest 或 src 不是指向字符数组的指针（包含若 dest 或 src 为空指针），若 dest 所指向的数组大小小于 count ，或若 src 所指向的数组大小小于 count 且它不含空字符，则行为未定义。

## Example
```c
//
// Created by zhangrongxiang on 2017/8/24 14:36.
// Copyright (c) 2017 ZRX . All rights reserved.
//
#include <stdio.h>
#include <string.h>

int main() {
    int i = 0;
    char destination[] = "********************"; // destination串为: "********************0"
    printf("strlen(destination) -> %d\n",strlen(destination)); //strlen(destination) -> 20
    const char *source = "-----";                // source串为:      "-----0"

    /**
     * C/C++中的strncpy()函数功能为将第source串的前n个字符拷贝到destination串，原型为：
     * 1、num<source串的长度（不包含最后的'\0'字符）：
     * 那么该函数将会拷贝source的前num个字符到destination串中（不会自动为destination串加上结尾的'\0'字符）；
     * 2、num=source串的长度（包含最后的'\0'字符）：
     * 那么该函数将会拷贝source的全部字符到destination串中（包括source串结尾的'\0'字符）；
     * 3、num>source串的长度（包含最后的'\0'字符）：
     * 那么该函数将会拷贝source的全部字符到destination串中（包括source串结尾的'\0'字符），
     * 并且在destination串的结尾继续加上'\0'字符，直到拷贝的字符总个数等于num为止。
     */

    strncpy(destination, source, 5 );
//    -----***************
//    destination串为: "-----***************0"
    printf("%s\n",destination);
//
    strncpy( destination, source, 6 );
//    -----
//    destination串为: "-----0**************0"
    printf("%s\n",destination);

    strncpy(destination, source, 10);
//    destination串为: "-----00000**********0"
    printf("-> %s\n", destination);
    printf("sizeof(destination)%d\n", sizeof(destination));//21
    printf("--> %c\n", destination[sizeof(destination) - 2]);//*
    printf("--> %c\n", destination[strlen(destination) - 1]);//-

    for (; i < sizeof(destination); ++i) {
        printf("%d%c\t",i,destination[i]);
    }
//    0-      1-      2-      3-      4-      5       6       7       8       9       10*     11*     12*     13*     14*    15*     16*     17*     18*     19*     20
}

//    char *strncpy(char * __restrict__ _Dest,const char * __restrict__ _Source,size_t _Count) __MINGW_ATTRIB_DEPRECATED_SEC_WARN;
    char string[10]={0};
    char *string2 = "Hello World";
    //_Count < sizeof(string) - 1
    strncpy(string, string2, 2);
    printf("%s\n", string); //He
    memset(string, 0, sizeof(string));
    //_Count > sizeof(string) - 1
    strncpy(string, string2, strlen(string2));
    printf("%s\n", string); // Hello Worldb  结果不可预测
    memset(string, 0, sizeof(string));
    //_Count = sizeof(string) - 1
    strncpy(string, string2, sizeof(string) - 1);
    printf("%s\n", string); //Hello Wor
    
// A simple implementation of strncpy() might be:
    char *
    strncpy(char *dest, const char *src, size_t n)
    {
        size_t i;

        for (i = 0; i < n && src[i] != '\0'; i++)
            dest[i] = src[i];
        for ( ; i < n; i++)
            dest[i] = '\0';

        return dest;
    }
```

## 文章参考
- <http://man7.org/linux/man-pages/man3/strncpy.3.html>
- <http://www.cplusplus.com/reference/cstring/strncpy/>
- <http://zh.cppreference.com/w/c/string/byte/strncpy>
- <http://www.runoob.com/cprogramming/c-function-strncpy.html>
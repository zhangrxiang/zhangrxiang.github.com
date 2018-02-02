# strcpy

> - Copies the C string pointed by source into the array pointed by destination, including the terminating null character (and stopping at that point).
> - To avoid overflows, the size of the array pointed by destination shall be long enough to contain the same C string as source (including the terminating null character), and should not overlap in memory with source.
> - 复制 source 所指向的空终止字节字符串，包含空终止符，到首元素为 destination 所指的字符数组。

- 若 destination 数组长度不足则行为未定义。
- 若字符串覆盖则行为未定义。
- 若 destination 不是指向字符数组的指针或 source 不是指向空终止字节字符串的指针则行为未定义。

```c
char * strcpy ( char * destination, const char * source );
```

## Parameters
### destination
- Pointer to the destination array where the content is to be copied.
- 指向要写入的字符数组的指针

### source
- C string to be copied.
- 指向要复制的空终止字节字符串的指针

## Return Value
- destination is returned.
- 该函数返回一个指向最终的目标字符串 dest 的指针。

## Example
```c
//
// Created by zhangrongxiang on 2018/2/2 15:01
// File strcpy
//

#define __STDC_WANT_LIB_EXT1__ 0

#include <string.h>
#include <stdio.h>
#include <stdlib.h>

int main(void) {
    char *src = "Take the test.";
//  src[0] = 'M' ; // 这会是未定义行为
    char dst[strlen(src) + 1]; // +1 以适应空终止符
    strcpy(dst, src);
    dst[0] = 'M'; // OK
    printf("src = %s\ndst = %s\n", src, dst);

#ifdef __STDC_LIB_EXT1__
    set_constraint_handler_s(ignore_handler_s);
    int r = strcpy_s(dst, sizeof dst, src);
    printf("dst = \"%s\", r = %d\n", dst, r);
    r = strcpy_s(dst, sizeof dst, "Take even more tests.");
    printf("dst = \"%s\", r = %d\n", dst, r);
#endif

    char string[10];
    char str[] = "Hello World";
    char *string2 = str;
    printf("%s\n", string2); //Hello World\0

    printf("%d\n", (int) sizeof(string)); //10
    printf("%d\n", (int) strlen(string)); //0

    printf("%d\n", (int) sizeof(string2)); //8
    printf("%d\n", (int) strlen(string2)); //11

    printf("%d\n", (int) sizeof(str)); //12
    printf("%d\n", (int) strlen(str)); //11

    /******************行为未定义********************************/
    /** strcpy(string, string2);*/
    /** printf("%s\n", string);*/
    /** printf("%s\n", string2);*/
    /***********************************************************/

    char str2[sizeof(str)];
    strcpy(str2, string2);
    printf("%s\n", str2); //Hello World\0
    strcpy(str2, "hi");
    printf("%s\n", str2); //hi\0
    //strcpy(str2, "everything is file"); //strcpy.c:53:5: warning: '__builtin_memcpy' writing 19 bytes into a region of size 12 overflows the destination [-Wstringop-overflow=]
    //printf("%s\n", str2); //everything is file

    char str3[] = "hello world!\0hello everyone";
    printf("%s\n", str3); //hello world!
    printf("%d\n", (int) strlen(str3)); //12
    printf("%d\n", (int) sizeof(str3)); // 28

    return EXIT_SUCCESS;
}
```
## 文章参考
- <http://www.cplusplus.com/reference/cstring/strcpy/>
- <http://zh.cppreference.com/w/c/string/byte/strcpy>
- <http://www.runoob.com/cprogramming/c-function-strcpy.html>
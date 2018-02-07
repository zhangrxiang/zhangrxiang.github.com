# strlen
> - Returns the length of the C string str.
> - The length of a C string is determined by the terminating null-character: A C string is as long as the number of characters between the beginning of the string and the terminating null character (without including the terminating null character itself).
> - 返回给定空终止字符串的长度，即首元素为 str 所指，且不包含首个空字符的字符数组中的字符数。
> - 计算字符串 str 的长度，直到空结束字符，但不包括空结束字符。

- 若 str 不是指向空终止字节字符串的指针则行为未定义。
```c
size_t strlen( const char *str );
```

## Parameters
### str
- C string.
- 要计算长度的字符串。

## Return Value
- The length of string. 
- 该函数返回字符串的长度。

## Example
```c
//
// Created by zhangrongxiang on 2018/2/7 10:41
// File strlen
//

#include <stdio.h>
#include <string.h>

//Software is like sex: it"s better when it"s free.
//My name is Linus, and I am your God
//Linux is obsolete.
//Linux is not Unix

int main() {
    char *str = "My name is Linus, and I am your God";
    size_t length = strlen(str);
    printf("%s --> length is %d\n", str, (int) length);

    char *str2 = "一切皆文件";
    length = strlen(str2);
    printf("%s  -- length --> %d\n", str2, (int) length); //15 = 3 * 15
    printf("%s  -- sizeof --> %d\n", str2, (int) sizeof("一切皆文件")); //16 = 3 * 5 + 1

    char str3[] = "万物皆对象";
    printf("%s  -- sizeof --> %d\n", str3, (int) sizeof(str3)); //16 = 3 * 5 + 1

    return 0;
}
```

## 文章参考
- <http://zh.cppreference.com/w/c/string/byte/strlen>
- <http://www.cplusplus.com/reference/cstring/strlen/> 
- <http://www.runoob.com/cprogramming/c-function-strlen.html>
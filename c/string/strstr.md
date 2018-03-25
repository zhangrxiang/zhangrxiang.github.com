# strstr
> - Returns a pointer to the first occurrence of str2 in str1, or a null pointer if str2 is not part of str1.
> - 查找 substr 所指的空终止字节字符串在 str 所指的空终止字节字符串中的首次出现。不比较空终止字符。

- 若 str 或 substr 不是指向空终止字节字符串的指针，则行为未定义。
```c
char *strstr(const char *haystack, const char *needle)
```

## Parameters
### haystack
- C string to be scanned.
- 要被检索的 C 字符串。

### needle
- C string containing the sequence of characters to match.
-  在 haystack 字符串内要搜索的小字符串。

## Return Value
- A pointer to the first occurrence in str1 of the entire sequence of characters specified in str2, or a null pointer if the sequence is not present in str1.
- 该函数返回在 haystack 中第一次出现 needle 字符串的位置，如果未找到则返回 null。

## Example
```c
//
// Created by zhangrongxiang on 2017/8/15 14:15.
// Copyright (c) 2017 ZRC . All rights reserved.
//

//#include <syslib.h>
#include <string.h>
#include <stdio.h>

//C 库函数 char *strstr(const char *haystack, const char *needle) 在字符串 haystack 中查找第一次出现字符串 needle 的位置，不包含终止符 '\0'。

void find_str(char const *str, char const *substr) {
    char *pos = strstr(str, substr);
    if (pos) {
        printf("found the string '%s' in '%s' at position: %ld; result: %s\n", substr, str, pos - str, pos);
    } else {
        printf("the string '%s' was not found in '%s'\n", substr, str);
    }
}

int main() {
    char *s = "GoldenGlobalView";
    char *l = "lob";
    char *p;
    //返回值：若str2是str1的子串，则返回str2在str1的首次出现的地址；
    // 如果str2不是str1的子串，则返回NULL。
    p = strstr(s, l);
    if (p)
        //lobalView
        printf("%s\n", p);
    else
        printf("NotFound!\n");

    char *str = "one two three";
    find_str(str, "two"); //found the string 'two' in 'one two three' at position: 4; result: two three
    find_str(str, ""); // found the string '' in 'one two three' at position: 0; result: one two three
    find_str(str, "nine");// the string 'nine' was not found in 'one two three'
    find_str(str, "n"); // found the string 'n' in 'one two three' at position: 1; result: ne two three

    char str2[] = "This is a simple string";
    char *pch;
    pch = strstr(str2, "simple");
    strncpy (pch, "sample", 6);
    puts(str2);//This is a sample string
    puts(pch);//sample string

    return 0;
}
```

## 文章参考
- <http://www.cplusplus.com/reference/cstring/strstr/>
- <http://www.runoob.com/cprogramming/c-function-strstr.html>
- <http://zh.cppreference.com/w/c/string/byte/strstr>
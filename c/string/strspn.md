# strspn
> - Returns the length of the initial portion of str1 which consists only of characters that are part of str2.
> - The search does not include the terminating null-characters of either strings, but ends there.
> - 检索字符串 dest 中**第一个**不在字符串 src 中出现的字符下标。返回 dest 所指向的空终止字节串的最大起始段（ span ）长度，段仅由 src 所指向的空终止字节字符串中找到的字符组成。

- 若 dest 或 src 不是指向空终止字节字符串的指针，则行为未定义。

```c
size_t strspn( const char *dest, const char *src );
```

## Parameters
### dest
- C string to be scanned.
- 指向要分析的空终止字节字符串的指针

### src
- C string containing the characters to match.
- 指向含有要搜索的字符的空终止字节字符串的指针

## Return value
- The length of the initial portion of str1 containing only characters that appear in str2.
Therefore, if all of the characters in str1 are in str2, the function returns the length of the entire str1 string, and if the first character in str1 is not in str2, the function returns zero.
size_t is an unsigned integral type.

- 仅由来自 src 所指向的空终止字节字符串的字符组成的最大起始段长度。
- 该函数返回 dest 中第一个不在字符串 src 中出现的字符下标。

## Example
```c
//
// Created by zhangrongxiang on 2018/2/5 17:28
// File strspn
//

#include <stdio.h>
#include <string.h>

//C 库函数 size_t strspn(const char *str1, const char *str2) 检索字符串 str1 中第一个不在字符串 str2 中出现的字符下标。

int main() {
    size_t len;
    const char str1[] = "ABCDEFG02018ABCDEFG02018";
    const char str2[] = "ABCD";
    const char str3[] = "2018";
    const char str4[] = "AB";
    const char str5[] = "AC";
    const char str6[] = "aC";
    len = strspn(str1, str2);
    printf("%d\n", (unsigned int) len); //4
    len = strspn(str1, str3);
    printf("%d\n", (unsigned int) len); //0
    len = strspn(str1, str4);
    printf("%d\n", (unsigned int) len); //2
    len = strspn(str1, str5);
    printf("%d\n", (unsigned int) len); //1
    len = strspn(str1, str6);
    printf("%d\n", (unsigned int) len); //0

    char strtext[] = "129th";
    char cset[] = "1234567890";

    len = strspn(strtext, cset);
    printf("The initial number has %d digits.\n", (int) len);//3

    const char *string = "abcde312$#@";
    const char *low_alpha = "qwertyuiopasdfghjklzxcvbnm";

    len = strspn(string, low_alpha);
    printf("%d\n",(int)len);//5
    //After skipping initial lowercase letters from 'abcde312$#@'
    printf("After skipping initial lowercase letters from '%s'\n"
               "The remainder is '%s'\n", string, string + len);//The remainder is '312$#@'

    return (0);
}
```
## 参考文章
- <http://www.runoob.com/cprogramming/c-function-strspn.html>
- <http://www.cplusplus.com/reference/cstring/strspn/>
- <http://zh.cppreference.com/w/c/string/byte/strspn>
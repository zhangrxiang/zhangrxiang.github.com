# isalpha

```c
int isalpha ( int c );
```
> - Checks whether c is an alphabetic letter.
> - 检查给定字符是否字母字符，即是大写字母（ ABCDEFGHIJKLMNOPQRSTUVWXYZ ）或小写字母（ abcdefghijklmnopqrstuvwxyz ）。

在异于 "C" 的本地环境中，字母字符是 `isupper()` 或 `islower()` 对其返回非零值的字符，或任何其他被本地环境认为是字母的字符。任何情况下， `iscntrl()` 、 `isdigit()` 、 `ispunct()` 及 `isspace()` 将对此字符返回零。

若 ch 的值不能表示为 `unsigned char` 且不等于 `EOF` ，则行为未定义。

## Parameters
### c
- Character to be checked, casted to an int, or EOF.
- c	-	要分类的字符

## Return Value
- A value different from zero (i.e., true) if indeed c is an alphabetic letter. Zero (i.e., false) otherwise.
- 若字符为字母字符则为非零值，否则为零。

## Example
```c
//
// Created by zhangrongxiang on 2018/2/1 14:54
// File isalpha
//

#include <ctype.h>
#include <stdio.h>
#include <locale.h>

int main(void) {
    unsigned char c = '\xdf'; // ISO-8859-1 的德文字母 ß
    printf("isalpha('\\xdf') in default C locale returned %d\n", !!isalpha(c));  //0
    setlocale(LC_CTYPE, "de_DE.iso88591");
    printf("isalpha('\\xdf') in ISO-8859-1 locale returned %d\n", !!isalpha(c));//0

    int i = 0;
    char str[] = "I Love My Country!!";
    while (str[i]) {
        if (isalpha(str[i])) printf("character %c is alphabetic\n", str[i]);
        else printf("character %c is not alphabetic\n", str[i]);
        i++;
    }
    return 0;
}
```

## 文章参考
- <http://www.cplusplus.com/reference/cctype/isalpha/>
- <http://zh.cppreference.com/w/c/string/byte/isalpha>

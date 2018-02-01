# iscntrl

```c
int iscntrl ( int c );
```
> - Check if character is a control character
> - 检查给定字符是否为控制字符，即编码 0x00-0x1F 及 0x7F 。

若 c 的值不能表示为 unsigned char 且不等于 EOF ，则行为未定义。

## Parameters
### c
- Character to be checked, casted as an int, or EOF.
- c	-	要分类的字符

## Return Value
- A value different from zero (i.e., true) if indeed c is a control character. Zero (i.e., false) otherwise.
- 若字符为控制字符则为非零，否则为零。

## Example
```c
//
// Created by zhangrongxiang on 2018/2/1 15:14
// File iscntrl
//

#include <stdio.h>
#include <ctype.h>
#include <locale.h>

int main() {
    unsigned char c = '\x94'; // ISO-8859-1 的控制码 CCH
    printf("In the default C locale, \\x94 is %sa control character\n",
           iscntrl(c) ? "" : "not ");
    //In the default C locale, \x94 is not a control character
    setlocale(LC_ALL, "en_GB.iso88591");
    printf("In ISO-8859-1 locale, \\x94 is %sa control character\n",
           iscntrl(c) ? "" : "not ");

    int i = 0;
    char str[] = "first line \n second line \n";
    while (!iscntrl(str[i])) {
        putchar(str[i]);
        i++;
    }
    //first line
    return 0;
}

```

## 文章参考
- <http://zh.cppreference.com/w/c/string/byte/iscntrl>
- <http://www.cplusplus.com/reference/cctype/iscntrl/>
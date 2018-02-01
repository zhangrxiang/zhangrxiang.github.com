# isalnum

```c
int isalnum ( int c );
```
> - Checks whether c is either a decimal digit or an uppercase or lowercase letter.
> - 检查给定的字符是否为当前 C 本地环境所分类的字母数字字符。在默认本地环境中，下列字符为字母数字：
    - 数字（ 0123456789 ）
    - 大写字母（ ABCDEFGHIJKLMNOPQRSTUVWXYZ ）
    - 小写字母（ abcdefghijklmnopqrstuvwxyz ）
若 c 的值不能表示为 unsigned char 且不等于 EOF ，则行为未定义。

## Parameters
### c
- Character to be checked, casted as an int, or EOF.
- c	-	要分类的字符

## Return Value
- A value different from zero (i.e., true) if indeed c is either a digit or a letter. Zero (i.e., false) otherwise.
- 若字符为字母数字字符，则为非零，否则为 0 。

## Example
```c
//
// Created by zhangrongxiang on 2018/1/31 13:33
// File isalnum
//

#include <stdio.h>
#include <ctype.h>
#include <locale.h>

/*isalnum*/

int main(void) {

  ///////////////////////////////////////////////////////////////////////////////////
  unsigned char c = '\xdf'; // ISO-8859-1 中的德文字母 ß
  printf("isalnum('\\xdf') in default C locale returned %d\n", c, !!isalnum(c));
  if (setlocale(LC_CTYPE, "de_DE.iso88591"))
    printf("isalnum('\\xdf') in ISO-8859-1 locale returned %d\n", !!isalnum(c));
  if (setlocale(LC_CTYPE, "en_US.UTF-8"))
    //isalnum('\xdf') in UTF-8 locale returned 0
    printf("isalnum('\\xdf') in UTF-8 locale returned %d\n", !!isalnum(c));


  ///////////////////////////////////////////////////////////////////////////////////
  int var1 = 'd';
  int var2 = '2';
  int var3 = '\t';
  int var4 = ' ';

  if (isalnum(var1)) {
    printf("var1 = |%c| 是字母数字\n", var1);
  } else {
    printf("var1 = |%c| 不是字母数字\n", var1);
  }
  if (isalnum(var2)) {
    printf("var2 = |%c| 是字母数字\n", var2);
  } else {
    printf("var2 = |%c| 不是字母数字\n", var2);
  }
  if (isalnum(var3)) {
    printf("var3 = |%c| 是字母数字\n", var3);
  } else {
    printf("var3 = |%c| 不是字母数字\n", var3);
  }
  if (isalnum(var4)) {
    printf("var4 = |%c| 是字母数字\n", var4);
  } else {
    printf("var4 = |%c| 不是字母数字\n", var4);
  }
//  var1 = |d| 是字母数字
//  var2 = |2| 是字母数字
//  var3 = |	| 不是字母数字
//  var4 = | | 不是字母数字

  ///////////////////////////////////////////////////////////////////////////////////
  int i;
  char str[] = "c3po...";
  i = 0;
  while (isalnum(str[i])) i++;
  //The first 4 characters are alphanumeric.
  printf("The first %d characters are alphanumeric.\n", i);
  return 0;

}

```

## 文章参考
- <http://zh.cppreference.com/w/c/string/byte/isalnum>
- <http://www.cplusplus.com/reference/cctype/isalnum/>
- <http://www.runoob.com/cprogramming/c-function-isalnum.html>
# strcat

> - Appends a copy of the source string to the destination string. The terminating null character in destination is overwritten by the first character of source, and a null-character is included at the end of the new string formed by the concatenation of both in destination.

> - 后附 src 所指向的空终止字节字符串的副本到 dest 所指向的空终止字节字符串的结尾。字符 src[0] 替换 dest 末尾的空终止符。产生的字节字符串是空终止的。

- 若目标数组对于 src 和 dest 的内容以及空终止符不够大，则行为未定义。
- 若字符串重叠，则行为未定义。
- 若 dest 或 src 不是指向空终止字节字符串的指针，则行为未定义。

```c
char * strcat ( char * destination, const char * source );
```

## Parameters
### destination
- Pointer to the destination array, which should contain a C string, and be large enough to contain the concatenated resulting string.
- 指向要后附到的空终止字节字符串的指针

### source
- C string to be appended. This should not overlap destination.
- 指向作为复制来源的空终止字节字符串的指针

## Return Value
- destination is returned.
- 该函数返回一个指向最终的目标字符串 dest 的指针。

## Example
```c
//
// Created by 张荣响 on 2018/2/3.
//

#include <stdio.h>
#include <string.h>

int main() {
  char str[] = "Hello C";
  char str2[50] = "Hello World";
  printf("%s\n", str);//Hello C
  printf("%s\n", str2);//Hello World
  char *str3 = strcat(str2, str);
  printf("%s\n", str2);//Hello WorldHello C
  printf("%s\n", str3);//Hello WorldHello C
  str3 = "hi everyone";
  printf("%s\n", str3);//hi everyone
  printf("%s\n", str2);//Hello WorldHello C
  str2[2] = 'L';
  str[2] = 'L';
  str[0] = 'h';
  printf("%s\n", str2);//HeLlo WorldHello C
  printf("%s\n", str);//heLlo C

  char *str4 = "hi world";
//  str[0] = 'H'; //行为为定义 h
  printf("%c\n",str4[0]);//h
  printf("%s\n",str4);

  char str5[80];
  strcpy (str5,"these ");
  strcat (str5,"strings ");
  strcat (str5,"are ");
  strcat (str5,"concatenated.");
  puts (str5);
  //these strings are concatenated.

  return 0;
}
```
## 文章参考
- <http://www.cplusplus.com/reference/cstring/strcat/>
- <http://zh.cppreference.com/w/c/string/byte/strcat>
- <https://linux.die.net/man/3/strcat>
# strpbrk
> - Locate characters in string,Returns a pointer to the first occurrence in str1 of any of the characters that are part of str2, or a null pointer if there are no matches.
> - The search does not include the terminating null-characters of either strings, but ends there.
> - 在 dest 所指向的空终止字节串中，扫描来自 breakset 所指向的空终止字节串的任何字符，并返回指向该字符的指针。
> - 检索字符串 dest 中第一个匹配字符串 breakset 中字符的字符，不包含空结束字符。也就是说，依次检验字符串 dest 中的字符，当被检验字符在字符串 breakset 中也包含时，则停止检验，并返回该字符位置。

- 若 dest 或 breakset 不是指向空终止字节字符串的指针则行为未定义。

```c
char* strpbrk( const char* dest, const char* breakset );
```

## Parameters
### dest
- C string to be scanned.
- 指向要分析的空终止字节字符串的指针

### breakset
- C string containing the characters to match.
- 指向含要搜索的字符的空终止字节字符串的指针

## Return Value
- A pointer to the first occurrence in str1 of any of the characters that are part of str2, or a null pointer if none of the characters of str2 is found in str1 before the terminating null-character.If none of the characters of str2 is present in str1, a null pointer is returned.
- 指向 dest 中首个亦在 breakset 中的字符的指针，或若这种字符不存在则为空指针。
- 该函数返回 dest 中第一个匹配字符串 breakset 中字符的字符数，如果未找到字符则返回 NULL。

> 名称代表“字符串指针打断 (string pointer break) ”，因为它返回指向首个分隔符（“打断”）的指针。

## Example
```c
//
// Created by zhangrongxiang on 2018/2/6 11:18
// File strpbrk
//

#include <stdio.h>
#include <string.h>

//依次检验字符串 str1 中的字符，当被检验字符在字符串 str2 中也包含时，则停止检验，并返回该字符位置。
//检索字符串 str1 中第一个匹配字符串 str2 中字符的字符，不包含空结束字符。
int main() {
    int i = 0;
    const char str1[] = "abcde2fghi3jk4l";
    const char str2[] = "34";
    const char *str3 = "Life is short,I use C";
    char *ret;

    ret = strpbrk(str1, str2);
    if (ret) {
        printf("Number one is : %c\n", *ret);//3
    } else {
        printf("No");
    }

    ret = strpbrk(str1, str3);
    if (ret) {
        printf("Number one is : %c\n", *ret);//e
    } else {
        printf("No");
    }
    printf("\n");
    size_t len = strlen(str1);
    char *ch = 0;
    int index = 0;
    char all[20] = {0};

    //获取两个字符串的字符交集
    for (; i < len; ++i) {
        ret = strpbrk((str1 + sizeof(char) * (index + 1)), str3);
        if (ret) {
            ch = strrchr(str1, *ret);
            index = (int) (ch - str1);
            printf("Number one is : %c\n", *ret);
            all[i] = *ret;
        } else {
            printf("No");
        }
    }
    printf("\n");
    for (i = 0; i < 20; ++i) {
        if (all[i] == 0)
            break;
        printf("%c ", all[i]); //e f h i
    }
    printf("\n");
    //单词统计
    const char *str = "hello world, friend of mine!";
    const char *sep = " ,!";

    unsigned int cnt = 0;
    do {
        str = strpbrk(str, sep); // 寻找分隔符
//        printf("%s\n",str);
        if (str){
            str += strspn(str, sep); // 跳过分隔符
            printf("%s\n",str);
        }
        ++cnt; // 增加词计数
    } while (str && *str);

    printf("There are %d words\n", cnt); // 5

    return 0;
}
```
## 文章参考
- <http://zh.cppreference.com/w/c/string/byte/strpbrk>
- <http://www.cplusplus.com/reference/cstring/strpbrk/>
- <http://www.runoob.com/cprogramming/c-function-strpbrk.html>
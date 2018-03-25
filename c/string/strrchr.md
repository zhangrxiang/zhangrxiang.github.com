# strrchr

> - Locate last occurrence of character in string, Returns a pointer to the last occurrence of character in the C string str.
> - The terminating null-character is considered part of the C string. Therefore, it can also be located to retrieve a pointer to the end of a string.
> - 寻找 ch （如同用 (char)ch 转换到 char 后）在 str 所指向的空终止字节串中（将每个字符转译成 unsigned char ）的最后出现。若搜索 '\0' ，则认为终止空字符为字符串的一部分，而且能找到。
> -C 库函数 char *strrchr(const char *str, int c) 在参数 str 所指向的字符串中搜索最后一次出现字符 c（一个无符号字符）的位置。

- 若 str 不是指向空终止字节串的指针，则行为未定义。
```c
char *strrchr( const char *str, int ch );
```

## Parameters
### str
- C string.
- 指向要分析的空终止字节字符串的指针

### character
- Character to be located. It is passed as its int promotion, but it is internally converted back to char.
- 要搜索的字符
- 要搜索的字符。以 int 形式传递，但是最终会转换回 char 形式。

## Return Value
- A pointer to the last occurrence of character in str.If the character is not found, the function returns a null pointer.
- 指向 str 中找到的字符的指针，或若找不到这种字符则为空指针。
- 该函数返回 str 中最后一次出现字符 c 的位置。如果未找到该值，则函数返回一个空指针。

## Example
```c
//
// Created by zhangrongxiang on 2018/2/6 9:12
// File strrchr
//

#include <stdio.h>
#include <string.h>

//该函数返回 str 中最后一次出现字符 c 的位置。如果未找到该值，则函数返回一个空指针。
int main() {
    const char str[] = "https://github.com/zhangrxiang/learn-c";
    const char str2[] = "D:\\WorkSpace\\clionProjects\\learn-c\\string\\strrchr.c";
    const char ch = '/';
    const char ch2 = '\\';
    char *ret;

    ret = strrchr(str, ch);
//    |/| ------ |/learn-c|
    printf("|%c| ------ |%s|\n", ch, ret);
    printf("%c\n", ret[0]);// /
    printf("%ld\n", ret - str + 1);//number 31
    printf("%ld\n", ret - str);//index 30

    ret = strrchr(str2, ch2);
//    |\| ------ |\strrchr.c|
    printf("|%c| ------ |%s|\n", ch2, ret);
    printf("%c\n", ret[0]); /*** \ */
    printf("%c\n", str2[ret - str2]);/*** \ */
    printf("%ld\n", ret - str2 + 1);//42
    printf("%d\n", (int) strlen(ret));//10
    printf("%s\n", ret + 1);//strrchr.c
    printf("%c\n", *ret); /***   \   */
    printf("%c\n", *(ret + sizeof(char)));//s
    printf("%c\n", *(ret + sizeof(char) * 2));//t
    printf("%s\n", &(*ret));// \strrchr.c
    printf("%s\n", &*(ret + sizeof(char)));//strrchr.c

    ret = strrchr(str,'A');
    if (ret){
        printf("exists A\n");
    } else{
//        no exists A
        printf("no exists A\n");
    }
    return 0;
}
```

## 参考文章
- <http://www.cplusplus.com/reference/cstring/strrchr/>
- <http://zh.cppreference.com/w/c/string/byte/strrchr>
- <http://www.runoob.com/cprogramming/c-function-strrchr.html>
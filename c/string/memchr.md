# memchr
> - Locate character in block of memory,Searches within the first num bytes of the block of memory pointed by ptr for the first occurrence of ch (interpreted as an unsigned char), and returns a pointer to it.
> - 在参数 ptr 所指向的字符串的前 count 个字节中搜索第一次出现字符 ch（一个无符号字符）的位置。
> - Both ch and each of the bytes checked on the the ptr array are interpreted as unsigned char for the comparison.
> - 在 ptr 所指向对象的首 count 个字符（每个都转译成 unsigned char ）中寻找 ch （在如同以 (unsigned char)ch 转换到 unsigned char 后）的首次出现。

- 若访问出现于被搜索的数组结尾后，则行为未定义。
- 若 ptr 为空指针则行为未定义。
- 此函数表现如同它按顺序读取字符，并立即于找到匹配的字符时停止：
    - 若 ptr 所指向的字符数组小于 count ，但在数组中找到匹配，则行为良好定义。

```c
void* memchr( const void* ptr, int ch, size_t count );
```

## Parameters
### ptr
- Pointer to the block of memory where the search is performed.
- 指向要检验的对象的指针

### ch
- ch to be located. The ch is passed as an int, but the function performs a byte per byte search using the unsigned char conversion of this ch.
- 要搜索的字符
- 以 int 形式传递的值，但是函数在每次字节搜索时是使用该值的无符号字符形式。

### count
- Number of bytes to be analyzed,size_t is an unsigned integral type.
- 要检验的最大字符数

## Return Value
- A pointer to the first occurrence of ch in the block of memory pointed by ptr.
If the ch is not found, the function returns a null pointer.
- 指向字符位置的指针，或若找不到该字符则为 NULL 。
- 该函数返回一个指向匹配字节的指针，如果在给定的内存区域未出现字符，则返回 NULL。

## Example
```c
//
// Created by zhangrongxiang on 2018/2/8 14:10
// File memchr
//

//C 库函数 void *memchr(const void *str, int c, size_t n)
// 在参数 str 所指向的字符串的前 n 个字节中搜索第一次出现字符 c（一个无符号字符）的位置。

#include <string.h>
#include <stdio.h>

int main() {
    //字符串
    char str[] = "I am your God";
    //数组
    int arr[] = {10, 20, 30, 40, 50, 60, 70, 80, 90};
    char *position = (char *) memchr(str, 'y', strlen(str));
    if (position) {
        printf("%s\n", position);//your God
        printf("%d\n", (int) (position - str));//5
        printf("%c\n", str[position - str]); //y
    } else {
        printf("null\n");
    }
    int *pInt = (int *) memchr(arr, 50, sizeof(arr));
    printf("%d\n", *pInt);//50
    printf("%c\n", *pInt);//2
    printf("%c\n", (unsigned char) 50); //2
    printf("%c\n", (char) 50); //2
    printf("%c\n", 50);//2
    printf("%c\n", (unsigned char) 51); // 3

    return 0;
}
```
## 文章参考
- <http://www.cplusplus.com/reference/cstring/memchr/>
- <http://zh.cppreference.com/w/c/string/byte/memchr>
- <http://www.runoob.com/cprogramming/c-function-memchr.html>
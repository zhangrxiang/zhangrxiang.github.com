# memcpy
> - Copy block of memory
> - Copies the values of num bytes from the location pointed to by source directly to the memory block pointed to by destination.
> - The underlying type of the objects pointed to by both the source and destination pointers are irrelevant for this function; The result is a binary copy of the data.
> - The function does not check for any terminating null character in source - it always copies exactly num bytes.
> - To avoid overflows, the size of the arrays pointed to by both the destination and source parameters, shall be at least num bytes, and should not overlap (for overlapping memory blocks, memmove is a safer approach).
> - 从存储区 source 复制 num 个字符到存储区 destination
> - 从 source 所指向的对象复制 num 个字符到 destination 所指向的对象。两个对象都被转译成 unsigned char 的数组。

- 若访问发生在 destination 数组结尾后则行为未定义。

```c
void * memcpy ( void * destination, const void * source, size_t num );
```

## Parameters
### destination
- Pointer to the destination array where the content is to be copied, type-casted to a pointer of type void*.
- 指向要复制的对象的指针
- 指向用于存储复制内容的目标数组，类型强制转换为 void* 指针。

### source
- Pointer to the source of data to be copied, type-casted to a pointer of type const void*.
- 指向复制来源对象的指针
- 指向要复制的数据源，类型强制转换为 void* 指针。

### num
- Number of bytes to copy.
- 指向复制来源对象的指针
- size_t is an unsigned integral type.

## Return Value
- destination is returned.
- 复制的字节数

```c
//
// Created by zhangrongxiang on 2018/2/9 10:32
// File memcpy
//
#include <stdio.h>
#include <stdint.h>
#include <inttypes.h>
#include <string.h>
#include <stdlib.h>

struct {
    char name[40];
    int age;
} person, person_copy;

//C 库函数 void *memcpy(void *str1, const void *str2, size_t n) 从存储区 str2 复制 n 个字符到存储区 str1。
int main() {

    int i = 0;
// 简单用法
    char source[] = "once upon a midnight dreary...", dest[4];
    memcpy(dest, source, sizeof dest);
    //printf("%s\n", dest);//未定义，不含\0
    //printf("length -> %d\n", (int) strlen(dest));
    for (i = 0; i < sizeof dest; ++i)
        putchar(dest[i]);

    printf("\n");
// 设置分配的内存的有效类型为 int
    int *p = malloc(3 * sizeof(int));   // 分配的内存无有效类型
    int arr[3] = {5, 2, 3};
    memcpy(p, arr, 3 * sizeof(int));      // 分配的内存现在拥有有效类型
    for (i = 0; i < 3; ++i) {
        printf("%d == %d \n", *(p + i), p[i]);
    }

///////////////////////////////////////////////////////////////////////////////////////////
// reinterpreting data
    double d = 0.1;
//    int64_t n = *(int64_t*)(&d); // 严格别名使用违规
    int64_t n;
    memcpy(&n, &d, sizeof d); // OK
    printf("\n%a is %" PRIx64 " as an int64_t\n", d, n);

////////////////////////////////////////////////////////////////////////////////////////////
    char myname[] = "Pierre de Fermat";

    /* using memcpy to copy string: */
    memcpy(person.name, myname, strlen(myname) + 1);
    person.age = 46;
    /* using memcpy to copy structure: */
    memcpy(&person_copy, &person, sizeof(person));
    printf("person_copy: %s, %d \n", person_copy.name, person_copy.age);

    return 0;
}
```

## 文章参考
- <http://www.cplusplus.com/reference/cstring/memcpy/>
- <http://zh.cppreference.com/w/c/string/byte/memcpy>
- <http://www.runoob.com/cprogramming/c-function-memcpy.html>
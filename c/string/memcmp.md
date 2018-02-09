# memcmp
> - Compare two blocks of memory.
> - Compares the first num bytes of the block of memory pointed by ptr1 to the first num bytes pointed by ptr2, returning zero if they all match or a value different from zero representing which is greater if they do not.
> Notice that, unlike strcmp, the function does not stop comparing after finding a null character.
> -  把存储区 lhs 和存储区   的前 count 个字节进行比较。
> - 比较 lhs 和 rhs 所指向对象的首 count 个字节。比较按字典序进行。
> - 结果的符号是在被比较对象中相异的首对字节的值（都转译成 unsigned char ）的差。

- 若在 lhs 和 rhs 所指向的任一对象结尾后出现访问，则行为未定义。若 lhs 或 rhs 为空指针则行为未定义。
```c
int memcmp( const void* lhs, const void* rhs, size_t count );
```

## Parameters
### lhs
- Pointer to block of memory.
- 指向内存块的指针。

### rhs
- Pointer to block of memory.
- 指向内存块的指针。

### count
- Number of bytes to compare.
-  要被比较的字节数。

## Return Value
- Returns an integral value indicating the relationship between the content of the memory blocks:

    > - < 0	the first byte that does not match in both memory blocks has a lower value in lhs than in rhs (if evaluated as unsigned char values)
    > - 如果返回值 < 0，则表示 lhs 小于 rhs

    > - 0	the contents of both memory blocks are equal
    > - 如果返回值 > 0，则表示 lhs 小于 rhs

    > - \> 0	the first byte that does not match in both memory blocks has a greater value in lhs than in rhs (if evaluated as unsigned char values)
    > - 如果返回值 = 0，则表示 lhs 等于 rhs

## Example
```c
//
// Created by zhangrongxiang on 2018/2/8 16:57
// File memcmp
//

#include <stdio.h>
#include <string.h>

//C 库函数 int memcmp(const void *str1, const void *str2, size_t n)) 把存储区 str1 和存储区 str2 的前 n 个字节进行比较。
//比较按字典序进行。
typedef struct {
    char *name;
} Stu;

int main() {
    char *str = "abc";
    char *str2 = "abC";
    int cmp = memcmp(str, str2, strlen(str) > strlen(str2) ? strlen(str) : strlen(str2));
    printf("%d\n", cmp); // windows mingw -> 1  linux gcc 32

    int i = 0;
    int i2 = 10;
    cmp = memcmp(&i, &i2, sizeof(int));
    printf("%d\n", cmp);//windows mingw -> -1  linux gcc -10
    printf("%d\n", (int) sizeof(short));//2

    Stu stu = {.name = "zing"};
    Stu stu2 = {.name = "zing"};
    Stu stu3 = {.name = "Zing"};
    Stu stu4 = {.name = "aing"};

    /***********************************************/
    printf("%d\n", (int) sizeof(Stu)); //8
    printf("%d\n", (int) sizeof(stu.name)); //8
    printf("%d\n", (int) strlen(stu.name)); //4
    printf("%d\n", (int) sizeof(char *)); //8
    printf("%d\n", (int) sizeof(int *)); //8
    printf("%d\n", (int) sizeof(long *)); //8
    /***********************************************/

    cmp = memcmp(&stu, &stu2, sizeof(Stu));
    printf("struct %d \n", cmp);//0
    cmp = memcmp(stu.name, stu3.name, sizeof(Stu));
    printf("struct %d \n", cmp); // windows mingw -> -1  linux gcc 32
    cmp = memcmp(stu.name, stu4.name, sizeof(Stu));
    printf("struct %d \n", cmp); // windows mingw -> -1  linux gcc 25

    cmp = memcmp(&"abC", &"abc", sizeof(char *));
    printf("%d\n", cmp);//-32
    printf("a -> %d;A -> %d \n", 'a', 'A');//a -> 97;A -> 65
    printf("z -> %d;a -> %d \n", 'z', 'a');//a -> 97;A -> 65
    return 0;
}
```

## 参考文章
- <http://zh.cppreference.com/w/c/string/byte/memcmp>
- <http://www.cplusplus.com/reference/cstring/memcmp/> 
- <http://www.runoob.com/cprogramming/c-function-memcmp.html>
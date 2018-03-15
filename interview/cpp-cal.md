# cal

### `#define DOUBLE(x) x+x ，i = 5*DOUBLE(5`)； `i` 是多少？
i 为30。 5 * 5 + 5 


### 下面关于“联合”的题目的输出？
#### A
```c
//
// Created by zhangrongxiang on 2018/3/15 11:10
//

#include <stdio.h>
union {
    int i;
    char x[2];
} a;

void main() {
    a.x[0] = 10;
    a.x[1] = 1;
    printf("%d", a.i);
}
```
> 266 低位低地址，高位高地址，内存占用情况是Ox010A

#### B
```c
//
// Created by zhangrongxiang on 2018/3/15 11:13
//
#include <stdio.h>

int main() {
    union {                  /*定义一个联合*/
        int i;
        struct {            /*在联合中定义一个结构*/
            char first;
            char second;
        } half;
    } number;
    number.i = 0x4241;         /*联合成员赋值*/
    printf("%c%c\n", number.half.first, number.half.second);//AB
    number.half.first = 'a';   /*联合中结构成员赋值*/
    number.half.second = 'b';
    printf("%x\n", number.i);//6261
    return 0;
}
```
> `AB`(0x41对应'A',是低位；Ox42对应'B',是高位）`6261`(number.i和number.half共用一块地址空间）

### 已知`strcpy`的函数原型：`char *strcpy(char *strDest, const char *strSrc)`其中`strDest` 是目的字符串，`strSrc` 是源字符串。不调用C++/C 的字符串库函数，请编写函数 strcpy。
#### `Mystrcpy`
```c
//
// Created by zhangrongxiang on 2018/3/15 11:18
// File 4
//

/*
编写strcpy函数（10分）
已知strcpy函数的原型是
    char *strcpy(char *strDest, const char *strSrc);
    其中strDest是目的字符串，strSrc是源字符串。
（1）不调用C++/C的字符串库函数，请编写函数 strcpy
（2）strcpy能把strSrc的内容复制到strDest，为什么还要char * 类型的返回值？
答：为了 实现链式表达式。                            // 2分
例如    int length = strlen( strcpy( strDest, “hello world”) );
*/

#include <assert.h>
#include <stdio.h>

char *Mystrcpy(char *strDest, const char *strSrc) {
    assert((strDest != NULL) && (strSrc != NULL));// 2分
    char *address = strDest;                        // 2分
    while ((*strDest++ = *strSrc++) != '\0');// 2分
    return address; // 2分
}

int main() {
    char desc[20] = {0};
    char src[20] = "Hello World";
    Mystrcpy(desc, src);
    printf("%s\n", desc);
    return 0;
}
```
#### `Mystrlen` 
```c
//
// Created by zhangrongxiang on 2018/3/15 16:17
// File 7
//

#include <stdio.h>
#include <assert.h>

int Mystrlen(const char *str) {  // 输入参数const
    assert(str != NULL);  // 断言字符串地址非0
    int len = 0;
    while ((*str++) != '\0') {
        len++;
    }
    return len;
}

int main() {
    char str[] = "Hello World";
    printf("%d\n", Mystrlen(str));//11
    printf("%d\n", (int) sizeof(str));//12
}
```

### There are twoint variables: a and b, don’t use “if”, “? :”, “switch”or other judgementstatements, find out the biggest one of the two numbers.
`( ( a + b ) + abs( a -  b ) ) / 2`

### 如何打印出当前源文件的文件名以及源文件的当前行号？
```c
cout << __FILE__ ;
cout << __LINE__ ;
//__FILE__和__LINE__是系统预定义宏，这种宏并不是在某个文件中定义的，而是由编译器定义的
```

### `main`主函数执行完毕后，是否可能会再执行一段代码，给出说明？
可以，可以用`_onexit` 注册一个函数，它会在`main` 之后执行`int fn1(void)`, `fn2(void)`, `fn3(void)`,`fn4 (void)`;
```c
void main( void ){
　　String str("zhanglin");
　　_onexit( fn1 );
　　_onexit( fn2 );
　　_onexit( fn3 );
　　_onexit( fn4 );
　　printf( "This is executed first.\n" );
}

int fn1(){
　　printf( "next.\n" );
　　return 0;
}

int fn2(){
　　printf( "executed " );
　　return 0;
}

int fn3(){
　　printf( "is " );
　　return 0;
}

int fn4(){
　　printf( "This " );
　　return 0;
}
```

### 如何判断一段程序是由C编译程序还是由C++编译程序编译的？
```c
#ifdef __cplusplus
　　cout << "c++";
#else
　　cout << "c";
#endif
```
# C 标准库 - ctype.h

This header declares a set of functions to classify and transform individual characters.

> - These functions take the int equivalent of one character as parameter and return an int that can either be another character or a value representing a boolean value: an int value of 0 means false, and an int value different from 0 represents true.

> - C 标准库的 ctype.h 头文件提供了一些函数，可用于测试和映射字符。
这些函数接受 int 作为参数，它的值必须是 EOF 或表示为一个无符号字符。
如果参数 c 满足描述的条件，则这些函数返回非零（true）。如果参数 c 不满足描述的条件，则这些函数返回零。

## 函数
```c

//Character classification functions
//They check whether the character passed as parameter belongs to a certain category:
int isalnum(int c)
检查所传的字符是否是字母和数字。

int isalpha(int c)
检查所传的字符是否是字母。

int isblank (int c)
Check if character is blank

int iscntrl(int c)
检查所传的字符是否是控制字符。

int isdigit(int c)
检查所传的字符是否是十进制数字。

int isgraph(int c)
检查所传的字符是否有图形表示法。

int islower(int c)
检查所传的字符是否是小写字母。

int isprint(int c)
检查所传的字符是否是可打印的。

int ispunct(int c)
检查所传的字符是否是标点符号字符。

int isspace(int c)
检查所传的字符是否是空白字符。

int isupper(int c)
检查所传的字符是否是大写字母。

int isxdigit(int c)
检查所传的字符是否是十六进制数字。


//Character conversion functions
int tolower(int c)
把大写字母转换为小写字母。

int toupper(int c)
把小写字母转换为大写字母。
```

## 字符类
### 数字 (Digits)
> - A set of whole numbers { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 }
> - 完整的数字集合 { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 }

### 十六进制数字 (Hexadecimal digits)
> - This is the set of { 0 1 2 3 4 5 6 7 8 9 A B C D E F a b c d e f }
> - 集合 { 0 1 2 3 4 5 6 7 8 9 A B C D E F a b c d e f }

### 小写字母 (Lowercase letters)
> - This is a set of { a b c d e f g h i j k l m n o p q r s t u v w x y z }
> - 集合 { a b c d e f g h i j k l m n o p q r s t u v w x y z }

### 大写字母 (Uppercase letters)
> - A set of whole numbers {A B C D E F G H I J K L M N O P Q R S T U V W X Y Z }
> - 集合 {A B C D E F G H I J K L M N O P Q R S T U V W X Y Z }

### 字母 (Letters)
> - This is a set of lowercase letters and uppercase letters
> - 小写字母和大写字母的集合

### 字母数字字符 (Alphanumeric characters)
> - This is a set of Digits, Lowercase letters and Uppercase letters
> - 数字、小写字母和大写字母的集合

### 标点符号字符 (Punctuation characters)
> - This is a set of ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ ] ^ _ ` { | } ~
> - 集合 ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~

### 图形字符 (Graphical characters)
>- This is a set of Alphanumeric characters and Punctuation characters.
> - 字母数字字符和标点符号字符的集合

### 空格字符 (Space characters)
> - This is a set of Alphanumeric characters and Punctuation characters.
> - 制表符、换行符、垂直制表符、换页符、回车符、空格符的集合。
	
### 可打印字符
> - This is a set of Alphanumeric characters, Punctuation characters and Space characters.
> - 字母数字字符、标点符号字符和空格字符的集合。

### 控制字符 (Control characters)
> - In ASCII, these characters have octal codes 000 through 037, and 177 (DEL).
> - 在 ASCII 编码中，这些字符的八进制代码是从 000 到 037，以及 177（DEL）。

### 空白字符 (Blank characters)
> - These are space and tab.
> - 包括空格符和制表符。

### 字母字符 (Alphabetic characters)
> - This is a set of Lowercase letters and Uppercase letters.
> - 小写字母和大写字母的集合。

## ASCII
```
 0 -  8	       0x00-0x08	控制码 (NUL等)	       
 9 -  9        0x09	        制表符 (\t)	         
10 - 13	       0x0A-0x0D	空白符 (\n, \v, \f, \r) 
14 - 31	       0x0E-0x1F	控制码	               
32 - 32        0x20	        空格	                
33 - 47	       0x21-0x2F	!"#$%&'()*+,-./	       
48 - 57	       0x30-0x39	0123456789	           
58 - 64	       0x3a-0x40	:;<=>?@	                
65 - 70	       0x41-0x46	ABCDEF	               
71 - 90	       0x47-0x5A	GHIJKLMNOPQRSTUVWXYZ	
91 - 96	       0x5B-0x60	[\]^_`	               
97 -102	       0x61-0x66	abcdef	                
103-122	       0x67-0x7A	ghijklmnopqrstuvwxyz	
123-126	       0x7B-0x7E	{|}~	             
127	           0x7F	        退格符 (DEL)
```

## 参考文章
- <http://www.cplusplus.com/reference/cctype/>
- <http://www.runoob.com/cprogramming/c-standard-library-ctype-h.html>
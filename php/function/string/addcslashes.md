# addcslashes

> - (PHP 4, PHP 5, PHP 7)
> - addcslashes — Quote string with slashes in a C style
> - addcslashes — 以 C 语言风格使用反斜线转义字符串中的字符

## Description

```php
string addcslashes ( 
    string $str ,
    string $charlist
    )
//Returns a string with backslashes before characters that are listed in charlist parameter.
//返回字符串，该字符串在属于参数 charlist 列表中的字符前都加上了反斜线。

```
## Parameters
### str
- The string to be escaped.
- 要转义的字符。

### charlist
- A list of characters to be escaped. If charlist contains characters \n, \r etc., they are converted in C-like style, while other non-alphanumeric characters with ASCII codes lower than 32 and higher than 126 converted to octal representation.
- 如果 charlist 中包含有 \n，\r 等字符，将以 C 语言风格转换，而其它非字母数字且 ASCII 码低于 32 以及高于 126 的字符均转换成使用八进制表示。

- When you define a sequence of characters in the charlist argument make sure that you know what characters come between the characters that you set as the start and end of the range.
- 当定义 charlist 参数中的字符序列时，需要确实知道介于自己设置的开始及结束范围之内的都是些什么字符。
```php
<?php
echo addcslashes('foo[ ]', 'A..z');
// 输出：\f\o\o\[ \]
// 所有大小写字母均被转义
// ... 但 [\]^_` 以及分隔符、换行符、回车符等也一并被转义了。
```

- Also, if the first character in a range has a higher ASCII value than the second character in the range, no range will be constructed. Only the start, end and period characters will be escaped. Use the ord() function to find the ASCII value for a character.
- 另外，如果设置范围中的结束字符 ASCII 码高于开始字符，则不会创建范围，只是将开始字符、结束字符以及其间的字符逐个转义。可使用 ord() 函数获取字符的 ASCII 码值。
```php
<?php
echo addcslashes("zoo['.']", 'z..A');
// output:  \zoo['\.']
```

- Be careful if you choose to escape characters 0, a, b, f, n, r, t and v. They will be converted to \0, \a, \b, \f, \n, \r, \t and \v, all of which are predefined escape sequences in C. Many of these sequences are also defined in other C-derived languages, including PHP, meaning that you may not get the desired result if you use the output of addcslashes() to generate code in those languages with these characters defined in charlist.
- 当选择对字符 0，a，b，f，n，r，t 和 v 进行转义时需要小心，它们将被转换成 \0，\a，\b，\f，\n，\r，\t 和 \v。在 PHP 中，只有 \0（NULL），\r（回车符），\n（换行符）和 \t（制表符）是预定义的转义序列， 而在 C 语言中，上述的所有转换后的字符都是预定义的转义序列。

## Return Values
- Returns the escaped string.
- 返回转义后的字符。

## Example
```php
<?php
/**
 * Created by PhpStorm.
 * User: zhangrongxiang
 * Date: 2018/2/13
 * Time: 下午7:31
 */

$str = 'Hello World! \!';
//  Hello\ World\!\ \\!
echo addcslashes( $str, ' !' ) . PHP_EOL;
//  \H\e\l\l\o \W\o\r\l\d! \\!
echo addcslashes( $str, 'A..z' ) . PHP_EOL;
//  Hello World\! \\\!
echo addcslashes( $str, '\!' ) . PHP_EOL;
//  Hello World\! \\!
echo addcslashes( $str, '!' ) . PHP_EOL;
$str = '1234567890';
//  \1\2\3\4\5\6\7\8\90
echo addcslashes( $str, '1..9' ) . PHP_EOL;

```
## See
- <http://php.net/manual/zh/function.addcslashes.php>

### *All rights reserved*
# trim 
> - (PHP 4, PHP 5, PHP 7)
> - trim — Strip whitespace (or other characters) from the beginning and end of a string
> - trim — 去除字符串首尾处的空白字符（或者其他字符）

## Description
```php
string trim ( string $str [, string $character_mask = " \t\n\r\0\x0B" ] )
//This function returns a string with whitespace stripped from the beginning and end of str. Without the second parameter, trim() will strip these characters:
//此函数返回字符串 str 去除首尾空白字符后的结果。如果不指定第二个参数，trim() 将去除这些字符：

" " (ASCII 32 (0x20)), // an ordinary space. 普通空格符。
"\t" (ASCII 9 (0x09)), // a tab. 制表符。
"\n" (ASCII 10 (0x0A)), // a new line (line feed).换行符。
"\r" (ASCII 13 (0x0D)), // a carriage return.回车符。
"\0" (ASCII 0 (0x00)), // the NUL-byte.空字节符。
"\x0B" (ASCII 11 (0x0B)), // a vertical tab.垂直制表符。
```

## Parameters
### str
- The string that will be trimmed.
- 待处理的字符串。

### character_mask
- Optionally, the stripped characters can also be specified using the character_mask parameter. Simply list all characters that you want to be stripped. With .. you can specify a range of characters.
- 可选参数，过滤字符也可由 character_mask 参数指定。一般要列出所有希望过滤的字符，也可以使用 “..” 列出一个字符范围。

## Return Values
- The trimmed string.
- 过滤后的字符串。

## Examples
```php
<?php
/**
 * Created by PhpStorm.
 * User: zhangrongxiang
 * Date: 2018/3/4
 * Time: 下午3:10
 */
//去除字符串首尾处的空白字符（或者其他字符）
$hello = "Hello World";
//Hello World
echo $hello . PHP_EOL;
//Hello World
echo trim( $hello ) . PHP_EOL;
//o Wor
echo trim( $hello, "Hdle" ) . PHP_EOL;
//Hello Wor
echo trim( $hello, "dle" ) . PHP_EOL;
//llo World
echo trim( $hello, "He" ) . PHP_EOL;
//ello World
echo trim( $hello, "H" ) . PHP_EOL;
//Hello World
echo trim( $hello, "e" ) . PHP_EOL;
/**
 * Note: Possible gotcha: removing middle characters
 * Because trim() trims characters from the beginning and end of a string,
 * it may be confusing when characters are (or are not) removed from the middle.
 * trim('abc', 'bad') removes both 'a' and 'b' because it trims 'a' thus moving 'b' to the beginning to also be trimmed.
 * So, this is why it "works" whereas trim('abc', 'b') seemingly does not.
 */
echo trim( 'abc', 'bad' ) . PHP_EOL;//c
echo trim( 'abc', 'a' ) . PHP_EOL;//bc

$text = "\t\tThese are a few words :) ...  ";
//		These are a few words :) ...
echo $text . PHP_EOL;
//These are a few words :) ...
echo trim( $text ) . PHP_EOL;

$binary = "\x09Example string\x0A";
//	Example string
//
echo $binary . PHP_EOL;
//Example string
echo trim( $binary ) . PHP_EOL;
// 清除 $binary 首位的 ASCII 控制字符
// （包括 0-31）
//Example string
echo trim( $binary, "\x00..\x1F" ) . PHP_EOL;

/////////////////////////////////////////////////////////////////////////////////////
function trim_value( &$value ) {
	$value = trim( $value );
}

$fruit = array( 'apple', 'banana ', ' cranberry ' );
//[0] => apple
//[1] => banana
//[2] =>  cranberry
print_r( $fruit );

array_walk( $fruit, 'trim_value' );
//[0] => apple
//[1] => banana
//[2] => cranberry
print_r( $fruit );

$path = '/Users/zhangrongxiang/WorkSpace/phpProjects/PHPTEST';
echo trim( $path ) . PHP_EOL;
//  Users/zhangrongxiang/WorkSpace/phpProjects/PHPTEST
echo trim( $path, '/' ) . PHP_EOL;
```

## See
- <http://php.net/manual/zh/function.trim.php>
### *All rights reserved*
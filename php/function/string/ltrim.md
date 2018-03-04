# ltrim
> - (PHP 4, PHP 5, PHP 7)
> - ltrim — Strip whitespace (or other characters) from the beginning of a string
> - ltrim — 删除字符串开头的空白字符（或其他字符）

## Description
```
string ltrim ( string $str [, string $character_mask ] )
//Strip whitespace (or other characters) from the beginning of a string.
//删除字符串开头的空白字符（或其他字符）
```
## Parameters
### str
- The input string.
- 输入的字符串。

### character_mask
- You can also specify the characters you want to strip, by means of the character_mask parameter. Simply list all characters that you want to be stripped. With .. you can specify a range of characters.
- 通过参数 character_mask，你也可以指定想要删除的字符，简单地列出你想要删除的所有字符即可。使用..，可以指定字符的范围。

## Return Values
- This function returns a string with whitespace stripped from the beginning of str. Without the second parameter, ltrim() will strip these characters:
- 该函数返回一个删除了 str 最左边的空白字符的字符串。 如果不使用第二个参数， ltrim() 仅删除以下字符：

> - " " (ASCII 32 (0x20)), an ordinary space.普通空白字符。
> - "\t" (ASCII 9 (0x09)), a tab.制表符.
> - "\n" (ASCII 10 (0x0A)), a new line (line feed).换行符。
> - "\r" (ASCII 13 (0x0D)), a carriage return.回车符。 
> - "\0" (ASCII 0 (0x00)), the NUL-byte.NUL空字节符。
> - "\x0B" (ASCII 11 (0x0B)), a vertical tab.垂直制表符。

## Examples
```php
<?php
/**
 * Created by PhpStorm.
 * User: zhangrongxiang
 * Date: 2018/3/4
 * Time: 下午4:37
 */

//ltrim — 删除字符串开头的空白字符（或其他字符）

$hello = "Hello World";
//Hello World
echo ltrim( $hello ) . PHP_EOL;
//ello World
echo ltrim( $hello, 'H' ) . PHP_EOL;
//llo World
echo ltrim( $hello, 'eH' ) . PHP_EOL;

$text = "\t\tThese are a few words :) ...  ";
//		These are a few words :) ...
echo $text . PHP_EOL;
//These are a few words :) ...
echo ltrim( $text ) . PHP_EOL;
//These are a few words :) ...
echo ltrim( $text, "\t" ) . PHP_EOL;
//		These are a few words :) ...
echo ltrim( $text, '\t' ) . PHP_EOL;

$binary = "\x09Example string\x0A";
//	Example string
//
echo $binary . PHP_EOL;
//Example string
//
echo ltrim( $binary ) . PHP_EOL;
//Example string
//
echo ltrim( $binary, "\x00..\x1F" ) . PHP_EOL;
```

## See
- <http://php.net/manual/zh/function.ltrim.php>
### *All rights reserved*
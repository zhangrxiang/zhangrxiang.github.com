# wordwrap
> - (PHP 4 >= 4.0.2, PHP 5, PHP 7)
> - wordwrap — Wraps a string to a given number of characters
> - wordwrap — 打断字符串为指定数量的字串

## Description
```php
string wordwrap ( 
    string $str [, 
    int $width = 75 [, 
    string $break = "\n" [, 
    bool $cut = FALSE ]]] 
    )
//Wraps a string to a given number of characters using a string break character.
//使用字符串断点将字符串打断为指定数量的字串。
```

## Parameters
### str
- The input string.
- 输入字符串。

### width
- The number of characters at which the string will be wrapped.
- 列宽度。

### break
- The line is broken using the optional break parameter.
- 使用可选的 `break` 参数打断字符串。

### cut
- If the cut is set to TRUE, the string is always wrapped at or before the specified width. So if you have a word that is larger than the given width, it is broken apart. (See second example). When FALSE the function does not split the word even if the width is smaller than the word width.
- 如果 cut 设置为 `TRUE`，字符串总是在指定的 `width` 或者之前位置被打断。因此，如果有的单词宽度超过了给定的宽度，它将被分隔开来。（参见第二个范例）。 当它是 `FALSE` ，函数不会分割单词，哪怕 width 小于单词宽度。

## Return Values
- Returns the given string wrapped at the specified length.
- 返回打断后的字符串。

## Examples
```php
<?php
/**
 * Created by PhpStorm.
 * User: zhangrongxiang
 * Date: 2018/3/8
 * Time: 下午9:27
 */

$text    = "The quick brown fox jumped over the lazy dog.";
$newtext = wordwrap( $text, 20, "\n" );
//The quick brown fox
//jumped over the lazy
//dog.
echo $newtext . PHP_EOL;

$text    = "A very long woooooooooooord.";
$newtext = wordwrap( $text, 8, "\n", false );
//A very
//long
//woooooooooooord.
echo $newtext . PHP_EOL;
$newtext = wordwrap( $text, 8, "\n", true );
//A very
//long
//wooooooo
//ooooord.
echo $newtext . PHP_EOL;

$str = "hello world hello php";
//hello-world-hello-php
echo wordwrap( $str, 5, "-", false ) . PHP_EOL;
//hello world hello php
echo wordwrap( $str ) . PHP_EOL;
//hello
//world
//hello
//php
echo wordwrap( $str, 3 ) . PHP_EOL;
```

## See
- <http://php.net/manual/zh/function.wordwrap.php>

### *All rights reserved*
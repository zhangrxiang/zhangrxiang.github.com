# mb_strstr
> - (PHP 5 >= 5.2.0, PHP 7)
> - mb_strstr — Finds first occurrence of a string within another
> - 查找字符串在另一个字符串里的首次出现

## Description
```php
string mb_strstr ( 
    string $haystack , 
    string $needle [, 
    bool $before_needle = false [, 
    string $encoding =mb_internal_encoding() ]] 
    )

//mb_strstr() finds the first occurrence of needle in haystack and returns the portion of haystack. If needle is not found, it returns FALSE.
//mb_strstr() 查找了 needle 在 haystack 中首次的出现并返回 haystack 的一部分。 如果 needle 没有找到，它将返回 FALSE。

```
## Parameters
### haystack
- The string from which to get the first occurrence of needle
- 要获取 needle 首次出现的字符串。

### needle
- The string to find in haystack
- 在 haystack 中查找这个字符串。

### before_needle
- Determines which portion of haystack this function returns. If set to TRUE, it returns all of haystack from the beginning to the first occurrence of needle (excluding needle). If set to FALSE, it returns all of haystack from the first occurrence of needle to the end (including needle).
- 决定这个函数返回 haystack 的哪一部分。 如果设置为 TRUE，它返回 haystack 中从开始到 needle 出现位置的所有字符（不包括 needle）。 如果设置为 FALSE，它返回 haystack 中 needle 出现位置到最后的所有字符（包括了 needle）。

### encoding
- Character encoding name to use. If it is omitted, internal character encoding is used.
- 要使用的字符编码名称。 如果省略该参数，将使用内部字符编码。

## Return Values
- Returns the portion of haystack, or FALSE if needle is not found.
- 返回 haystack 的一部分，或者 needle 没找到则返回 FALSE。

## Examples
```php
<?php
/**
 * Created by PhpStorm.
 * User: zhangrongxiang
 * Date: 2018/2/1
 * Time: 下午10:27
 */

//*  * If set to true, it returns all of haystack from the beginning to the first occurrence of needle.
$strstr = mb_strstr( "hello china", "ll", true );
echo $strstr . PHP_EOL; //he

//* If set to false, it returns all of haystack from the first occurrence of needle to the end,
$strstr = mb_strstr( "hello china", "ll", false );
echo $strstr . PHP_EOL;//llo china

//hello china
echo mb_strstr( "hello china", "ll", true ) . mb_strstr( "hello china", "ll", false ) . PHP_EOL;


$strstr = mb_strstr( "hello China,hello PHP", "ll", true );
echo $strstr . PHP_EOL; //he

$strstr = mb_strstr( "hello China,hello PHP", "ll", false );
echo $strstr . PHP_EOL; //llo China,hello PHP

$strstr = mb_strstr( "PHP是世界上最好的语言😄", "最好", true );
echo $strstr.PHP_EOL; //PHP是世界上
$strstr = mb_strstr( "PHP是世界上最好的语言😄", "最好", false );
echo $strstr.PHP_EOL; //最好的语言😄

```

## 文章参考
<http://php.net/manual/en/function.mb-strstr.php>
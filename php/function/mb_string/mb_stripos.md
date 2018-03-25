# mb_stripos
> - (PHP 5 >= 5.2.0, PHP 7)
> - mb_stripos — Finds position of first occurrence of a string within another, case insensitive
> - mb_stripos — 大小写不敏感地查找字符串在另一个字符串中首次出现的位置

## Description
```php
int mb_stripos ( 
    string $haystack , 
    string $needle [, 
    int $offset = 0 [, 
    string $encoding = mb_internal_encoding() ]] 
    )
//mb_stripos() returns the numeric position of the first occurrence of needle in the haystack string. Unlike mb_strpos(), mb_stripos() is case-insensitive. If needle is not found, it returns FALSE.
//mb_stripos() 返回 needle 在字符串 haystack 中首次出现位置的数值。 和 mb_strpos() 不同的是，mb_stripos() 是大小写不敏感的。 如果 needle 没找到，它将返回 FALSE。
```

## Parameters
### haystack
- The string from which to get the position of the first occurrence of needle
- 在这个字符串中查找获取 needle 首次出现的位置

### needle
- The string to find in haystack
- 在 haystack 中查找这个字符串

### offset
- The position in haystack to start searching. A negative offset counts from the end of the string.
- haystack 里开始搜索的位置。如果是负数，就从字符串的尾部开始统计。

### encoding
- Character encoding name to use. If it is omitted, internal character encoding is used.
- 使用的字符编码名称。 如果省略了它，将使用内部字符编码。

## Return Values
- Return the numeric position of the first occurrence of needle in the haystack string, or FALSE if needle is not found.
- 返回字符串 haystack 中 needle 首次出现位置的数值。 如果没有找到 needle，它将返回 FALSE。

## Example
```php
<?php
/**
 * Created by PhpStorm.
 * User: zhangrongxiang
 * Date: 2018/2/3
 * Time: 下午3:47
 */

$str = "PHP is the best language on the world!";
echo mb_stripos( $str, "php" ) . PHP_EOL; //0
echo mb_stripos( $str, "Best" ) . PHP_EOL; //11

// !== 严格比较
if ( mb_stripos( $str, "Php" ) !== false ) {
	echo "exists" . PHP_EOL;
	//php is the best language on the world!
	echo mb_strtolower( $str ) . PHP_EOL;
}

echo mb_stripos( $str, "THE", 10 ) . PHP_EOL;//28

```

## 文章参考
- <http://php.net/manual/en/function.mb-stripos.php>
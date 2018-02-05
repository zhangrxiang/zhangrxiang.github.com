# mb_strrpos
> - (PHP 4 >= 4.0.6, PHP 5, PHP 7)
> - mb_strrpos — Find position of last occurrence of a string in a string
> - mb_strrpos — 查找字符串在一个字符串中最后出现的位置

## Description
```php
int mb_strrpos ( 
    string $haystack , 
    string $needle [, 
    int $offset = 0 [, 
    string $encoding = mb_internal_encoding() ]] 
    )
//Performs a multibyte safe strrpos() operation based on the number of characters. needle position is counted from //the beginning of haystack. First character's position is 0. Second character position is 1.
//基于字符数执行一个多字节安全的 strrpos() 操作。 needle 的位置是从 haystack 的开始进行统计的。 第一个字符的位置是 0，第二个字符的位置是 1。
```
## Parameters
### haystack
- The string being checked, for the last occurrence of needle
- 查找 needle 在这个 string 中最后出现的位置。

### needle
- The string to find in haystack.
- 在 haystack 中查找这个 string。

### offset
- May be specified to begin searching an arbitrary number of characters into the string. Negative values will stop searching at an arbitrary point prior to the end of the string.
- 可以用于指定 string 里从任意字符数开始进行搜索。 负数的值将导致搜索会终止于指向 string 末尾的任意点。

### encoding
- The encoding parameter is the character encoding. If it is omitted, the internal character encoding value will be used.
- encoding 参数为字符编码。如果省略，则使用内部字符编码。

## Return Values
- Returns the numeric position of the last occurrence of needle in the haystack string. If needle is not found, it returns FALSE.
- 返回 string 的 haystack 中，needle 最后出现位置的数值。 如果没有找到 needle，它将返回 FALSE。

## Example
```php
<?php
/**
 * Created by PhpStorm.
 * User: zhangrongxiang
 * Date: 2018/2/4
 * Time: 下午11:02
 */


$test = "万物皆对象，everything is object";
echo strlen( $test ) . PHP_EOL; //38 = 6*3 = 20
echo mb_strlen( $test ) . PHP_EOL;//26 = 6 + 20
echo mb_strrpos( $test, '对象', 1 ) . PHP_EOL;  // 3
echo mb_strrpos( $test, 'object', 2 ) . PHP_EOL; // 20
echo mb_strrpos( $test, '对象', - 1 ) . PHP_EOL; // 3
echo mb_strrpos( $test, '对象', - mb_strlen( $test ) + 10 ) . PHP_EOL; // 3
echo mb_strrpos( $test, 'object', - 1 ) . PHP_EOL; // 20
echo mb_strrpos( $test, 'object', - 7 ) . PHP_EOL; // false
echo mb_strrpos( $test, '万物皆对象' ) . PHP_EOL; // 0

//运算符优先级！！ 赋值 < 比较
if ( ( $position = mb_strrpos( $test, "万物皆对象" ) ) !== false ) {
	//万物皆对象
	echo mb_substr( $test, $position, 5 ) . PHP_EOL;
}

$str = "https://github.com/zhangrxiang";
if ( ( $position = mb_strrpos( $str, "/" ) ) !== false ) {
	//zhangrxiang
	echo mb_substr( $str, $position + 1 ) . PHP_EOL;
}

$str = "/Users/zhangrongxiang/WorkSpace/phpProjects/PHPTEST/2018/02/04/mb_strrpos.php";
if ( ( $position = mb_strrpos( $str, "/" ) ) !== false ) {
	//mb_strrpos.php
	echo mb_substr( $str, $position + 1 ) . PHP_EOL;
}
```

## 文章参考
- <http://php.net/manual/en/function.mb-strrpos.php>
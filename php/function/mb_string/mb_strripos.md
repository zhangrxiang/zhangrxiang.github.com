# mb_strripos
> - (PHP 4 >= 4.0.6, PHP 5, PHP 7)
> - mb_strrpos — Find position of last occurrence of a string in a string
> - mb_strripos — 大小写不敏感地在字符串中查找一个字符串最后出现的位置

## Description
```php
int mb_strrpos ( 
    string $haystack ,
    string $needle [, 
    int $offset = 0 [, 
    string $encoding = mb_internal_encoding() ]] 
    )
//Performs a multibyte safe strrpos() operation based on the number of characters. needle position is counted from //the beginning of haystack. First character's position is 0. Second character position is 1.

//mb_strripos() 基于字符数执行一个多字节安全的 strripos() 操作。 needle 的位置是从 haystack 的开始进行统计的。 第一个字符的位置//是 0，第二个字符的位置是 1。 和 mb_strrpos() 不同的是，mb_strripos() 是大小写不敏感的。

```

## Parameters
### haystack
- The string being checked, for the last occurrence of needle
- 查找 needle 在这个字符串中最后出现的位置。

### needle
- The string to find in haystack.
- 在 haystack 中查找这个字符串。

### offset
- May be specified to begin searching an arbitrary number of characters into the string. Negative values will stop searching at an arbitrary point prior to the end of the string.
- 在 haystack 中开始搜索的位置。

### encoding
- The encoding parameter is the character encoding. If it is omitted, the internal character encoding value will be used.
- 使用的字符编码名称。如果省略了，则将使用内部编码。

## Return Values
- Returns the numeric position of the last occurrence of needle in the haystack string. If needle is not found, it returns FALSE.
- 返回字符串 haystack 中 needle 最后出现位置的数值。 如果没有找到 needle，它将返回 FALSE。

## Example
```php
<?php
/**
 * Created by PhpStorm.
 * User: zhangrongxiang
 * Date: 2018/2/5
 * Time: 下午11:00
 */

$str = "Life is short,I use PHP";
$por = mb_strripos( $str, "php", 10 );
echo $por . PHP_EOL; //20

function startsWith( $haystack, $needle ) {
	$res = false;
	if ( mb_strripos( $haystack, $needle, 0, "utf-8" ) === 0 ) {
		$res = true;
	}
	
	return $res;
}

function endsWith( $haystack, $needle ) {
	$res = false;
	$len = mb_strlen( $haystack );
	$pos = $len - mb_strlen( $needle );
	if ( mb_strripos( $haystack, $needle, 0, "utf-8" ) === $pos ) {
		$res = true;
	}
	
	return $res;
}

if ( startsWith( $str, "life" ) ) {
	//true
	echo "startsWith($str,life)" . PHP_EOL;
}

if ( startsWith( $str, "php" ) ) {
	echo "startsWith($str,php)" . PHP_EOL;
} else {
	//false
	echo "No startsWith($str,php)" . PHP_EOL;
}

if ( endsWith( $str, "php" ) ) {
	//true
	echo "endsWith($str,php)" . PHP_EOL;
}

if ( endsWith( $str, "life" ) ) {
	echo "endsWith($str,life)" . PHP_EOL;
} else {
	//false
	echo "No endsWith($str,life)" . PHP_EOL;
}

```
## 文章参考
- <http://php.net/manual/en/function.mb-strrpos.php>
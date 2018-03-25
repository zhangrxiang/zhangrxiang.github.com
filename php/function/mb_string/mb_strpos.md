# mb_strpos

> - (PHP 4 >= 4.0.6, PHP 5, PHP 7)
> - mb_strpos — Find position of first occurrence of string in a string
> - mb_strpos — 查找字符串在另一个字符串中首次出现的位置

## Description
```php
int mb_strpos ( 
    string $haystack , 
    string $needle [, 
    int $offset = 0 [, 
    string $encoding = mb_internal_encoding() ]] 
    )
//Finds position of the first occurrence of a string in a string.
// 查找 string 在一个 string 中首次出现的位置。

//Performs a multi-byte safe strpos() operation based on number of characters. The first character's position is 0, the second character position is 1, and so on.
// 基于字符数执行一个多字节安全的 strpos() 操作。 第一个字符的位置是 0，第二个字符的位置是 1，以此类推。
```

## Parameters
### haystack
- The string being checked.
- 要被检查的 string。

### needle
- The string to find in haystack. In contrast with strpos(), numeric values are not applied as the ordinal value of a character.
- 在 haystack 中查找这个字符串。 和 strpos() 不同的是，数字的值不会被当做字符的顺序值。

### offset
- The search offset. If it is not specified, 0 is used. A negative offset counts from the end of the string.
- 搜索位置的偏移。如果没有提供该参数，将会使用 0。负数的 offset 会从字符串尾部开始统计。

### encoding
- The encoding parameter is the character encoding. If it is omitted, the internal character encoding value will be used.
- encoding 参数为字符编码。如果省略，则使用内部字符编码。

## Return Values
- Returns the numeric position of the first occurrence of needle in the haystack string. If needle is not found, it returns FALSE.
- 返回 string 的 haystack 中 needle 首次出现位置的数值。 如果没有找到 needle，它将返回 FALSE。

## Example
```php
<?php
/**
 * Created by PhpStorm.
 * User: zhangrongxiang
 * Date: 2018/2/2
 * Time: 下午11:16
 */

$str = "Hello World! Hello PHP";
$pos = mb_strpos( $str, "Hello", 0, mb_internal_encoding() );
echo $pos . PHP_EOL;//0
$pos = mb_strpos( $str, "Hello", 2, mb_internal_encoding() );
echo $pos . PHP_EOL;//13

function mb_str_replace( $haystack, $search, $replace, $offset = 0, $encoding = 'auto' ) {
	$len_sch = mb_strlen( $search, $encoding );
	$len_rep = mb_strlen( $replace, $encoding );
	
	while ( ( $offset = mb_strpos( $haystack, $search, $offset, $encoding ) ) !== false ) {
		$haystack = mb_substr( $haystack, 0, $offset, $encoding )
		            . $replace
		            . mb_substr( $haystack, $offset + $len_sch,
				$le = mb_strlen( $haystack ) - mb_strlen( $search ) + mb_strlen( $replace ),
				$encoding );
		//echo $le.PHP_EOL;
		$offset = $offset + $len_rep;
		if ( $offset > mb_strlen( $haystack, $encoding ) ) {
			break;
		}
	}
	
	return $haystack;
}

$replace = mb_str_replace( "hello world !hello world !hello world !hello world !", "hello", "hi" );
echo $replace . PHP_EOL; //hi world !hi world !hi world !hi world !

//hi PHP !hi PHP !hi PHP !hi PHP !
echo mb_str_replace( $replace, "world", "PHP" ) . PHP_EOL;
echo mb_str_replace( $replace, " ", "-" ) . PHP_EOL;

//PHP是世界上最好的语言😂😂😂😂😂😂
echo mb_str_replace( "PHP是世界上最好的语言😄😄😄😄😄😄", '😄', '😂', 0, mb_internal_encoding() ) . PHP_EOL;
echo mb_str_replace( "112233445566", '22', '00' ) . PHP_EOL;//110033445566
echo mb_str_replace( '😄😄😄😄', '😄', '😫1', 2, mb_internal_encoding() ) . PHP_EOL;
echo mb_str_replace( '1111', '111', '0', 1 ) . PHP_EOL;//10
echo mb_strlen( '😄😄😄😄' ) . PHP_EOL;//4

//代码开发代码
echo mb_str_replace( '软件开发软件', '软件', '代码' ,0,mb_internal_encoding()) . PHP_EOL;
//代码开发  //todo??
echo mb_str_replace( '软件开发软件', '软件', '代码' ) . PHP_EOL;
```

## 文章参考
- <http://php.net/manual/en/function.mb-strpos.php>
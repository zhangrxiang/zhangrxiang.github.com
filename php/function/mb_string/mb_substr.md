# mb_substr
> - (PHP 4 >= 4.0.6, PHP 5, PHP 7)
> - mb_substr — Get part of string
> - mb_substr — 获取部分字符串

## Description
```php
string mb_substr ( 
    string $str ,
    int $start [,
    int $length = NULL [, 
    string $encoding = mb_internal_encoding() ]] 
    )
// Performs a multi-byte safe substr() operation based on number of characters. Position is counted from 
// the beginning of str. First character's position is 0. Second character position is 1, and so on.
//根据字符数执行一个多字节安全的 substr() 操作。 位置是从 str 的开始位置进行计数。 第一个字符的位置是 0。第二个字符的位置是 1，以此类推。
```
## Parameters
### str
- The string to extract the substring from.
- 从该 string 中提取子字符串。

### start
- If start is non-negative, the returned string will start at the start'th position in str, counting from zero. For instance, in the string 'abcdef', the character at position 0 is 'a', the character at position 2 is 'c', and so forth.
- 如果 start 不是负数，返回的字符串会从 str 第 start 的位置开始，从 0 开始计数。举个例子，字符串 'abcdef'，位置 0 的字符是 'a'，位置 2 的字符是 'c'，以此类推。

- If start is negative, the returned string will start at the start'th character from the end of str.
- 如果 start 是负数，返回的字符串是从 str 末尾处第 start 个字符开始的。

### length
- Maximum number of characters to use from str. If omitted or NULL is passed, extract all characters to the end of the string.
- str 中要使用的最大字符数。如果省略了此参数或者传入了 NULL，则会提取到字符串的尾部。

### encoding
- The encoding parameter is the character encoding. If it is omitted, the internal character encoding value will be used.
- encoding 参数为字符编码。如果省略，则使用内部字符编码。

## Return Values
- mb_substr() returns the portion of str specified by the start and length parameters.
- mb_substr() 函数根据 start 和 length 参数返回 str 中指定的部分。

## Changelog
- 5.4.8	- Passing NULL as length extracts all characters to the end of the string. Prior to this version NULL was treated the same as 0.

## Examples
```php
<?php
/**
 * Created by PhpStorm.
 * User: zhangrongxiang
 * Date: 2018/1/30
 * Time: 下午8:51
 */

$string = "0123456789你好";
/** start > 0  length > 0*/
$mystring = mb_substr( $string, 5, 1 );
echo $mystring . PHP_EOL; // 5
$mystring = mb_substr( $string, 5, 2 );
echo $mystring . PHP_EOL; // 56
$mystring = mb_substr( $string, 10, 2 );
echo $mystring . PHP_EOL; // 你好

/** start < 0  length > 0*/
$mystring = mb_substr( $string, - 2, 2 );
echo $mystring . PHP_EOL; // 你好
echo 'mb_strlen : ' . mb_strlen( $string ) . PHP_EOL;//12
$mystring = mb_substr( $string, - mb_strlen( $string ), 2 );
echo $mystring . PHP_EOL; // 01
$mystring = mb_substr( $string, - 3, 2 );
echo $mystring . PHP_EOL; // 9你

/** start > 0  length <  0*/
$mystring = mb_substr( $string, 5, - 1 );
echo $mystring . PHP_EOL; // 56789你
$mystring = mb_substr( $string, 0, - mb_strlen( $string ) + 1 );
echo $mystring . PHP_EOL; // 0
$mystring = mb_substr( $string, 5, - 5 );
echo $mystring . PHP_EOL; // 56

/** start < 0  length <  0*/
$mystring = mb_substr( $string, - 10, - 1 );
echo $mystring . PHP_EOL; // 23456789你
$mystring = mb_substr( $string, - 5, - 1 );
echo $mystring . PHP_EOL; // 789你

function mb_ucfirst( $str, $enc = 'utf-8' ) {
	return mb_strtoupper( mb_substr( $str, 0, 1, $enc ), $enc ) . mb_substr( $str, 1, mb_strlen( $str, $enc ), $enc );
}

echo mb_ucfirst( "hello world 你好 中国" ) . PHP_EOL; //Hello world 你好 中国

/**
 * @param $string
 * @param string $encoding
 *
 * @return array
 */
function get_character_classes( $string, $encoding = "UTF-8" ) {
	$current_encoding = mb_internal_encoding();
	mb_internal_encoding( $encoding );
	$has          = array();
	$stringlength = mb_strlen( $string, $encoding );
	for ( $i = 0; $i < $stringlength; $i ++ ) {
		$c = mb_substr( $string, $i, 1 );
		if ( ( $c >= "0" ) && ( $c <= "9" ) ) {
			$has['numeric'] = "numeric";
		} else if ( ( $c >= "a" ) && ( $c <= "z" ) ) {
			$has['alpha']      = "alpha";
			$has['alphalower'] = 'alphalower';
		} else if ( ( $c >= "A" ) && ( $c <= "Z" ) ) {
			$has['alpha']      = "alpha";
			$has['alphaupper'] = "alphaupper";
		} else if ( ( $c == "$" ) || ( $c == "£" ) ) {
			$has['currency'] = "currency";
		} else if ( ( $c == "." ) && ( $has['decimal'] ) ) {
			$has['decimals'] = "decimals";
		} else if ( $c == "." ) {
			$has['decimal'] = "decimal";
		} else if ( $c == "," ) {
			$has['comma'] = "comma";
		} else if ( $c == "-" ) {
			$has['dash'] = "dash";
		} else if ( $c == " " ) {
			$has['space'] = "space";
		} else if ( $c == "/" ) {
			$has['slash'] = "slash";
		} else if ( $c == ":" ) {
			$has['colon'] = "colon";
		} else if ( ( $c >= " " ) && ( $c <= "~" ) ) {
			$has['ascii'] = "ascii";
		} else {
			$has['binary'] = "binary";
		}
	}
	mb_internal_encoding( $current_encoding );
	
	return $has;
}

$string = "1234asdfA£^_{}|}~žščř";
foreach ( get_character_classes( $string ) as $k => $v ) {
	echo $k . " : " . $v . PHP_EOL;
}
//numeric : numeric
//alpha : alpha
//alphalower : alphalower
//alphaupper : alphaupper
//currency : currency
//ascii : ascii
//binary : binary

```
## 文章参考
- <http://php.net/manual/en/function.mb-substr.php>
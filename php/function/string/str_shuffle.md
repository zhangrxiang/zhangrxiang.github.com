# str_shuffle
> - (PHP 4 >= 4.3.0, PHP 5, PHP 7)
> - str_shuffle — Randomly shuffles a string
> - str_shuffle — 随机打乱一个字符串

## Description
```php
string str_shuffle ( string $str )
//str_shuffle() shuffles a string. One permutation of all possible is created.
//str_shuffle() 函数打乱一个字符串，使用任何一种可能的排序方案。
```
Caution
> - This function does not generate cryptographically secure values, and should not be used for cryptographic purposes. If you need a cryptographically secure value, consider using random_int(), random_bytes(), or openssl_random_pseudo_bytes() instead.
> - 本函数并不会生成安全加密的值，不应用于加密用途。若需要安全加密的值，考虑使用openssl_random_pseudo_bytes()。

## Parameters
### str
- The input string.
- 输入字符串。

## Return Values
- Returns the shuffled string.
- 返回打乱后的字符串。

## Changelog
> - 7.1.0	The internal randomization algorithm has been changed to use the » Mersenne Twister Random Number Generator instead of the libc rand function.
> - 内置的随机算法从 libc rand 函数改成了» 梅森旋转演伪随机数发生算法。

## Examples
```php
<?php
/**
 * Created by PhpStorm.
 * User: zhangrongxiang
 * Date: 2018/3/7
 * Time: 下午10:04
 */

$str = "abcde";
echo str_shuffle( $str ) . PHP_EOL;
echo str_shuffle( $str ) . PHP_EOL;
echo str_shuffle( $str ) . PHP_EOL;
echo str_shuffle( $str ) . PHP_EOL;

/////////////////////////////////////////////////////////////////////////////////
function scramble_word( $word ) {
	if ( strlen( $word ) < 2 ) {
		return $word;
	} else {
		return $word{0} . str_shuffle( substr( $word, 1, - 1 ) ) . $word{strlen( $word ) - 1};
	}
}

//echo preg_replace('/(\w+)/e', 'scramble_word("\1")', 'A quick brown fox jumped over the lazy dog.');
echo scramble_word( "A quick brown fox jumped over the lazy dog." ) . PHP_EOL;

///////////////////////////////////////////////////////////////////////////////
/**This function is affected by srand():*/
srand( 12345 );
echo str_shuffle( 'Randomize me' ) . PHP_EOL; // demmiezR aon
echo str_shuffle( 'Randomize me' ) . PHP_EOL; //izadmeo Rmen

srand( 12345 );
echo str_shuffle( 'Randomize me' ) . PHP_EOL; // demmiezR aon

////////////////////////////////////////////////////////////////////////////
// not very true
srand(time());
function unicode_shuffle( $string, $chars, $format = 'UTF-8' ) {
	$rands = [];
	for ( $i = 0; $i < $chars; $i ++ ) {
		$rands[ $i ] = rand( 0, mb_strlen( $string, $format ) );
	}
	$s = null;
	foreach ( $rands as $r ) {
		$s .= mb_substr( $string, $r, 1, $format );
	}
	
	return $s;
}

echo unicode_shuffle( "万物结对象", 3 ) . PHP_EOL;
```

## See
- <http://php.net/manual/zh/function.str_shuffle.php>

### *All rights reserved*

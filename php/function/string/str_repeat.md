# str_repeat
> - (PHP 4, PHP 5, PHP 7)
> - str_repeat — Repeat a string
> - str_repeat — 重复一个字符串

## Description
```php
string str_repeat ( string $input , int $multiplier )
//Returns input repeated multiplier times.
//返回 input 重复 multiplier 次后的结果。

```
## Parameters
### input
- The string to be repeated.
- 待操作的字符串。

### multiplier
- Number of time the input string should be repeated.
- input 被重复的次数。

- multiplier has to be greater than or equal to 0. If the multiplier is set to 0, the function will return an empty string.
- multiplier 必须大于等于 0。如果 multiplier 被设置为 0，函数返回空字符串。

## Return Values
- Returns the repeated string.
- 返回重复后的字符串。

## Examples
```php
<?php
/**
 * Created by PhpStorm.
 * User: zhangrongxiang
 * Date: 2018/2/20
 * Time: 下午11:50
 */
//------------------------------
echo str_repeat( "-", 30 ) . PHP_EOL;
//******************************
echo str_repeat( "*", 30 ) . PHP_EOL;

////////////////////////////////////////////////////////////////
$input      = 'bar';
$multiplier = 5;
$separator  = ',';
//bar,bar,bar,bar,bar
echo implode( $separator, array_fill( 0, $multiplier, $input ) ) . PHP_EOL;

//?,?,?
echo implode( ',', array_fill( 0, 3, '?' ) ) . PHP_EOL;


$my_head = str_repeat( "°~", 35 );
echo strlen( $my_head ) . PHP_EOL; // 105
echo mb_strlen( $my_head, 'UTF-8' ) . PHP_EOL; // 70
echo strlen( "°" ) . PHP_EOL;//2
echo strlen( "~" ) . PHP_EOL;//1
//°~°~°~°~°~°~°~°~°~°~°~°~°~°~°~°~°~°~°~°~°~°~°~°~°~°~°~°~°~°~°~°~°~°~°~
echo $my_head . PHP_EOL;
```

## See
- <http://php.net/manual/zh/function.str_repeat.php>

### *All rights reserved*

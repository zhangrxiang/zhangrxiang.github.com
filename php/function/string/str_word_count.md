# str_word_count
> - (PHP 4 >= 4.3.0, PHP 5, PHP 7)
> - str_word_count — Return information about words used in a string
> - str_word_count — 返回字符串中单词的使用情况

## Description
```php
mixed str_word_count ( 
    string $string [, 
    int $format = 0 [, 
    string $charlist ]] 
    )
/**
Counts the number of words inside string. If the optional format is not specified, then the return value will be an integer representing the number of words found. In the event the format is specified, the return value will be an array, content of which is dependent on the format. The possible value for the format and the resultant outputs are listed below.
统计 string 中单词的数量。如果可选的参数 format 没有被指定，那么返回值是一个代表单词数量的整型数。如果指定了 format 参数，返回值将是一个数组，数组的内容则取决于 format 参数。format 的可能值和相应的输出结果如下所列。
For the purpose of this function, 'word' is defined as a locale dependent string containing alphabetic characters, which also may contain, but not start with "'" and "-" characters.
对于这个函数的目的来说，单词的定义是一个与区域设置相关的字符串。这个字符串可以包含字母字符，也可以包含 "'" 和 "-" 字符（但不能以这两个字符开始）。
*/
```

## Parameters
### string
- The string
- 字符串。

### format
- Specify the return value of this function. The current supported values are:
- 指定函数的返回值。当前支持的值如下：

> - 0 - returns the number of words found 返回单词数量
> - 1 - returns an array containing all the words found inside the string 返回一个包含 string 中全部单词的数组
> - 2 - returns an associative array, where the key is the numeric position of the word inside the string and the value is the actual word itself 返回关联数组。数组的键是单词在 string 中出现的数值位置，数组的值是这个单词


### charlist
- A list of additional characters which will be considered as 'word'
- 附加的字符串列表，其中的字符将被视为单词的一部分。

## Return Values
- Returns an array or an integer, depending on the format chosen.
- 返回一个数组或整型数，这取决于 format 参数的选择。

## Changelog
- 5.1.0	Added the charlist parameter

## Examples
```
<?php
/**
 * Created by PhpStorm.
 * User: zhangrongxiang
 * Date: 2018/3/8
 * Time: 下午9:48
 */
$str = "Hello fri3nd, you're
       looking          good today!";

//[0] => Hello
//[1] => fri
//[2] => nd
//[3] => you're
//[4] => looking
//[5] => good
//[6] => today
print_r( str_word_count( $str, 1 ) );

//[0] => Hello
//[6] => fri
//[10] => nd
//[14] => you're
//[28] => looking
//[45] => good
//[50] => today
print_r( str_word_count( $str, 2 ) );

//[0] => Hello
//[1] => fri3nd
//[2] => you're
//[3] => looking
//[4] => good
//[5] => today
print_r( str_word_count( $str, 1, 'àáãç3' ) );

//[0] => Hello
//[1] => fri3nd
//[2] => you're
//[3] => looking
//[4] => good
//[5] => today
//[6] => look123
//[7] => ing
$str = "Hello fri3nd, you're
       looking          good today!
       look1234ing";
print_r( str_word_count( $str, 1, '0..3' ) );

```
## See
- <http://php.net/manual/zh/function.str_word_count.php>

### *All rights reserved*
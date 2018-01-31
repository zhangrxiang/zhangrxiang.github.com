# mb_substr_count
> - (PHP 4 >= 4.3.0, PHP 5, PHP 7)
> - mb_substr_count — Count the number of substring occurrences
> - mb_substr_count — 统计字符串出现的次数

## Description
```php
int mb_substr_count ( 
    string $haystack , 
    string $needle [, 
    string $encoding = mb_internal_encoding() ] 
    )
//Counts the number of times the needle substring occurs in the haystack string.
//统计子字符串 needle 出现在字符串 haystack 中的次数。
```
## Parameters
### haystack
- The string being checked.
- 要检查的字符串。

### needle
- The string being found.
- 待查找的字符串。

### encoding
- The encoding parameter is the character encoding. If it is omitted, the internal character encoding value will be used.
- encoding 参数为字符编码。如果省略，则使用内部字符编码。

## Return Values
- The number of times the needle substring occurs in the haystack string.
- 子字符串 needle 出现在字符串 haystack 中的次数。

## Examples
```php
<?php
/**
 * Created by PhpStorm.
 * User: zhangrongxiang
 * Date: 2018/1/31
 * Time: 下午10:07
 */

echo mb_substr_count( "This is a test", "is" ) . PHP_EOL; // 输出 2
echo mb_substr_count( "This is a test", " " ) . PHP_EOL; // 输出 3
echo mb_substr_count( "hello 中国！ 中国 ! 中国！ hello", "中国" ) . PHP_EOL; //3
echo mb_substr_count( "hello 中国！ 中国 ! 中国！ hello", "中国", "gbk" ) . PHP_EOL; //3
echo mb_substr_count( "hello 中国！ 中国 ! 中国！ hello", "中国", "utf-8" ) . PHP_EOL; //3
echo mb_substr_count( "hello 中国！ 中国 ! 中国！ hello", "中国", "ascii" ) . PHP_EOL; //3

echo "strlen : " . mb_strlen( "hello 中国！ 中国 ! 中国！ hello" ) . PHP_EOL; //24
echo "mb_strlen : " . strlen( "hello 中国！ 中国 ! 中国！ hello" ) . PHP_EOL; //40 = 8*3 + 16
echo substr_count( "hello 中国！ 中国 ! 中国！ hello", "中国" ) . PHP_EOL; //3
echo substr_count( "hello 中国！ 中国 ! 中国！ hello", "中国", 2, 10 ) . PHP_EOL; //1

```

## 文章参考
- <http://php.net/manual/en/function.mb-substr-count.php>
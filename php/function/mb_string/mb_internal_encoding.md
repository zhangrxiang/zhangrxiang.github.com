# mb_internal_encoding

> - (PHP 4 >= 4.0.6, PHP 5, PHP 7)
> - mb_internal_encoding — Set/Get internal character encoding
> - 设置或获取内部字符集

## Description

```PHP
mixed mb_internal_encoding ([ string $encoding = mb_internal_encoding() ] )
//Set/Get the internal character encoding
```

## Parameters
### encoding
- encoding is the character encoding name used for the HTTP input character encoding conversion, HTTP output character encoding conversion, and the default character encoding for string functions defined by the mbstring module. You should notice that the internal encoding is totally different from the one for multibyte regex.

- 字符编码用于HTTP输入，输出字符编码转换，默认的字符编码由mbstring模块字符串函数定义的。你应该注意到内部编码完全不同于多字节的正则表达式。

## Return Values
- If encoding is set, then Returns TRUE on success or FALSE on failure. In this case, the character encoding for multibyte regex is NOT changed. If encoding is omitted, then the current character encoding name is returned.

- 如果设置了编码，则成功返回TRUE或失败时返回FALSE。在这种情况下，对多字节字符编码不改变正则表达式。如果省略编码，则返回当前字符编码名称。

## Examples

```php
<?php
/**
 * Created by PhpStorm.
 * User: zhangrongxiang
 * Date: 2018/1/26
 * Time: 下午10:18
 */

/* Set internal character encoding to UTF-8 */
mb_internal_encoding("UTF-8");
/* Display current internal character encoding */
echo mb_internal_encoding().PHP_EOL; // UTF-8

mb_internal_encoding("GBK");
echo mb_internal_encoding().PHP_EOL; //CP936
mb_internal_encoding("CP936");
echo mb_internal_encoding().PHP_EOL; //CP936

mb_internal_encoding("iso-8859-1");
echo mb_internal_encoding().PHP_EOL; //ISO-8859-1

```

## 文章参考
- <http://php.net/manual/en/function.mb-internal-encoding.php>




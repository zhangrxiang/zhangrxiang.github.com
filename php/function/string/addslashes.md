# addslashes

> - (PHP 4, PHP 5, PHP 7)
> - addslashes — Quote string with slashes
> - addslashes — 使用反斜线引用字符串

## Description
```php
string addslashes ( string $str )
// Returns a string with backslashes added before characters that need to be escaped. These characters are:
// 返回字符串，该字符串为了数据库查询语句等的需要在某些字符前加上了反斜线。这些字符: 
- single quote (') 单引号（'）
- double quote (") 双引号（"）
- backslash (\) 反斜线（\）
- NUL (the NUL byte) NUL（NULL 字符）
```

- A use case of addslashes() is escaping the aforementioned characters in a string that is to be evaluated by PHP:
- 一个使用 addslashes() 的例子是当你要往数据库中输入数据时。

```php
<?php
$str = "O'Reilly?";
eval("echo '" . addslashes($str) . "';");
```

- Prior to PHP 5.4.0, the PHP directive magic_quotes_gpc was on by default and it essentially ran addslashes() on all GET, POST and COOKIE data. addslashes() must not be used on strings that have already been escaped with magic_quotes_gpc, as the strings will be double escaped. get_magic_quotes_gpc() can be used to check if magic_quotes_gpc is on.
- 例如，将名字 O'reilly 插入到数据库中，这就需要对其进行转义。 强烈建议使用 DBMS 指定的转义函数 （比如 MySQL 是 mysqli_real_escape_string()，PostgreSQL 是 pg_escape_string()），但是如果你使用的 DBMS 没有一个转义函数，并且使用 \ 来转义特殊字符，你可以使用这个函数。 仅仅是为了获取插入数据库的数据，额外的 \ 并不会插入。 当 PHP 指令 magic_quotes_sybase 被设置成 on 时，意味着插入 ' 时将使用 ' 进行转义。

- The addslashes() is sometimes incorrectly used to try to prevent SQL Injection. Instead, database-specific escaping functions and/or prepared statements should be used.
- PHP 5.4 之前 PHP 指令 magic_quotes_gpc 默认是 on， 实际上所有的 GET、POST 和 COOKIE 数据都用被 addslashes() 了。 不要对已经被 magic_quotes_gpc 转义过的字符串使用 addslashes()，因为这样会导致双层转义。 遇到这种情况时可以使用函数 get_magic_quotes_gpc() 进行检测。

## Parameters
### str
- The string to be escaped.
- 要转义的字符。

## Return Values
- Returns the escaped string.
- 返回转义后的字符。

## Examples
```php
<?php
/**
 * Created by PhpStorm.
 * User: zhangrongxiang
 * Date: 2018/2/13
 * Time: 下午7:41
 */
$str = 'just do it!';
//  just do it!
echo addslashes( $str ) . PHP_EOL;
$str = "just do it!";
//  just do it!
echo addslashes( $str ) . PHP_EOL;
$str = '\a\b\'';
//  \\a\\b\'
echo addslashes( $str ) . PHP_EOL;
$str = '\\';
//  \\
echo addslashes( $str ) . PHP_EOL;
```

## See
- <http://php.net/manual/en/function.addslashes.php>

### *All rights reserved*
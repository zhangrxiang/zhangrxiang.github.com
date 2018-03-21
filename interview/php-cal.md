# PHP CAL
### 不用新变量直接交换现有两个变量的值
```php
// 1： 
    list($a, $b) = array($b, $a);
// 2： 
    $a = $a . $b;
    $b = strlen( $b );
    $b = substr( $a, 0, (strlen($a) – $b ) );
    $a = substr( $a, strlen($b) );

// 3:(必须用一个两个字符串都都不能出现的字符做为分隔符)
    $a = $b.','.$a ;
    $a = explode(',', $a);
    $b = $a[1];
    $a = $a[0];

// 4：这个是当两个数都是数字的时候:
    $a = $a + $b;
    $b = $a – $b;
    $a = $a – $b;

// 5：借助数组
    $a = array($a,$b);
    $b = $a[0];
    $a = $a[1];
```

### 写个函数来解决多线程同时读写一个文件的问题。
```php
<?php
    $fp = fopen("/tmp/lock.txt","w+");
    if(flock($fp, LOCK_EX)){// 进行排它型锁定
        fwrite($fp,"Write something here\n");
        flock($fp, LOCK_UN);// 释放锁定
    }else{
        echo "Couldn't lock the file !";
    }
    fclose($fp);
```

### 写一个函数，可以遍历文件夹下的所有文件和文件夹。
```php
function get_dir_info($path){
    $handle = opendir($path);//打开目录返回句柄
    while(($content = readdir($handle))!== false){
        $new_dir = $path . DIRECTORY_SEPARATOR . $content;
        if($content == '..' || $content == '.'){
                continue;
        }
        if(is_dir($new_dir)){
                echo "<br>目录：".$new_dir . '<br>';
                get_dir_info($new_dir);
        }else{
                echo "文件：".$path.':'.$content .'<br>';
        }
    }
}
get_dir_info($dir);
```

### PHP如何获取客户端的IP地址？用`$_SERVER`获取的IP地址有什么问题？
`$_SERVER['REMOTE_ADDR'] ;`通过全局数组来获得 
`getenv('REMOTE_ADDR') ;` 通过环境变量来获得
当客户机使用代理的时候获取不到真实的`IP`地址

### 正则表达式
- 匹配`中文字符`的正则表达式： `[\u4e00-\u9fa5]` 
- 匹配`双字节字符`(包括汉字在内)：`[^\x00-\xff]` 
- 匹配`空行`的正则表达式：`\n[\s| ]*\r` 
- 匹配`HTML标记`的正则表达式：`/<(.*)>.*<\/\1>|<(.*) \/>/` 
- 匹配`首尾空格`的正则表达式：`(^\s*)|(\s*$)` 
- 匹配`Email`地址的正则表达式：`\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*` 
- 匹配`网址URL`的正则表达式：`^[a-zA-z]+://(\\w+(-\\w+)*)(\\.(\\w+(-\\w+)*))*(\\?\\S*)?$` 
- 匹配`帐号`是否合法(字母开头，允许5-16字节，允许字母数字下划线)：`^[a-zA-Z][a-zA-Z0-9_]{4,15}$` 
- 匹配`国内电话`号码：`(\d{3}-|\d{4}-)?(\d{8}|\d{7})?` 
- 匹配`QQ号`：`^[1-9]*[1-9][0-9]*$` 

### 写一个函数得到`header`头信息
```php
function getHeader(){
    $headers = [];
    if (function_exists('getallheaders')) {
        $headers = getallheaders();
    } elseif (function_exists('http_get_request_headers')) {
        $headers = http_get_request_headers();
    } else {
        foreach ($_SERVER as $key => $value) {
            if(strstr($key, 'HTTP_')) {
                $newk = ucwords(strtolower(str_replace('_', '-', substr($key, 5))));
                $headers[$newk] = $value;
            }
        }
    }

    var_dump($headers);
}
```

### 打印出前一天的时间格式是2009-02-10 22:21:21
```php
//1
echo date('Y-m-d H:i:s', strtotime('-1 day'));
//2
$yesterday = time() - (24 * 60 * 60);
echo 'today:'.date('Y-m-d H:i:s')."n";
echo 'yesterday:'. date('Y-m-d H:i:s', $yesterday)."n";
```

### 使用五种以上方式获取一个文件的扩展名
```php
get_ext1($file_name)
{    return strrchr($file_name, '.');}

get_ext2($file_name)
{    return substr($file_name, strrpos($file_name, '.'));}

get_ext3($file_name)
{    return array_pop(explode('.', $file_name));}

get_ext4($file_name)
{   $p = pathinfo($file_name);return $p['extension'];}

get_ext5($file_name)
{    return strrev(substr(strrev($file_name), 0, strpos(strrev($file_name), '.')));}
```

### 简述如何得到当前执行脚本路径，包括所得到参数。
访问http://temp.com/phpinfo.php?id=1
```php
echo $_SERVER['SCRIPT_URL']; //得到/phpinfo.php
echo $_SERVER["SCRIPT_URI"]; //得到http://temp.com/phpinfo.php
echo $_SERVER["SCRIPT_FILENAME"]; //得到F:/www/Temp/phpinfo.php
echo $_SERVER["REQUEST_URI"]; //得到/phpinfo.php?id=1
echo $_SERVER["SCRIPT_NAME"]; //得到/phpinfo.php
```
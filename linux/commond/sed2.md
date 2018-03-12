# Sed
> - SED的英文全称是 Stream EDitor，它是一个简单而强大的文本解析转换工具，在1973-1974年期间由贝尔实验室的Lee E. McMahon开发，今天，它已经运行在所有的主流操作系统上了。
> - McMahon创建了一个通用的行编辑器，最终变成为了SED。SED的很多语法和特性都借鉴了ed编辑器。设计之初，它就已经支持正则表达式，SED可以从文件中接受类似于管道的输入，也可以接受来自标准输入流的输入。
> - SED由自由软件基金组织（FSF）开发和维护并且随着GNU/Linux进行分发，因此，通常它也称作 GNU SED。对于新手来说，SED的语法看起来可能有些神秘，但是，一旦掌握了它的语法，你就可以只用几行代码去解决非常复杂的任务，这就是SED的魅力所在。

## DESCRIPTION  
### 工作流
1. 读取： SED从输入流（文件，管道或者标准输入）中读取一行并且存储到它叫做 模式空间（pattern buffer） 的内部缓冲区
2. 执行： 默认情况下，所有的SED命令都在模式空间中顺序的执行，除非指定了行的地址，否则SED命令将会在所有的行上依次执行
3. 显示： 发送修改后的内容到输出流。在发送数据之后，模式空间将会被清空。
4. 在文件所有的内容都被处理完成之前，上述过程将会重复执行

### 注意
- 模式空间 （`pattern buffer`） 是一块活跃的缓冲区，在sed编辑器执行命令时它会保存待检查的文本
- 默认情况下，所有的SED命令都是在模式空间中执行，因此输入文件并不会发生改变
- 还有另外一个缓冲区叫做 保持空间 （`hold buffer`），在处理模式空间中的某些行时，可以用保持空间来临时保存一些行。在每一个循环结束的时候，SED将会移除模式空间中的内容，但是该缓冲区中的内容在所有的循环过程中是持久存储的。SED命令无法直接在该缓冲区中执行，因此SED允许数据在 保持空间 和 模式空间之间切换
- 初始情况下，保持空间 和 模式空间 这两个缓冲区都是空的
- 如果没有提供输入文件的话，SED将会从标准输入接收请求
- 如果没有提供地址范围的话，默认情况下SED将会对所有的行进行操作

## 语法
```bash
sed [-n] [-e] 'command(s)' files 
sed [-n] -f scriptfile files
```
- 第一种方式在命令行中使用单引号指定要执行的命令
- 第二种方式则指定了包含SED命令的脚本文件。

当然，这两种方法也可以同时使用，SED提供了很多参数用于控制这种行为。
让我们看看如何指定多个SED命令。SED提供了delete命令用于删除某些行，这里让我们删除第一行，第二行和第五行：
```
$ cat books.txt 
1) A Storm of Swords, George R. R. Martin, 1216 
2) The Two Towers, J. R. R. Tolkien, 352 
3) The Alchemist, Paulo Coelho, 197 
4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
5) The Pilgrimage, Paulo Coelho, 288 
6) A Game of Thrones, George R. R. Martin, 864
```
使用Sed移除指定的行，删除三行，使用-e选项指定三个独立的命令

```bash
# 3) The Alchemist, Paulo Coelho, 197 
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 6) A Game of Thrones, George R. R. Martin, 864
sed -e '1d' -e '2d' -e '5d' books.txt
```
将多个SED命令写在一个文本文件中，然后将该文件作为SED命令的参数，SED可以对模式空间中的内容执行文件中的每一个命令
```bash
echo -e "1d\n2d\n5d" > commands.txt 
# 1d
# 2d
# 5d
cat commands.txt
# 3) The Alchemist, Paulo Coelho, 197 
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 6) A Game of Thrones, George R. R. Martin, 864
sed -f commands.txt books.txt
```

### 标准选项
#### `-n`
- 默认情况下，模式空间中的内容在处理完成后将会打印到标准输出，该选项用于阻止该行为
```bash
# 1) A Storm of Swords, George R. R. Martin, 1216 
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 3) The Alchemist, Paulo Coelho, 197 
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 5) The Pilgrimage, Paulo Coelho, 288 
# 6) A Game of Thrones, George R. R. Martin, 864
sed '' books.txt
```
#### `-e` 
- 指定要执行的命令，使用该参数，我们可以指定多个命令
```bash
# 1) A Storm of Swords, George R. R. Martin, 1216 
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 3) The Alchemist, Paulo Coelho, 197 
sed -n -e '1p' -e '2p' -e '3p' books.txt
```

#### `-f` 
- 指定包含要执行的命令的脚本文件

### GNU选项
#### `-n， –quiet, –slient`
- 与标准的`-n`选项相同

#### `-e script，–expression=script`
- 与标准的-e选项相同

#### `-f script-file， –file=script-file`
- 与标准的-f选项相同

#### `–follow-symlinks`
- 如果提供该选项的话，在编辑的文件是符号链接时，SED将会跟随链接
#### `-i[SUFFIX]，–in-place[=SUFFIX]`
- 该选项用于对当前文件进行编辑，如果提供了SUFFIX的话，将会备份原始文件，否则将会覆盖原始文件

#### `-l N， –line-lenght=N`
- 该选项用于设置行的长度为N个字符

#### `–posix`
- 该选项禁用所有的GNU扩展

#### `-r，–regexp-extended`
- 该选项将启用扩展的正则表达式

#### `-u， –unbuffered`
- 指定该选项的时候，SED将会从输入文件中加载最少的数据，并且更加频繁的刷出到输出缓冲区。在编辑tail -f命令的输出，你不希望等待输出的时候该选项是非常有用的。

#### `-z，–null-data`
- 默认情况下，SED对每一行使用换行符分割，如果提供了该选项的话，它将使用NULL字符分割行

### 模式空间和保持空间
#### 模式空间
```bash
$ vim books.txt 
1) A Storm of Swords, George R. R. Martin, 1216 
2) The Two Towers, J. R. R. Tolkien, 352 
3) The Alchemist, Paulo Coelho, 197 
4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
5) The Pilgrimage, Paulo Coelho,288 
6) A Game of Thrones, George R. R. Martin, 864
```
执行p命令
```bash
$ sed 'p' books.txt
1) A Storm of Swords, George R. R. Martin, 1216 
1) A Storm of Swords, George R. R. Martin, 1216 
2) The Two Towers, J. R. R. Tolkien, 352 
2) The Two Towers, J. R. R. Tolkien, 352 
3) The Alchemist, Paulo Coelho, 197 
3) The Alchemist, Paulo Coelho, 197 
4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
5) The Pilgrimage, Paulo Coelho, 288 
5) The Pilgrimage, Paulo Coelho, 288 
6) A Game of Thrones, George R. R. Martin, 864 
6) A Game of Thrones, George R. R. Martin, 864
```
被显示了两次!

默认情况下，SED将会输出模式空间中的内容，另外，我们的命令中包含了输出命令p，因此每一行被打印两次。但是不要担心，SED提供了`-n`参数用于禁止自动输出模式空间的每一行的行为
```bash
$ sed -n 'p' books.txt 
1) A Storm of Swords, George R. R. Martin, 1216 
2) The Two Towers, J. R. R. Tolkien, 352 
3) The Alchemist, Paulo Coelho, 197 
4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
5) The Pilgrimage, Paulo Coelho, 288 
6) A Game of Thrones, George R. R. Martin, 864
```

#### 行寻址
默认情况下，在SED中使用的命令会作用于文本数据的所有行。如果只想将命令作用于特定的行或者某些行，则需要使用 行寻址 功能。
- 数字形式表示的行区间
- 文本模式来过滤行

```bash
[address]command
```
##### 数字方式的行寻址
```bash
# 3) The Alchemist, Paulo Coelho, 197 
sed -n '3p' books.txt
#2---5
sed -n '2,5 p' books.txt 
# 6) A Game of Thrones, George R. R. Martin, 864
sed -n '$ p' books.txt 
# 第三行到最后一行
sed -n '3,$ p' books.txt
# M, +n 将会打印出从第M行开始的下n行
sed -n '2,+4 p' books.txt
# M~N的形式，它告诉SED应该处理M行开始的每N行,50~5匹配行号50，55，60，65
# 奇数行
sed -n '1~2 p' books.txt 
# 偶数行
sed -n '2~2 p' books.txt 
```

##### 文本模式过滤器        
```bash
/pattern/command
```             
必须用正斜线将要指定的pattern封起来。sed编辑器会将该命令作用到包含指定文本模式的行上。         
```bash
# 3) The Alchemist, Paulo Coelho, 197 
# 5) The Pilgrimage, Paulo Coelho, 288 
sed -n '/Paulo/ p' books.txt

# 第一次匹配到Alchemist开始输出，直到第5行为止。
# 3) The Alchemist, Paulo Coelho, 197 
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 5) The Pilgrimage, Paulo Coelho, 288 
sed -n '/Alchemist/, 5 p' books.txt

# 使用逗号（,）操作符指定匹配多个匹配的模式。下列的示例将会输出Two和Pilgrimage之间的所有行
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 3) The Alchemist, Paulo Coelho, 197 
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 5) The Pilgrimage, Paulo Coelho, 288 
sed -n '/Two/, /Pilgrimage/ p' books.txt

# 第一次Two出现的位置开始输出接下来的4行
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 3) The Alchemist, Paulo Coelho, 197 
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 5) The Pilgrimage, Paulo Coelho, 288 
# 6) A Game of Thrones, George R. R. Martin, 864
sed -n '/Two/, +4 p' books.txt 
```       

### 保持空间
在处理模式空间中的某些行时，可以用保持空间来临时保存一些行。有5条命令可用来操作保持空间
- `h`   将模式空间复制到保持空间
- `H`	将模式空间附加到保持空间
- `g`	将保持空间复制到模式空间
- `G`	将保持空间附加到模式空间
- `x`	交换模式空间和保持空间的内容

```bash
# 1) A Storm of Swords, George R. R. Martin, 1216 , 2) The Two Towers, J. R. R. Tolkien, 352 
# - 3) The Alchemist, Paulo Coelho, 197 , 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# - 5) The Pilgrimage, Paulo Coelho, 288 , 6) A Game of Thrones, George R. R. Martin, 864
sed -n 'h;n;H;x;s/\n/, /;/Paulo/!b Print; s/^/- /; :Print;p' books.txt
```

#### 删除命令 `d`
```bash
[address1[,address2]]d
```
`address1`和`address2`是开始和截止地址，它们可以是行号或者字符串匹配模式，这两种地址都是可选的。
```bash
#
sed 'd' books.txt

# 移除第四行
# 1) A Storm of Swords, George R. R. Martin, 1216 
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 3) The Alchemist, Paulo Coelho, 197 
# 5) The Pilgrimage, Paulo Coelho, 288 
# 6) A Game of Thrones, George R. R. Martin, 864
sed '4d' books.txt 

# 移除N1到N2行
# 1) A Storm of Swords, George R. R. Martin, 1216 
# 5) The Pilgrimage, Paulo Coelho, 288 
# 6) A Game of Thrones, George R. R. Martin, 864
sed '2, 4 d' books.txt   

# 除所有作者为Paulo Coelho的书籍
# 1) A Storm of Swords, George R. R. Martin, 1216 
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 6) A Game of Thrones, George R. R. Martin, 864
sed '/Paulo Coelho/d' books.txt 

# 移除所有以Storm和Fellowship开头的行
# 5) The Pilgrimage, Paulo Coelho, 288 
# 6) A Game of Thrones, George R. R. Martin, 864
sed '/Storm/,/Fellowship/d' books.txt  
```

#### 文件写入命令 `w`
```bash
[address1[,address2]]w file
```
`w`指定是写命令， `file`指的是存储文件内容的文件名。使用`file`操作符的时候要小心，当提供了文件名但是文件不存在的时候它会自动创建，如果已经存在的话则会覆盖原文件的内容。
```bash
# 创建文件books.txt的副本，在 w 和 file 之间只能有一个空格
sed -n 'w books.bak' books.txt
#
diff books.txt books.bak
# 会存储文件中的偶数行到另一个文件
sed -n '2~2 w zing.txt' books.txt 
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 6) A Game of Thrones, George R. R. Martin, 864
cat zing.txt 
# 存储所有独立作者的书到单独的文件
sed -n -e '/Martin/ w Martin.txt' -e '/Paulo/ w Paulo.txt' -e '/Tolkien/ w Tolkien.txt' books.txt  
# 1) A Storm of Swords, George R. R. Martin, 1216 
# 6) A Game of Thrones, George R. R. Martin, 864
cat Martin.txt
# 3) The Alchemist, Paulo Coelho, 197 
# 5) The Pilgrimage, Paulo Coelho, 288 
cat Paulo.txt
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
cat Tolkien.txt
```
##### 追加命令 `a`
```
[address]a\ 
Append text
```
```bash
# 1) A Storm of Swords, George R. R. Martin, 1216 
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 3) The Alchemist, Paulo Coelho, 197 
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 7) Adultry, Paulo Coelho, 234
# 5) The Pilgrimage, Paulo Coelho, 288 
# 6) A Game of Thrones, George R. R. Martin, 864
sed '4 a 7) Adultry, Paulo Coelho, 234' books.txt

# 1) A Storm of Swords, George R. R. Martin, 1216 
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 3) The Alchemist, Paulo Coelho, 197 
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 5) The Pilgrimage, Paulo Coelho, 288 
# 6) A Game of Thrones, George R. R. Martin, 864
# 7) Adultry, Paulo Coelho, 234
sed '$ a 7) Adultry, Paulo Coelho, 234' books.txt

# 1) A Storm of Swords, George R. R. Martin, 1216 
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 3) The Alchemist, Paulo Coelho, 197 
# 7) Adultry, Paulo Coelho, 234
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 5) The Pilgrimage, Paulo Coelho, 288 
# 6) A Game of Thrones, George R. R. Martin, 864
sed '/The Alchemist/ a 7) Adultry, Paulo Coelho, 234' books.txt  
```

##### 行替换命令 `c`
> SED通过 c 提供了 change 和 replace 命令，该命令帮助我们使用新文本替换已经存在的行，当提供行的地址范围时，所有的行都被作为一组被替换为单行文本，下面是该命令的语法
```bash
[address1[,address2]]c\ 
Replace text
```

```bash
# 替换文本中的第三行为新的内容
# 1) A Storm of Swords, George R. R. Martin, 1216 
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 3) Adultry, Paulo Coelho, 324
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 5) The Pilgrimage, Paulo Coelho, 288 
# 6) A Game of Thrones, George R. R. Martin, 864
sed '3 c 3) Adultry, Paulo Coelho, 324' books.txt

# 接受模式作为地址
# 1) A Storm of Swords, George R. R. Martin, 1216 
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 3) Adultry, Paulo Coelho, 324
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 5) The Pilgrimage, Paulo Coelho, 288 
# 6) A Game of Thrones, George R. R. Martin, 864
sed '/The Alchemist/ c 3) Adultry, Paulo Coelho, 324' books.txt

# 将第4-6行内容替换为单行
# 1) A Storm of Swords, George R. R. Martin, 1216 
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 3) The Alchemist, Paulo Coelho, 197 
# 4) Adultry, Paulo Coelho, 324
sed '4, 6 c 4) Adultry, Paulo Coelho, 324' books.txt 
```

##### 插入命令 `i`
> 插入命令与追加命令类似，唯一的区别是插入命令是在匹配的位置前插入新的一行。

```bash
[address]i\ 
Insert text
```
```bash
# 1) A Storm of Swords, George R. R. Martin, 1216 
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 3) The Alchemist, Paulo Coelho, 197 
# 7) Adultry, Paulo Coelho, 324
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 5) The Pilgrimage, Paulo Coelho, 288 
# 6) A Game of Thrones, George R. R. Martin, 864
# 在第四行前插入新的一行
sed '4 i 7) Adultry, Paulo Coelho, 324' books.txt
```

##### 转换命令 `y`
> 转换（Translate）命令 y 是唯一可以处理单个字符的sed编辑器命令。

```bash
[address]y/inchars/outchars/
```
转换命令会对`inchars`和`outchars`值进行一对一的映射。`inchars`中的第一个字符会被转换为`outchars`中的第一个字符，第二个字符会被转换成`outchars`中的第二个字符。这个映射过程会一直持续到处理完指定字符。如果`inchars`和`outchars`的长度不同，则sed编辑器会产生一条错误消息。
```bash
# I V IV XX
echo "1 5 15 20" | sed 'y/151520/IVXVXX/'
```

##### 输出隐藏字符命令 `l`
```
[address1[,address2]]l 
[address1[,address2]]l [len]
```
```bash
sed 's/ /\t/g' books.txt > junk.txt
sed -n 'l' junk.txt
# 本按照指定的宽度换行
sed -n 'l 25' books.txt
```
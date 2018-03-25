# sed
## NAME
> - sed - stream editor for filtering and transforming text
> - 文本流编辑，sed是一个“非交互式的”面向字符流的编辑器。能同时处理多个文件多行的内容，可以不对原文件改动，把整个文件输入到屏幕,可以把只匹配到模式的内容输入到屏幕上。还可以对原文件改动，但是不会再屏幕上返回结果。

## SYNOPSIS
> - sed [OPTION]... {script-only-if-no-other-script} [input-file]...
> - sed的命令格式：sed [option] 'sed command'filename
> - sed的脚本格式：sed [option] -f 'sed script'filename

## DESCRIPTION
> Sed is a stream editor.  A stream editor is used to perform basictext transformations on an input stream (a file or input from apipeline).  While in some ways similar to an editor which permitsscripted edits (such as ed), sed works by making only one pass overthe input(s), and is consequently more efficient.  But it is sed'sability to filter text in a pipeline which particularly distinguishesit from other types of editors.

### sed的处理流程，简化后是这样的
- 读入新的一行内容到缓存空间；
- 从指定的操作指令中取出第一条指令，判断是否匹配pattern；
- 如果不匹配，则忽略后续的编辑命令，回到第2步继续取出下一条指令；
- 如果匹配，则针对缓存的行执行后续的编辑命令；完成后，回到第2步继续取出下一条指令；
- 当所有指令都应用之后，输出缓存行的内容；回到第1步继续读入下一行内容；
- 当所有行都处理完之后，结束；

### 动作
- a ：新增， a 的后面可以接字串，而这些字串会在新的一行出现(目前的下一行)～
- c ：取代， c 的后面可以接字串，这些字串可以取代 n1,n2 之间的行！
- d ：删除，因为是删除啊，所以 d 后面通常不接任何咚咚；
- i ：插入， i 的后面可以接字串，而这些字串会在新的一行出现(目前的上一行)；
- p ：打印，亦即将某个选择的数据印出。通常 p 会与参数 sed -n 一起运行～
- s ：取代，可以直接进行取代的工作哩！通常这个 s 的动作可以搭配正规表示法！例如 1,20s/old/new/g 就是啦！

### `-n, --quiet, --silent`
- suppress automatic printing of pattern space
- 设定为安静模式，不会输出默认打印信息，除非子命令中特别指定打印选项，则只会把匹配修改的行进行打印。

```bash
# A world
# nihao
echo -e 'hello world\nnihao' | sed 's/hello/A/'

# -n选项后什么也没有显示
echo -e 'hello world\nnihao' | sed -n 's/hello/A/'

# -n选项后，再加p标记，只会把匹配并修改的内容打印了出来
# A world
echo -e 'hello world\nnihao' | sed -n 's/hello/A/p'
```

### `-e script, --expression=script`
- add the script to the commands to be executed
- 对文本内容进行多种操作，则需要执行多条子命令来进行操作。

```bash
# A B
echo -e 'hello world' | sed -e 's/hello/A/' -e 's/world/B/'

# A B
echo -e 'hello world' | sed 's/hello/A/;s/world/B/'

```
### `-f script-file, --file=script-file`
- add the contents of script-file to the commands to be executed

```bash
echo "s/hello/A/
s/world/B/" > sed.script
# 多个子命令操作写入脚本文件，然后使用 -f 选项来指定该脚本
# A B
echo "hello world" | sed -f sed.script
```
### `--follow-symlinks`
- follow symlinks when processing in place

### `-i[SUFFIX], --in-place[=SUFFIX]`
> sed默认会把输入行读取到模式空间，简单理解就是一个内存缓冲区，sed子命令处理的内容是模式空间中的内容，而非直接处理文件内容。因此在sed修改模式空间内容之后，并非直接写入修改输入文件，而是打印输出到标准输出。

- edit files in place (makes backup if SUFFIX supplied)
- 如果需要修改输入文件，那么就可以指定-i选项

```bash
echo "hello world" > file.txt
# hello world
cat file.txt
# A world
sed 's/hello/A/' file.txt
# hello world
cat file.txt

# A world
sed -i 's/hello/A/' file.txt
# A world
cat file.txt

echo "hello world" > file.txt
if [ -f file.txt.bak ];then
    rm file.txt.bak
fi
# file.txt  sed.sh
ls .
# 把修改内容保存到file.txt，同时会以file.txt.bak文件备份原来未修改文件内容，以确保原始文件内容安全性，防止错误操作而无法恢复原来内容。
sed -i.bak 's/hello/A/' file.txt
# file.txt  file.txt.bak	sed.sh
ls .
# A world
cat file.txt
# hello world
cat file.txt.bak
```

### `-l N, --line-length=N`
- specify the desired line-wrap length for the `l' command

### `--posix`
- disable all GNU extensions.

### `-r, --regexp-extended`
- use extended regular expressions in the script.
- 支持扩展正则表达式。

```bash
#A A
echo "hello world" | sed -r 's/(hello)|(world)/A/g'
```

### `-s, --separate`
- consider files as separate rather than as a single continuous long stream.

### `-u, --unbuffered`
- load minimal amounts of data from the input files and flush the output buffers more often

### `-z, --null-data`
- separate lines by NUL characters

### `--help`
- display this help and exit

### `--version`
- output version information and exit

> If no `-e`, `--expression`, `-f`, or `--file` option is given, then the firstnon-option argument is taken as the sed script to interpret.  Allremaining arguments are names of input files; if no input files arespecified, then the standard input is read.

## COMMAND SYNOPSI
> This is just a brief synopsis of sed commands to serve as a reminder to those who already know sed; other documentation (such as the texinfo document) must be consulted for fuller descriptions.

### `Zero-address ``commands''`

#### `: label`
- Label for b and t commands.

#### `#comment`
- The comment extends until the next newline (or the end of a `-e` script fragment).

#### `}`
- The closing bracket of a `{ }` block.

### `Zero- or One- address commands`
#### `=`      
- Print the current line number.

#### `a \`
- text   Append text, which has each embedded newline preceded by a backslash.
- 在定位行号后附加新文本信息

#### `i \`
- text   Insert text, which has each embedded newline preceded by a backslash.
- 在定位行号后插入新文本信息

#### `q [exit-code]`
Immediately quit the sed script without processing any more input, except that if auto-print is not disabled the current pattern space will be printed.  The exit code argument is a GNU extension.       

#### `Q [exit-code]`
- Immediately quit the sed script without processing any more input.  This is a GNU extension.

#### `r filename`
- Append text read from filename.

#### `R filename`
Append a line read from filename.  Each invocation of the command reads a line from the file.  This is a GNU extension.

### `Commands which accept address ranges`
#### `{`
- Begin a block of commands (end with a }).

#### `b label`
- Branch to label; if label is omitted, branch to end of script.

#### `c \`
- text   Replace the selected lines with text, which has each embedded newline preceded by a backslash.

#### `d`
- Delete pattern space.Start next cycle.
- 删除定位行

#### `D`      
- If pattern space contains no newline, start a normal new cycle as if the d command was issued.  Otherwise, delete text in the pattern space up to the first newline, and restart cycle with the resultant pattern space, without reading a new line of input.

#### `h H`    
- Copy/append pattern space to hold space.

#### `g G`    
- Copy/append hold space to pattern space.

#### `l`      
- List out the current line in a ```visually unambiguous''` form.

#### `l width`
- List out the current line in a ```visually unambiguous''` form,breaking it at width characters.  This is a GNU extension.

#### `n N`    
- Read/append the next line of input into the pattern space.

#### `p`      
- Print the current pattern space.

#### `P`     
- Print up to the first embedded newline of the current pattern space.

#### `s/regexp/replacement/`
- Attempt to match regexp against the pattern space.  If successful, replace that portion matched with replacement.The replacement may contain the special character & to refer to that portion of the pattern space which matched, and the special escapes `\1` through `\9` to refer to the correspondingmatching sub-expressions in the regexp.

#### `t label` 
- If a `s///` has done a successful substitution since the last input line was read and since the last `t` or `T` command, then branch to label; if label is omitted, branch to end of script.

#### `T label` 
- If no `s///` has done a successful substitution since the last input line was read and since the last `t` or `T` command, then branch to label; if label is omitted, branch to end of script. This is a GNU extension.

#### `w filename`
- Write the current pattern space to filename.

#### `W filename`
- Write the first line of the current pattern space to filename. This is a GNU extension.

#### `x`      
- Exchange the contents of the hold and pattern spaces.

#### `y/source/dest/`
- Transliterate the characters in the pattern space which appear in source to the corresponding character in dest.

### Addresses 
> Sed commands can be given with no addresses, in which case the command will be executed for all input lines; with one address, in which case the command will only be executed for input lines which match that address; or with two addresses, in which case the command will be executed for all input lines which match the inclusive range of lines starting from the first address and continuing to the second address.  Three things to note about address ranges: the syntax is addr1,addr2 (i.e., the addresses are separated by a comma); the line which addr1 matched will always be accepted, even if addr2 selects an earlier line; and if addr2 is a regexp, it will not be tested against the line that addr1 matched.

> After the address (or address-range), and before the command, a `!` may be inserted, which specifies that the command shall only be executed if the address (or address-range) does not match.

The following address types are supported:

#### `number`
- Match only the specified line number (which increments cumulatively across files, unless the `-s` option is specified on the command line).

#### `first~step` 
- Match every step'th line starting with line first.  For example, ```sed -n 1~2p''` will print all the odd-numbered lines in the input stream, and the address 2~5 will match every fifth line, starting with the second.  first can be zero; in this case, sed operates as if it were equal to step.  (This is an extension.)

#### `$`
- Match the last line.

#### `/regexp/`
- Match lines matching the regular expression regexp.

#### `\cregexpc`
- Match lines matching the regular expression regexp.  The c may be any character.

GNU sed also supports some special 2-address forms:

#### `0,addr2` 
- Start out in `"matched first address"` state, until `addr2` is found.  This is similar to `1,addr2`, except that if `addr2` matches the very first line of input the `0,addr2` form will be at the end of its range, whereas the `1,addr2` form will still be at the beginning of its range.  This works only when `addr2` is a regular expression.

#### `addr1,+N`
- Will match `addr1` and the `N` lines following `addr1`.

#### `addr1,~N`
- Will match `addr1` and the lines following `addr1` until the next line whose input line number is a multiple of `N`.

## Examples
```bash
#! /bin/bash

echo "1) A Storm of Swords, George R. R. Martin, 1216 
2) The Two Towers, J. R. R. Tolkien, 352 
3) The Alchemist, Paulo Coelho, 197 
4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
5) The Pilgrimage, Paulo Coelho, 288 
6) A Game of Thrones, George R. R. Martin, 864" > books.txt

# 1) A Storm of Swords, George R. R. Martin, 1216 
# 2) The Two Towers, J. R. R. Tolkien, 352 
# 3) The Alchemist, Paulo Coelho, 197 
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 5) The Pilgrimage, Paulo Coelho, 288 
# 6) A Game of Thrones, George R. R. Martin, 864
sed '' books.txt

# 删除三行，-e选项指定三个独立的命令
# 3) The Alchemist, Paulo Coelho, 197 
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 6) A Game of Thrones, George R. R. Martin, 864
sed -e '1d' -e '2d' -e '5d' books.txt

echo -e "1d\n2d\n5d" > commands.txt 
# 1d
# 2d
# 5d
cat commands.txt
# 3) The Alchemist, Paulo Coelho, 197 
# 4) The Fellowship of the Ring, J. R. R. Tolkien, 432 
# 6) A Game of Thrones, George R. R. Martin, 864
sed -f commands.txt books.txt



echo "A Storm of Swords
George R. R. Martin
The Two Towers
J. R. R. Tolkien
The Alchemist
Paulo Coelho
The Fellowship of the Ring
J. R. R. Tolkien
The Pilgrimage
Paulo Coelho
A Game of Thrones
George R. R. Martin" > books2.txt

#*************************************************
# A Storm of Swords, George R. R. Martin
# The Two Towers, J. R. R. Tolkien
# - The Alchemist, Paulo Coelho
# The Fellowship of the Ring, J. R. R. Tolkien
# - The Pilgrimage, Paulo Coelho
# A Game of Thrones, George R. R. Martin

sed -n '
h;n;H;x
s/\n/, /
/Paulo/!b Print
s/^/- /
:Print
p' books2.txt
# 第一行是h;n;H;x这几个命令，记得上面我们提到的 保持空间 吗？第一个h是指将当前模式空间中的内容覆盖到 保持空间中，n用于提前读取下一行，并且覆盖当前模式空间中的这一行，H将当前模式空间中的内容追加到 保持空间 中，最后的x用于交换模式空间和保持空间中的内容。因此这里就是指每次读取两行放到模式空间中交给下面的命令进行处理
# 接下来是 s/\n/, / 用于将上面的两行内容中的换行符替换为逗号
# 第三个命令在不匹配的时候跳转到Print标签，否则继续执行第四个命令
# :Print仅仅是一个标签名，而p则是print命令


# 模式空间

str="pig cow cow pig"
# 将一段文本中的pig替换成cow，并且将cow替换成horse：
# hores cow cow pig
echo ${str} | sed 's/pig/cow/;s/cow/hores/'
# hores hores hores hores
echo ${str} | sed 's/pig/cow/g;s/cow/hores/g'
# cow hores cow pig
echo ${str} | sed 's/cow/hores/;s/pig/cow/'
# cow hores hores cow
echo ${str} | sed 's/cow/hores/g;s/pig/cow/g'

# 地址匹配
list="Alice Ford, 22 East Broadway, Richmond VA
\nOrville Thomas, 11345 Oak Bridge Road, Tulsa OK
\nTerry Kalkas, 402 Lans Road, Beaver Falls PA
\nEric Adams, 20 Post Road, Sudbury MA
\nHubert Sims, 328A Brook Road, Roanoke VA
\nAmy Wilde, 334 Bayshore Pkwy, Mountain View CA
\nSal Carpenter, 73 6th Street, Boston MA"
#
echo -e ${list} | sed 'd'
# Orville Thomas, 11345 Oak Bridge Road, Tulsa OK 
# Eric Adams, 20 Post Road, Sudbury MA 
# Amy Wilde, 334 Bayshore Pkwy, Mountain View CA 
# Sal Carpenter, 73 6th Street, Boston MA
echo -e ${list} | sed '1d;3d;5d'

# 删除该范围内的所有行
# Alice Ford, 22 East Broadway, Richmond VA 
echo -e ${list} | sed '2,$d'

# 通过正则表达式来指定地址，删除包含MA VA的行：
# Orville Thomas, 11345 Oak Bridge Road, Tulsa OK 
# Terry Kalkas, 402 Lans Road, Beaver Falls PA 
# Amy Wilde, 334 Bayshore Pkwy, Mountain View CA 
echo -e ${list} | sed '/MA/d;/VA/d'

# Alice Ford, 22 East Broadway, Richmond ZING 
echo -e ${list} | sed '2,$d;s/VA/ZING/'

# 使用正则匹配，删除从包含Alice的行开始到包含Hubert的行结束的所有行
# Amy Wilde, 334 Bayshore Pkwy, Mountain View CA 
# Sal Carpenter, 73 6th Street, Boston MA
echo -e ${list} | sed '/Alice/,/Hubert/d'

# 行号和地址对是可以混用?
# Alice Ford, 22 East Broadway, Richmond VA
# Orville Thomas, 11345 Oak Bridge Road, Tulsa OK
echo -e ${list} | sed '3,$d' 
# Orville Thomas, 11345 Oak Bridge Road, Tulsa OK
echo -e ${list} | sed '3,$d;/VA/d'
# Alice Ford, 22 East Broadway, Richmond VA 
echo -e ${list} | sed '3,$d;2d' 
# Alice Ford, 22 East Broadway, Richmond VA
echo -e ${list} | sed '3,$d;2,/VA/d' 
# Orville Thomas, 11345 Oak Bridge Road, Tulsa OK
echo -e ${list} | sed '3,$d;2,/VA/!d' 

# Alice Ford, 22 East Broadway, Richmond VA
# Orville Thomas, 11345 Oak Bridge Road, Tulsa OK
# Terry Kalkas, 402 Lans Road, Beaver Falls, Pennsylvania
# Eric Adams, 20 Post Road, Sudbury, Massachusetts
echo -e ${list} | sed -n '1,4{s/ MA/, Massachusetts/;s/ PA/, Pennsylvania/;p}'
```
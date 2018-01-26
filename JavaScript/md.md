# MarkDown

> Markdown是一种可以使用普通文本编辑器编写的标记语言，通过简单的标记语法，它可以使普通文本内容具有一定的格式。

## 区块元素


### 标题title

```markdown
# h1
## h2
### h3
#### h4
##### h5
###### h6
```
- # h1      \#h1
- ## h2     \#\#h2
- ### h3    \#\#\#h3
- #### h4   \#\#\#\#h4
- ##### h5  \#\#\#\#\#h5
- ###### h6 \#\#\#\#\#\#h6

### 区块引用 Blockquotes

```markdown
> This is a blockquote with two paragraphs. Lorem ipsum dolor sit amet,
> consectetuer adipiscing elit. Aliquam hendrerit mi posuere lectus.
> Vestibulum enim wisi, viverra nec, fringilla in, laoreet vitae, risus.
> 
> Donec sit amet nisl. Aliquam semper ipsum sit amet velit. Suspendisse
> id sem consectetuer libero luctus adipiscing.
```

> This is a blockquote with two paragraphs. Lorem ipsum dolor sit amet,
> consectetuer adipiscing elit. Aliquam hendrerit mi posuere lectus.
> Vestibulum enim wisi, viverra nec, fringilla in, laoreet vitae, risus.
> 
> Donec sit amet nisl. Aliquam semper ipsum sit amet velit. Suspendisse
> id sem consectetuer libero luctus adipiscing.

### 列表list

#### 无序列表
```markdown
*   Red
*   Green
*   Blue

+   Red
+   Green
+   Blue

-   Red
-   Green
-   Blue
```

*   Red
*   Green
*   Blue
-   Red
-   Green
-   Blue
+   Red
+   Green
+   Blue

#### 有序列表

```markdown
1.  Bird
2.  McHale
3.  Parish
```
1.  Bird
2.  McHale
3.  Parish

#### 分隔线

```markdown
* * *

***

*****

- - -

---------------------------------------
```
* * *

***

*****

- - -

---------------------------------------


## 区段元素

### 链接

```markdown
This is [github link](https://github.com/ "Title") inline link.

[github link](https://github.com/) has no title attribute.

<http://github.com/>

```
This is [github link](https://github.com/ "Title") inline link.

[github link](https://github.com/) has no title attribute.

<http://github.com/>



### 强调

```markdown
*single asterisks*

_single underscores_

**double asterisks**

__double underscores__
```

*single asterisks*

_single underscores_

**double asterisks**

__double underscores__

### 代码 code

#### 行内代码 line code

c lang `printf` function
``There is a literal backtick (`) here.``

#### 块代码 block code
```markdown
    ```Java
    public static void main(String args[]){
        System.out.println("Hello World");
    }
    ...
    //显示样式有问题
```

```Java
public static void main(String args[]){
    System.out.println("Hello World");
}
```

#### 图片 image

```
![Alt text](https://avatars1.githubusercontent.com/u/11625343?s=100&v=4)
![Alt text](https://avatars1.githubusercontent.com/u/11625343?s=100&v=4 "Optional title")
```

![Alt text](https://avatars1.githubusercontent.com/u/11625343?s=100&v=4)
![Alt text](https://avatars1.githubusercontent.com/u/11625343?s=100&v=4 "Optional title")


## 常用编辑器

- VSCode
- Atom
- Typora
- Jeatbrains系列IDE插件

## 文章参考
- <https://www.appinn.com/markdown>

## 博客地址
- <https://zhangrxiang.github.io/dev-blog/#/>




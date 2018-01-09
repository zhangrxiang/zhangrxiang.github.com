# requirejs


## 使用

### 加载 JavaScript 文件

RequireJS的目标是鼓励代码的模块化，它使用了不同于传统`<script>`标签的脚本加载步骤。可以用它来加速、优化代码，但其主要目的还是为了代码的模块化。

RequireJS以一个相对于baseUrl的地址来加载所有的代码。 页面顶层`<script>`标签含有一个特殊的属性data-main，require.js使用它来启动脚本加载过程，而baseUrl一般设置到与该属性相一致的目录。
baseUrl亦可通过RequireJS config手动设置。如果没有显式指定config及data-main，则默认的baseUrl为包含RequireJS的那个HTML页面的所属目录。

RequireJS默认假定所有的依赖资源都是js脚本，因此无需在module ID上再加".js"后缀，RequireJS在进行module ID到path的解析时会自动补上后缀。你可以通过paths config设置一组脚本，这些有助于我们在使用脚本时码更少的字。
有时候你想避开"baseUrl + paths"的解析过程，而是直接指定加载某一个目录下的脚本。此时可以这样做：如果一个module ID符合下述规则之一，其ID解析会避开常规的"baseUrl + paths"配置，而是直接将其加载为一个相对于当前HTML文档的脚本：
以 ".js" 结束.

以 "/" 开始.
包含 URL 协议, 如 "http:" or "https:".

一般来说，最好还是使用baseUrl及"paths" config去设置module ID。它会给你带来额外的灵活性，如便于脚本的重命名、重定位等。 同时，为了避免凌乱的配置，最好不要使用多级嵌套的目录层次来组织代码，而是要么将所有的脚本都放置到baseUrl中，要么分置为项目库/第三方库的一个扁平结构，如下：

- www/
    - index.html
    - js/
        - app/
            - sub.js
        - lib/
            - jquery.js
            - canvas.js
        - app.js

```html
<script data-main="js/app.js" src="js/require.js"></script>
```
```javascript
requirejs.config({
    //By default load any module IDs from js/lib
    baseUrl: 'js/lib',
    //except, if the module ID starts with "app",
    //load it from the js/app directory. paths
    //config is relative to the baseUrl, and
    //never includes a ".js" extension since
    //the paths config could be for a directory.
    paths: {
        app: '../app'
    }
});

//Start the main app logic.
requirejs(['jquery', 'canvas', 'app/sub'],
function   ($, canvas, sub) {
    //jQuery, canvas and the app/sub module are all
    //loaded and can be used here now.
});
```
注意在示例中，三方库如jQuery没有将版本号包含在他们的文件名中。我们建议将版本信息放置在单独的文件中来进行跟踪。使用诸如volo这类的工具，可以将package.json打上版本信息，并在磁盘上保持文件名为"jquery.js"。这有助于你保持配置的最小化，避免为每个库版本设置一条path。例如，将"jquery"配置为"jquery-1.7.2"。

理想状况下，每个加载的脚本都是通过define()来定义的一个模块；但有些"浏览器全局变量注入"型的传统/遗留库并没有使用define()来定义它们的依赖关系，你必须为此使用shim config来指明它们的依赖关系。 如果你没有指明依赖关系，加载可能报错。这是因为基于速度的原因，RequireJS会异步地以无序的形式加载这些库。

### data-main 入口点

require.js 在加载的时候会检察data-main 属性:

```html
<script data-main="scripts/main" src="scripts/require.js"></script>
```

你可以在`data-main`指向的脚本中设置模板加载 选项，然后加载第一个应用模块。.注意：你在main.js中所设置的脚本是异步加载的。所以如果你在页面中配置了其它JS加载，则不能保证它们所依赖的JS已经加载成功。例如：

```javascript
<script data-main="scripts/main" src="scripts/require.js"></script>
<script src="scripts/other.js"></script>
// contents of main.js:
require.config({
    paths: {
        foo: 'libs/foo-1.1.3'
    }
});
// contents of other.js:
// This code might be called before the require.config() in main.js has executed. 
// When that happens, require.js will attempt to load 'scripts/foo.js' instead of 'scripts/libs/foo-1.1.3.js'
require( ['foo'], function( foo ) {

});
```

### 定义模块
模块不同于传统的脚本文件，它良好地定义了一个作用域来避免全局名称空间污染。它可以显式地列出其依赖关系，并以函数(定义此模块的那个函数)参数的形式将这些依赖进行注入，而无需引用全局变量。RequireJS的模块是模块模式的一个扩展，其好处是无需全局地引用其他模块。

RequireJS的模块语法允许它尽快地加载多个模块，虽然加载的顺序不定，但依赖的顺序最终是正确的。同时因为无需创建全局变量，甚至可以做到在同一个页面上同时加载同一模块的不同版本。

一个磁盘文件应该只定义 1 个模块。多个模块可以使用内置优化工具将其组织打包。

#### 简单的值对
如果一个模块仅含值对，没有任何依赖，则在define()中定义这些值对就好了：
```javascript
//Inside file my/shirt.js:
define({
    color: "black",
    size: "unisize"
});
```
#### 函数式定义
如果一个模块没有任何依赖，但需要一个做setup工作的函数，则在define()中定义该函数，并将其传给define()：
```javascript
//my/shirt.js now does setup work
//before returning its module definition.
define(function () {
    //Do setup work here
    return {
        color: "black",
        size: "unisize"
    }
});
```

#### 存在依赖的函数式定义
如果模块存在依赖：则第一个参数是依赖的名称数组；第二个参数是函数，在模块的所有依赖加载完毕后，该函数会被调用来定义该模块，因此该模块应该返回一个定义了本模块的object。依赖关系会以参数的形式注入到该函数上，参数列表与依赖名称列表一一对应。

```javascript
//my/shirt.js now has some dependencies, a cart and inventory module in the same directory as shirt.js
define(["./cart", "./inventory"], function(cart, inventory) {
        //return an object to define the "my/shirt" module.
        return {
            color: "blue",
            size: "large",
            addToCart: function() {
                inventory.decrement(this);
                cart.add(this);
            }
        }
    }
);
```
本示例创建了一个my/shirt模块，它依赖于my/cart及my/inventory。磁盘上各文件分布如下：

- my/cart.js
- my/inventory.js
- my/shirt.js

模块函数以参数"cart"及"inventory"使用这两个以"./cart"及"./inventory"名称指定的模块。在这两个模块加载完毕之前，模块函数不会被调用。

严重不鼓励模块定义全局变量。遵循此处的定义模式，可以使得同一模块的不同版本并存于同一个页面上(参见 高级用法 )。另外，函参的顺序应与依赖顺序保存一致。

返回的object定义了"my/shirt"模块。这种定义模式下，"my/shirt"不作为一个全局变量而存在。

#### 将模块定义为一个函数
对模块的返回值类型并没有强制为一定是个object，任何函数的返回值都是允许的。此处是一个返回了函数的模块定义：
```javascript
//A module definition inside foo/title.js. It uses my/cart and my/inventory modules from before,
//but since foo/title.js is in a different directory than the "my" modules, it uses the "my" in the module dependency name to find them. 
//The "my" part of the name can be mapped to any directory, but by default, it is assumed to be a sibling to the "foo" directory.
define(["my/cart", "my/inventory"],function(cart, inventory) {
    //return a function to define "foo/title".
    //It gets or sets the window title.
    return function(title) {
        return title ? (window.title = title) :
               inventory.storeName + ' ' + cart.name;
    }
});
```

#### 简单包装CommonJS来定义模块
如果你现有一些以CommonJS模块格式编写的代码，而这些代码难于使用上述依赖名称数组参数的形式来重构，你可以考虑直接将这些依赖对应到一些本地变量中进行使用。你可以使用一个CommonJS的简单包装来实现：
```javascript
define(function(require, exports, module) {
        var a = require('a'),
            b = require('b');

        //Return the module value
        return function () {};
    }
);
```
该包装方法依靠Function.prototype.toString()将函数内容赋予一个有意义的字串值，但在一些设备如PS3及一些老的Opera手机浏览器中不起作用。考虑在这些设备上使用优化器将依赖导出为数组形式。

#### 定义一个命名模块
你可能会看到一些define()中包含了一个模块名称作为首个参数：
```javascript
//Explicitly defines the "foo/title" module:
define("foo/title",["my/cart", "my/inventory"],function(cart, inventory) {
        //Define foo/title object in here.
   }
);
```
这些常由优化工具生成。你也可以自己显式指定模块名称，但这使模块更不具备移植性——就是说若你将文件移动到其他目录下，你就得重命名。一般最好避免对模块硬编码，而是交给优化工具去生成。优化工具需要生成模块名以将多个模块打成一个包，加快到浏览器的载人速度。

#### 其他注意事项
一个文件一个模块: 每个Javascript文件应该只定义一个模块，这是模块名-至-文件名查找机制的自然要求。多个模块会被优化工具组织优化，但你在使用优化工具时应将多个模块放置到一个文件中。

define()中的相对模块名: 为了可以在define()内部使用诸如require("./relative/name")的调用以正确解析相对名称，记得将"require"本身作为一个依赖注入到模块中：
```javascript
define(["require", "./relative/name"], function(require) {
    var mod = require("./relative/name");
});
```
或者更好地，使用下述为转换CommonJS模块所设的更短的语法：
```javascript
define(function(require) {
    var mod = require("./relative/name");
});
```
相对路径在一些场景下格外有用，例如：为了以便于将代码共享给其他人或项目，你在某个目录下创建了一些模块。你可以访问模块的相邻模块，无需知道该目录的名称。

生成相对于模块的URL地址: 你可能需要生成一个相对于模块的URL地址。你可以将"require"作为一个依赖注入进来，然后调用require.toUrl()以生成该URL:
```javascript
define(["require"], function(require) {
    var cssUrl = require.toUrl("./style.css");
});
```
控制台调试:如果你需要处理一个已通过require(["module/name"], function(){})调用加载了的模块，可以使用模块名作为字符串参数的require()调用来获取它:
```javascript
require("module/name").callSomeFunction()
```
注意这种形式仅在"module/name"已经由其异步形式的require(["module/name"])加载了后才有效。只能在define内部使用形如"./module/name"的相对路径。

#### 循环依赖
如果你定义了一个循环依赖(a依赖b，b同时依赖a)，则在这种情形下当b的模块函数被调用的时候，它会得到一个undefined的a。b可以在模块已经定义好后用require()方法再获取(记得将require作为依赖注入进来)：
```javascript
//Inside b.js:
define(["require", "a"],
    function(require, a) {
        //"a" in this case will be null if a also asked for b,
        //a circular dependency.
        return function(title) {
            return require("a").doSomething();
        }
    }
);
```
一般说来你无需使用require()去获取一个模块，而是应当使用注入到模块函数参数中的依赖。循环依赖比较罕见，它也是一个重构代码重新设计的警示灯。但不管怎样，有时候还是要用到循环依赖，这种情形下就使用上述的require()方式来解决。

如果你熟悉CommonJS，你可以考虑使用exports为模块建立一个空object，该object可以立即被其他模块引用。在循环依赖的两头都如此操作之后，你就可以安全地持有其他模块了。这种方法仅在每个模块都是输出object作为模块值的时候有效，换成函数无效。
```javascript
//Inside b.js:
define(function(require, exports, module) {
    //If "a" has used exports, then we have a real object reference here.
    //However, we cannot useany of a's properties until after b returns a value.
    var a = require("a");
    exports.foo = function () {
        return a.bar();
    };
});
```
或者，如果你使用依赖注入数组的步骤，则可用注入特殊的"exports"来解决：
```javascript
//Inside b.js:
define(['a', 'exports'], function(a, exports) {
    //If "a" has used exports, then we have a real object reference here.
    //However, we cannot useany of a's properties until after b returns a value.
    exports.foo = function () {
        return a.bar();
    };
});
```
#### JSONP服务依赖
JSONP是在javascript中服务调用的一种方式。它仅需简单地通过一个script标签发起HTTP GET请求，是实现跨域服务调用一种公认手段。

为了在RequireJS中使用JSON服务，须要将callback参数的值指定为"define"。这意味着你可将获取到的JSONP URL的值看成是一个模块定义。

下面是一个调用JSONP API端点的示例。该示例中，JSONP的callback参数为"callback"，因此"callback=define"告诉API将JSON响应包裹到一个"define()"中：

```javascript
require(["http://example.com/api/data.json?callback=define"],   
    function (data) {
        //The data object will be the API response for theJSONP data call.
        console.log(data);
    }
); 
```
 仅支持返回值类型为JSON object的JSONP服务，其他返回类型如数组、字串、数字等都不能支持。

 ## 机制
RequireJS使用head.appendChild()将每一个依赖加载为一个script标签。

RequireJS等待所有的依赖加载完毕，计算出模块定义函数正确调用顺序，然后依次调用它们。

在同步加载的服务端JavaScript环境中，可简单地重定义require.load()来使用RequireJS。build系统就是这么做的。该环境中的require.load实现可在build/jslib/requirePatch.js中找到。

未来可能将该部分代码置入require/目录下作为一个可选模块，这样你可以在你的宿主环境中使用它来获得正确的加载顺序。
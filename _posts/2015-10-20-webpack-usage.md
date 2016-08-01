---
layout: post
title: "webpack 简易教程"
description: "webpack 简易教程"
category: diary
tags: [oracle]
---


# webpack 使用


### 第3方代码/库的引入

本项目支持npm上所有的代码库。

只需要运行如下命令安装所需`<代码库>`

	npm i <代码库> --save

然后在代码中添加如下代码:

	require('<代码库>')
	// 或
	var modulename = require('<代码库>')

就可以使用该代码库提供的功能。

如引入`jquery-ui`的`draggable`和`sortable`:

先执行命令:

	npm i jquery-ui --save

然后在代码中添加：

```javascript
require('jquery-ui/draggable');
require('jquery-ui/sortable');
```

上面是只添加jquery-ui的 draggable 和 sortable 功能，其他的功能代码不会引入。

### webpack 实时编译 js

运行
```
webpack --watch
// 或
npm run watch
```

则，当`js`文件变化后，将马上重新编译打包所有的`js`文件。

### webpack 实时预览

运行

```
gulp hmr
//或
.\node_modules\.bin\gulp hmr	//(未全局安装`gulp`时)
```

会打开一个浏览器，实时监控，若`js`改变了，会自动重新加载新的文件。

若出现如下错误:

```
events.js:141
      throw er; // Unhandled 'error' event
      ^ Error: listen EADDRINUSE 127.0.0.1:8088
```

请检查8088端口是否被占用，释放该端口或修改[gulpfile.js](./src/EasyBuild.Web/gulpfile.js#L86)文件中相应的端口。


***

## 参考：

[webpack 官方文档](http://webpack.github.io/docs/)

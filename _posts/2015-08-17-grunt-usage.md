---
layout: post
title: "Grunt 使用文档"
description: "Grunt 使用文档"
category: tool
tags: [javascript]
---

# Info

	// TODO

# Install

	// TODO

# Gruntfile 配置文件

## "wrapper" 函数

每一份 Gruntfile （和grunt插件）都遵循同样的格式，你所书写的Grunt代码必须放在此函数内：

```javascript
module.exports = function (grunt) {
	// grunt 相关的东西都在这里

	grunt.initConfig({
		// 任务配置在这里
		jshint: { /* jshint的参数 */ },
		concat: { /* concat的参数 */ },
		uglify: { /* uglify的参数 */ },
		watch:  { /* watch的参数 */ }
	});

	// 从node_modules目录加载插件
	grunt.loadNpmTasks('grunt-contrib-jshint');

	// 每行registerTask定义一个任务
	grunt.registerTask('default', ['jshint', 'concat', 'uglify']);	// 这是默认任务
	grunt.registerTask('check', ['jshint']);
	
};
```

## grunt.initConfig 项目和任务的配置

	// TODO


# 参考

- [Grunt 中文文档](http://www.gruntjs.net/)
- [Grunt：任务自动管理工具](http://javascript.ruanyifeng.com/tool/grunt.html)


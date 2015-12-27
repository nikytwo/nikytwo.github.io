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


```javascript
// 每一份 Gruntfile （和grunt插件）都遵循同样的格式，你所书写的Grunt代码必须放在此函数内
module.exports = function (grunt) {
	// grunt 相关的东西都在这里

	grunt.initConfig({
		// 项目和任务配置在这里
		jshint: { /* jshint的参数 */ },
		concat: { /* concat的参数 */ },
		uglify: { /* uglify的参数 */ },
		watch:  { /* watch的参数 */ }
	});

	// 从node_modules目录加载插件
	grunt.loadNpmTasks('grunt-contrib-jshint');

	// 每行registerTask定义一个任务
	// default 是 grunt 的默认任务，执行`grunt`命令时将执行默认任务
	grunt.registerTask('default', ['jshint', 'concat', 'uglify']);	
	// 定义任务名称为 check
	grunt.registerTask('check', ['jshint']);

	// 还可以自定义任务
	grunt.registerTask('default', 'Log some stuff.', function() {
		grunt.log.write('Logging some stuff ...').ok();
	});
	
};
```



# 参考

- [Grunt 中文文档](http://www.gruntjs.net/)
- [Grunt：任务自动管理工具](http://javascript.ruanyifeng.com/tool/grunt.html)


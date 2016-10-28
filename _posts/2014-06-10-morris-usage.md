---
layout: post
title: "Morris 使用"
description: "Morris 使用"
category: wiki
tags: [javascript,Lib]
---

## 简介

[Morris.js][morrisurl] 是一个轻量级的 JS 库,使用 `jQuery` 和 `Raphael` 来生成各种图表 (目前仅支持 `Line`,`Area`,`Bar`,`Donut` 4种).

其特点: 使用简单,轻量.

## 快速开始

在页面中添加 [morris.js][morrisurl] 和 它的依赖库(`jQuery` 和 `Raphael`)

	<link rel="stylesheet" href="http://cdn.oesmith.co.uk/morris-0.5.0.min.css">
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
	<script src="http://cdn.oesmith.co.uk/morris-0.5.0.min.js"></script>

## 第一个图表

Start by adding a `<div>` to your page that will contain your chart. Make sure it has an ID so you can refer to it in your Javascript later.

	<div id="myfirstchart" style="height: 250px;"></div>

Next add a `<script>` block to the end of your page, containing the following javascript code:

	new Morris.Line({
	  // ID of the element in which to draw the chart.
	  element: 'myfirstchart',
	  // Chart data records -- each entry in this array corresponds to a point on
	  // the chart.
	  data: [
		{ year: '2008', value: 20 },
		{ year: '2009', value: 10 },
		{ year: '2010', value: 5 },
		{ year: '2011', value: 5 },
		{ year: '2012', value: 20 }
	  ],
	  // The name of the data record attribute that contains x-values.
	  xkey: 'year',
	  // A list of names of data record attributes that contain y-values.
	  ykeys: ['value'],
	  // Labels for the ykeys -- will be displayed when you hover over the
	  // chart.
	  labels: ['Value'],
	  // 默认情况下,Line 的 x 轴会自动格式为时间,可以如下手工取消.
	  parseTime: false,
	  // x 轴的文本说明倾斜角度
	  xLabelAngle: 60,
	  // 取消线段的平滑效果
	  smooth: false
	}).on('click', function(i,row) {
		// 点击事件
		window.location.href = "index.jsp?value=" + row.value;
	});

大功告成!

获取更多帮助:[主页][morrisurl].


***

[morrisurl]: http://morrisjs.github.io/morris.js/index.html


---
layout: post
title: "Jekyll 使用"
description: "Jekyll 使用"
category: wiki
tags: [Blog]
---


# Theme主题

从版本0.2.X开始，JB(Jekyll-Bootstrap)的主题完全是模块化的。
这让每个人都可以自由发布和共享主题。
Jekyll-Bootstrap v 0.2.x只附带twitter主题，其他主题需要被安装。
当前主题包在GitHub上：https://github.com/jekyllbootstrap

## 安装主题

通过使用rake命令,并通过该主题在git的URL安装一个主题。

	rake theme:install git="https://github.com/jekyllbootstrap/theme-the-program.git"

安装程序使用的git下载主题包。

如果你已经获得了主题包,如通过Download ZIP下载下来的。
你可以手动把它放到你的 ./_theme_packages文件夹下,然后如下运行:

	rake theme:install name="THEME-NAME"

`THEME-NAME`为主题包名称。

## 切换主题

一旦你的主题安装,您可以通过rake来进行他们之间的切换

	rake theme:switch name="THEME-NAME"

## 自定义主题

主题的布局在 ./_includes/themes/THEME-NAME 目录下。
您可以编辑该目录中的文件，而不是 _layouts 目录，因为改变的主题将覆盖 _layout 目录中的文件，你可以在_layouts中自由添加额外的模板文件。
以自定义您的博客


# Highlight

## 配置

* redcarpet

```yaml
highlighter: pygments
markdown: redcarpet
redcarpet:
  extensions:
    - fenced_code_blocks
    - no_intra_emphasis
    - strikethrough
    - autolink
    - tables
    - with_toc_data
```

这种配置可以按照 <code>```</code> 这样的方式, 自动链接,代码块 等基本功能都可以满足了.

* karkdown

```yaml
highlighter: pygments
markdown: kramdown  # [ maruku | rdiscount | kramdown | redcarpet ]
kramdown:
  input:         GFM	# 没有这个配置 代码块不会生效
  auto_ids:      true	# 自动生成ID
  auto_id_prefix:'id-'	# ID的前缀
  # footnote_nr:   1
  # entity_output: as_char
  # toc_levels:    1..6
  # smart_quotes:  lsquo,rsquo,ldquo,rdquo
  # use_coderay:   true

  # coderay:
  #   coderay_wrap:              div
  #   coderay_line_numbers:      inline
  #   coderay_line_number_start: 1
  #   coderay_tab_width:         2
  #   coderay_bold_every:        10
  #   coderay_css:               style
```

注释为默认配置, 不过 github 没有 `coderay` 服务, 后面都可以不用

这种方式不能根据代码类型进行着色，
需要引入js

```html
<link href='{{ BASE_PATH }}/assets/styles/agate.css' rel="stylesheet" media="all">
<script src="{{ BASE_PATH }}/assets/highlight.pack.js"></script>
<script> hljs.initHighlightingOnLoad(); </script>
```

# toc生成目录

	// TOOD


# 常用命令

```Bash
// 列出所有可用的 rake 命令
rake --tasks

rake post title="your title"

```

***

# 参考

- [Jekyll 中文文档](http://jekyll.bootcss.com/docs/home/)
- [jekyll kramdown 语法高亮配置](http://noyobo.com/2014/10/19/jekyll-kramdown-highlight.html)
- [Jekyll的中的代码高亮](http://yansu.org/2013/04/22/highlight-of-jekyll.html)
- [jekyll bootstrap更改主题theme](http://blog.csdn.net/itmyhome1990/article/details/42080161)
- [ztree_toc](http://i5ting.github.io/i5ting_ztree_toc/)
- [Github Pages极简教程](http://yanping.me/cn/blog/2012/03/18/github-pages-step-by-step/)
- [rake 命令参考](http://guides.ruby-china.org/command_line.html#rake)


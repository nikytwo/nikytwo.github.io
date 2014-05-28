---
layout: page
title:  Welcome Nikytwo blog
tagline:  工欲善其事,必先利其器
---
{% include JB/setup %}

## 文章列表

<ul class="posts">
  {% for post in site.posts %}
    <li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>

***

## 其他
- [以前的 Blog](http://www.cnblogs.com/nikytwo/)
- [360doc 收藏的文章](http://www.360doc.com/userhome/14416931)
- [我的代码](https://github.com/nikytwo/)



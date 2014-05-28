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


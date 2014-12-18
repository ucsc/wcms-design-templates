---
title: 2014 Mobile Web Templates
description: "Index page for mobile web templates."
keywords: "university, college, Santa Cruz, California"
class: www left-column
www: true
dept: false
front: false
---


<ul>
  {% for page in site.pages %}
    <li><a href="{{ page.url }}">{{ page.title }}</a></li>
  {% endfor %}
</ul>


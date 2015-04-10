---
layout: default
title: 2014 Responsive Web Templates
type: index
---

## Pages

Each page contains patterns that usually appear on that page.

{% for p in site.html_pages %}
- [{{ p.title }}]({{ p.url }})  
{% endfor %}
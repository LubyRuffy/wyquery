# wyquery

Wooyun公开的漏洞详情是一个很好的资源，但是没有提供很好的搜索引擎和排序功能来进行数据分析，所以，这个项目用户镜像wooyun上已经对外公开的漏洞详情，并提供更多搜索和排序的功能。


你有没有想完成如下功能？

* 我想只看给钱的漏洞
* 我想只看带乌云标志的漏洞
* 我想按照rank排序漏洞

如果有，那你跟我遇到的问题一样，不妨试试这个项目！线上已经搭建好的DEMO环境如下：http://120.27.41.90/

## 搭建环境
建议在Linux下运行，当然Windows下也可以。Ruby 2.0＋

```
git clone https://github.com/LubyRuffy/wyquery.git
cd wyquery
bundle install
rake db:migrate
rails s
```

然后访问http://0.0.0.0:3000

## 初次抓取数据

```
cd wyquery
ruby ./tools/import_bugs.rb
```

## 同步数据
这时可以建立定时任务

```
crontab -e
*/10 * * * * <wyquery路径>/tools/import_bugs.rb
```


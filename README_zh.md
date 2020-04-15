# chembl_beaker

## 介绍
这是一个由(ChEMBL)[https://www.ebi.ac.uk/chembl/]开发的软件包。
Beaker封装了RDKit和OSRA，提供了很多接口，包括：
 + 常见分子文件的格式转换
 + 结构式识别
 + 生成矢量图
 + ...


## 使用场景
可以用作(Marvin For Java Script)[http://www.chemaxon.com/products/marvin/marvin-for-javascript/]的后端


## 用法
最佳使用方法是在docker中运行
```bash
docker run -p 5000:5000 chembl/beaker
```

访问 http://127.0.0.1:5000/docs 可以查看文档

## 配置
默认配置文件为`beaker.conf`

By default configuration is stored in ``beaker.conf`` file, located in current directory. You can specify location of
configuration file using ``--config (-c)`` parameter when running beaker. Configuration file format is standard ``*.ini``.
Beaker is distributed with example configuration file named ``beaker.conf.sample``.

 * **debug** - run bottle server in debug mode (True/False, default ``True``)
 * **bottle_port** - number of port on which Bottle server is listening for connections (integer, default ``8080``)
 * **bottle_host** - hostname of Bottle server (string, default ``localhost``)
 * **server_middleware** - networking middleware library used by Bottle (string, default ``tornado``)
 * **osra_binaries_location** - path to OSRA binary you want to use for compound recognition (string, default ``/usr/bin/osra``)
 * **enable_cors** - enable CORS plugin and respect all header settings below (True/False, default ``True``) 
 * **access_control_allow_origin** - content of 'Access-Control-Allow-Origin' header send with every response (string, default ``*``)
 * **access_control_allow_methods** - content of 'Access-Control-Allow-Methods' header send with every response (string, default ``GET, POST, PUT, OPTIONS``)
 * **installed_apps** - apps installed in beaker, default to [
    "beaker",
    "beaker.core_apps.autoDocs",
    "beaker.core_apps.conversions",
    "beaker.core_apps.descriptors",
    "beaker.core_apps.marvin",
    "beaker.core_apps.mcs",
    "beaker.core_apps.osra",
    "beaker.core_apps.rasterImages",
    "beaker.core_apps.svgImages",
    "beaker.core_apps.similarityMaps",
    "beaker.core_apps.standardisation",
    ]

Documentation
--------
Like every good software written in Python, beaker is self-documented. When you run beaker, open your browser and go to URL: ``BEAKER_ROOT/docs``. You will see live documentation genrated on the fly from all available webservices, exposed by beaker. You can immediately try them and see results return by the server. Every webservice should be documented - documentation is generated automatically as well, from docstring of every exposed webservice, interpreted as markdown.

Development - writing your own extentions
--------
Developing new app should be easy. The only required file is ``views.py`` where you should define your botte ``routes``. 

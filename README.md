# ips_graph

1. Запуск create.sh создает rrd базу данных
2. Скрипт get_attack.sh следует поместить в cron для запуска каждую минуту.

Создание красивых графиков с помощью интсрумента rrdtool для анализа количества атак на ips. По snmp выгружаются данные, потом рисуются графики за день, неделю и месяц

![image](https://user-images.githubusercontent.com/77189625/158962665-ef0aaf2d-2628-4d84-81b1-c7f391b58c06.png)

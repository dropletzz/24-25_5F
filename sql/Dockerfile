FROM mariadb:11

RUN echo "[mysqld]" > /etc/mysql/conf.d/custom.cnf
RUN echo "lower_case_table_names=1" >> /etc/mysql/conf.d/custom.cnf

COPY database /_dbdata
COPY create-all.sh /docker-entrypoint-initdb.d
#!/bin/bash

PGUSER=postgres
DBNAME=mapasculturais
DBUSER=mapasculturais
DBPASS=mapasculturais

sudo -u ${PGUSER} dropdb ${DBNAME}
sudo -u ${PGUSER} dropuser ${DBUSER}

sudo -u ${PGUSER} psql -d postgres -c "CREATE USER ${DBUSER} WITH PASSWORD '${DBPASS}';"
sudo -u ${PGUSER} createdb --owner ${DBUSER} ${DBNAME}

sudo -u ${PGUSER} psql -d ${DBNAME} -c 'CREATE EXTENSION postgis;'
sudo -u ${PGUSER} psql "dbname=${DBNAME} user=${DBUSER} password=${DBPASS} host=127.0.0.1" -f ../db/schema.sql || sudo -u ${PGUSER} psql -d ${DBNAME} -U ${DBUSER} -f ../db/schema.sql
sudo -u ${PGUSER} psql "dbname=${DBNAME} user=${DBUSER} password=${DBPASS} host=127.0.0.1" -f ../db/initial-data.sql || sudo -u ${PGUSER} psql -d ${DBNAME} -U ${DBUSER} -f ../db/initial-data.sql
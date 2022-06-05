#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER service_home_test WITH ENCRYPTED PASSWORD 'service_home_test';
    CREATE DATABASE home_test;
    
    \connect home_test 
    CREATE SCHEMA AUTHORIZATION service_home_test;
    ALTER ROLE service_home_test SET search_path TO service_home_test;

    GRANT ALL PRIVILEGES ON SCHEMA service_home_test TO service_home_test;
    GRANT ALL PRIVILEGES ON ALL TABLES IN schema service_home_test TO service_home_test;
    GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA service_home_test TO service_home_test;
EOSQL

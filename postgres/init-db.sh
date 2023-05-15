#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER service WITH ENCRYPTED PASSWORD 'service';
    
    \connect postgres 
    CREATE SCHEMA AUTHORIZATION service;
    ALTER ROLE service SET search_path TO service;

    GRANT ALL PRIVILEGES ON SCHEMA service TO service;
    GRANT ALL PRIVILEGES ON ALL TABLES IN schema service TO service;
    GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA service TO service;
EOSQL

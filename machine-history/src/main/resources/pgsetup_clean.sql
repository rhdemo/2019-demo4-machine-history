create user machine_history_user password 'DSAf3DSdfhjkl39s9' superuser;
alter user machine_history_user set search_path=public;

drop database if exists machine_history_testing;
drop database if exists machine_history_dev;

create database machine_history_testing;
create database machine_history_dev;

\c machine_history_testing
\i ddl.sql

\c machine_history_dev
\i ddl.sql

\c postgres
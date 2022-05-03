define $ITM_USERNAME = '&1'
define $ITM_USER_PASSWORD = '&2'

alter session set "_ORACLE_SCRIPT"=true;

CREATE USER &ITM_USERNAME IDENTIFIED BY &ITM_USER_PASSWORD DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE TEMP PROFILE DEFAULT; 
GRANT CREATE TABLE TO &ITM_USERNAME; 
GRANT CREATE VIEW TO &ITM_USERNAME; 
GRANT DEBUG CONNECT SESSION TO &ITM_USERNAME; 
GRANT CREATE SEQUENCE TO &ITM_USERNAME; 
GRANT CREATE SESSION TO &ITM_USERNAME; 
GRANT CONNECT TO &ITM_USERNAME; 
ALTER USER &ITM_USERNAME QUOTA UNLIMITED ON USERS; 
ALTER USER &ITM_USERNAME IDENTIFIED BY &ITM_USERNAME ACCOUNT UNLOCK;
--DB event triggers


set serveroutput on;
set verify off;
--to change sesstion dispaly style from date to datetime
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY HH24:MI:SS';

--create one table to store logon logoff on mydb schema
create table mydb_events(event varchar(30),logon_time date,logoff_time date);
select * from mydb_events;

--crate trigger  for logon logoff audit
create trigger mydb_logon_trigger
after logon on schema
enable
declare
begin
    insert into mydb_events values(ora_sysevent,sysdate,null);
end;
/
--logoff
create trigger mydb_logoff_trigger
before logoff on schema
enable
declare
begin
    insert into mydb_events values(ora_sysevent,null,sysdate);
end;
/



---now logon logoff on db level:: connect to system db
show user;
--create table to audit
create table db_events(userr varchar(30),event varchar(30),logon_time date,logoff_time date);
select * from db_events;
--create triggers
--logon
create trigger db_logon_trigger
after logon on database
enable
declare
begin
    insert into db_events values(user,ora_sysevent,sysdate,null);
end;
/
--logoff
create trigger db_logoff_trigger
before logoff on database
enable
declare
begin
    insert into db_events values(user,ora_sysevent,null,sysdate);
end;
/









--now startup shutdown on db level:: connect to system db
show user;
--create table to audit
create table db_ss_events(userr varchar(30),event varchar(30),event_date date);
select * from db_ss_events;
--create triggers
--startup
create or replace trigger db_startup_trigger
after startup on database
enable
declare
begin
    insert into db_ss_events values(user,ora_sysevent,sysdate);
    --commit;
end;
/
--shutdown
create or replace trigger db_shutdown_trigger
before shutdown on database
enable
declare
begin
    insert into db_ss_events values(user,ora_sysevent,sysdate);
    --commit;
end;
/


open cmd
>sqlplus / as sydba;
>shutdown immediate;
>startup;

select * from db_ss_events;
truncate table db_ss_events;

thats it

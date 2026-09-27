---DDL Triggers

set serveroutput on;
set verify off;
--to change sesstion dispaly style from date to datetime
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY HH24:MI:SS';


--ddl create, alter, truncate, drop trigger
create or replace trigger mydb_ddl_trigger
before create or alter or truncate or drop on schema
enable
declare
begin
    dbms_output.put_line('from all-trigger ddl:: ');
    if ora_sysevent='CREATE' then
        dbms_output.put_line('hey u creating a obj:'||ora_dict_obj_type||':'||ora_dict_obj_name);
    elsif ora_sysevent='ALTER' then
        dbms_output.put_line('hey u altering a obj:'||ora_dict_obj_type||':'||ora_dict_obj_name);
    elsif ora_sysevent='TRUNCATE' then
        dbms_output.put_line('hey u truncating a obj:'||ora_dict_obj_type||':'||ora_dict_obj_name);
    elsif ora_sysevent='DROP' then
        dbms_output.put_line('hey u dropping a obj:'||ora_dict_obj_type||':'||ora_dict_obj_name);
    else
        dbms_output.put_line('ntg');
    end if;
end;
/

-- createa a audit table to store audit data on mydb
create table mydb_ddl_audit(ddl_date date, ddl_user varchar(10), object_type varchar(10),object_name varchar(10),ddl_operation varchar(10));


--create ddl trigger
create or replace trigger mydb_ddl_audit_trigger
after ddl on schema
enable
declare
    userv varchar(10);
begin
    select user into userv from dual;
 insert into mydb_ddl_audit values(sysdate,userv,ora_dict_obj_type,ora_dict_obj_name,ora_sysevent);
end;
/

--now ddl operations on mydb schema
select * from mydb_ddl_audit;
create table tab1(name varchar(10));
insert into tab1 values('ii');
create table tab2(name varchar(10));
truncate table tab2;
drop table tab1;
drop table tab2;
alter table tab1 rename to tabbb;
drop table tabbb;
truncate table mydb_ddl_audit;
drop trigger mydb_ddl_audit_trigger;
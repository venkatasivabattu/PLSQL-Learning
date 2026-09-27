---DML Triggers

set serveroutput on;
set verify off;

--create a table for DML triggers purpoese

create table heros(name varchar(10));

insert into heros values('ram');

select * from heros;

--dml before insert trigger

create or replace trigger heros_binsert_trigger
before insert on heros
for each row
enable
declare
    uname varchar(10);
    c number;
begin
    select count(*) into c from heros;
    select user into uname from dual; --just eading user name from db system
    dbms_output.put_line('hey u before inserting a row mr:'||uname||' count:'||c);
end;
/

--now insert one row into heros
insert into heros values('sam');


--dml after insert trigger --error

create or replace trigger heros_ainsert_trigger
after insert on heros
for each row
enable
declare
    uname varchar(10);
    c number;
begin
    select count(*) into c from heros;--this causes mutaion error beacuse db is still using heros table foe each row triger only fired even it is tring to acacess heros for cnt so remove for each row
    select user into uname from dual; --just eading user name from db system
    dbms_output.put_line('hey u after inserting a row mr:'||uname||' count:'||c);
end;
/

--dml after insert trigger

create or replace trigger heros_ainsert_trigger
after insert on heros
enable
declare
    uname varchar(10);
    c number;
begin
    select count(*) into c from heros;--this causes mutaion error beacuse db is still using heros table foe each row triger only fired even it is tring to acacess heros for cnt so remove for each row
    select user into uname from dual; --just eading user name from db system
    dbms_output.put_line('hey u after inserting a row mr:'||uname||' count:'||c);
end;
/

--now insert one row into heros
insert into heros values('kam');




--dml before update trigger

create or replace trigger heros_bupdate_trigger
before update on heros
for each row
enable
declare
begin
    dbms_output.put_line('hey u before updatingg a row ');
end;
/

--now update one row into heros
update heros set name='eww' where name='ram';
select * from heros;



--dml before delete trigger

create or replace trigger heros_bdelete_trigger
before delete on heros
for each row
enable
declare
begin
    dbms_output.put_line('hey u before deleting a row ');
end;
/

--now delete one row into heros
delete from heros where name='sam';
select * from heros;



--all in one trigger

create or replace trigger heros_b_all_dml_trigger
before insert or update or delete on heros
for each row
enable
declare
begin
    dbms_output.put_line('from all-trigger:: ');
    if inserting then
        dbms_output.put_line('hey u before insert a row ');
    elsif updating then
        dbms_output.put_line('hey u before update a row ');
    elsif deleting then
        dbms_output.put_line('hey u before deleteg a row ');
    end if;
end;
/

--now dml cmnds n heros
insert into heros values('dam');
update heros set name='ram' where name='dam';
delete from heros where name='ram';
select * from heros;






--heros dml auditing
--create a dummy table to store audit data
create table heros_audit(new_name varchar(10),old_name varchar(10),user_by varchar(10),operation_date date,operation varchar(10));
desc heros_audit;

--create audit trigger
create or replace trigger heros_dml_audit_trigger
before insert or update or delete on heros
for each row
enable
declare
    vuser varchar(10);
    vdate date;
begin
    select user,systimestamp into vuser,vdate from dual;
    if inserting then
        insert into heros_audit values(:new.name,null,vuser,vdate,'Insert');
    elsif updating then
        insert into heros_audit values(:new.name,:old.name,vuser,vdate,'Update');
    elsif deleting then
        insert into heros_audit values(null,:old.name,vuser,vdate,'Delete');
    end if;
end;
/

--to change sesstion dispaly style from date to datetime
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY HH24:MI:SS';

--now dml cmnds n heros
insert into heros values('ram');
update heros set name='ram' where name='dam';
delete from heros where name='ram';
select * from heros;
select * from heros_audit;
truncate table heros;--if we observe trigger not fired as it is not a delete operation






---heros backup table
create table heros_backup as select * from heros;
--empty both tables
--create backup trigger
create or replace trigger heros_backup_trigger
before insert or update or delete on heros
for each row
enable
declare
begin
    if inserting then
        insert into heros_backup values(:new.name);
    elsif updating then
        update heros_backup set name=:new.name where name=:old.name;
    elsif deleting then
        delete from heros_backup where name=:old.name;
    end if;
end;
/
--now dml cmnds n heros
insert into heros values('dam');
update heros set name='ram' where name='dam';
delete from heros where name='ram';
select * from heros;
select * from heros_backup;





set serveroutput on;
set verify off;

--create a table
create table temp(vid number);
insert into temp values(2);
insert into temp values(3);
select * from temp;

--create a trigger
create or replace trigger temp_t1
before insert on temp
for each row
enable
declare
begin
    dbms_output.put_line('insertttttttttt');
end;
/

--now insert
insert into temp values(4);

--edit/change trigger
create or replace trigger temp_t1
before insert on temp
for each row
enable
declare
begin
    dbms_output.put_line('insertttttttttt change');
end;
/

--now insert
insert into temp values(6);

--one more trigger
create or replace trigger temp_t2
after insert on temp
for each row
enable
declare
begin
    dbms_output.put_line(' after insertttttttttt');
end;
/

--now insert
insert into temp values(7);


--compile trigger
alter trigger temp_t1 compile;

--rename trigger
alter trigger temp_t1 rename to temp_trigger1;

--disable trigger
alter trigger temp_t2 disable;

--enable trigger
alter trigger temp_t2 enable;

--disable all triggers on teble temp
alter table mydb.temp disable all triggers;

--now insert
insert into temp values(6); --so no triger trgered

--enable all triggers on teble temp
alter table mydb.temp enable all triggers;

--now insert
insert into temp values(6); --so triger trgered


--drop trigre
drop trigger temp_t2;
drop trigger temp_trigger1;


--done no cmnd to drop all trigers at a time
drop table temp;



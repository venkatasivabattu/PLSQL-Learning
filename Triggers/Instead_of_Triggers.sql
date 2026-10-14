set serveroutput on;
set verify off;
--to change sesstion dispaly style from date to datetime
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY HH24:MI:SS';

---Instead of triggers
--create 2 tables for demo purpose
create table pet(pname varchar(10));
create table sound(says varchar(10));

--insert data
insert into pet values('dog');
insert into pet values('cat');

insert into sound values('bow');
insert into sound values('mew');




--create view
create view pet_sound_view as select pname,says from pet,sound;

select * from pet;
select * from sound;
select * from pet_sound_view;

insert into pet values('pig');
insert into sound values('oww');

--check direct insert to view
insert into pet_sound_view(pname,says) values('a','b'); --error

--now instead of insert
create or replace trigger instead_of_insert_trigger
instead of insert on pet_sound_view
for each row
begin
    insert into pet values(:new.pname);
    insert into sound values(:new.says);
end;
/

--now check direct insert to view
insert into pet_sound_view(pname,says) values('a','b');--done
select * from pet_sound_view;
select * from pet;
select * from sound;











---instead of update

update pet set pname='pig' where pname='dog';
update sound set says='oww' where says='bow';
select * from pet_sound_view;
select * from pet;
select * from sound;


--check direct update to view
update pet_sound_view set pname='lig' where says='oww'; --not working fine


--now instead of update one tabl
create or replace trigger instead_of_update_trigger
instead of update on pet_sound_view
for each row
begin
    update pet set pname=:new.pname where pname=:old.pname;
end;
/

--now check direct insert to view
update pet_sound_view set pname='ant' where pname='dog'; --worked
update pet_sound_view set pname='pig' where says='mew'; --not fine
update pet_sound_view set says='eww' where says='mew'; --no result
update pet_sound_view set says='eww' where pname='dog';-- no result
update pet_sound_view set pname='ant',says='eww' where pname='dog';-- onlt pet change

select * from pet_sound_view;
select * from pet;
select * from sound;


--now instead of update  two tabs
create or replace trigger instead_of_update_trigger
instead of update on pet_sound_view
for each row
begin
    update pet set pname=:new.pname where pname=:old.pname;
    update sound set says=:new.says where says=:old.says;
end;
/

--now check direct updte to view
update pet_sound_view set pname='dog' where pname='ant'; --worked
update pet_sound_view set pname='pig' where says='mew'; --not fine
update pet_sound_view set says='eww' where says='mew'; --no result
update pet_sound_view set says='eww' where pname='pig';-- no result

select * from pet_sound_view;
select * from pet;
select * from sound;


----now instead of delete  two tabs
create or replace trigger instead_of_delete_trigger
instead of delete on pet_sound_view
for each row
begin
    dbms_output.put_line(:old.pname||'  '||:old.says);
    delete from pet where pname=:old.pname;
    delete from sound where says=:old.says;
end;
/
drop trigger instead_of_delete_trigger;

--delete cmnds
delete from pet_sound_view where pname='dog'; 
delete from pet_sound_view where says='mew'; 
delete from pet_sound_view where pname='dog' and says='mew'; 


select * from pet_sound_view;
select * from pet;
select * from sound;

--insert data
insert into pet values('dog');
insert into pet values('cat');

insert into sound values('bow');
insert into sound values('mew');
rollback;
truncate table pet;
truncate table sound;


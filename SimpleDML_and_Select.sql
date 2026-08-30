set serveroutput on;
set verify off;

--select
declare 
    vSalary int;
    vName varchar(10);
begin
    select name,salary into vName,vSalary from employees where id=2;
    dbms_output.put_line('name: '||vName||' :: Salary: '||vSalary); 
end;
/

--insert 
declare
    vid employees.id%type:=5;
    vname employees.name%type:='sim';
    vsal employees.salary%type:=30000;
    rc number:=0;
begin
    select count(*) into rc from employees;
    dbms_output.put_line('Before count:'||rc);
    insert into employees values(vid,vname,vsal);
    select count(*) into rc from employees;
    dbms_output.put_line('Before count:'||rc);
end;
/


--update
declare
    vid employees.id%type:=4;
    vsal employees.salary%type;
begin
    select salary into vsal from employees where id=vid;
    dbms_output.put_line(vid||' Before update: '||vsal);
    vsal:=vsal+5000;
    update employees set salary=vsal where id=vid;
    select salary into vsal from employees where id=vid;
    dbms_output.put_line(vid||' after update: '||vsal);
end;
/

--checking the commit nature of plsql
select * from employees;
rollback;
select * from employees;
--after running this we came to know that the inserted and updated records got rollback to original table


--update--insert new row
declare
    vid employees.id%type:=4;
    vname employees.name%type:='kim';
    vsal employees.salary%type;
    rc number;
begin
    select count(*) into rc from employees;
    dbms_output.put_line('Before count:'||rc);
    update employees set id=vid,name=vname,salary=vsal where id=vid;
    select count(*) into rc from employees;
    dbms_output.put_line('Before count:'||rc);
end;
/


---not possinble--if no records matched the condition then no uupdation


--delete
declare
    vid employees.id%type:=4;
    rc number;
begin
    select count(*) into rc from employees;
    dbms_output.put_line('Before count:'||rc);
    delete from employees where id=vid;
    select count(*) into rc from employees;
    dbms_output.put_line('Before count:'||rc);
end;
/
 
 
 
 

set serveroutput on;

----variables

begin 
dbms_output.put_line('Hi');
end;
/

declare
name varchar2(10);
begin 
name:='ram';
dbms_output.put_line(name);
end;
/

declare
name varchar2(10):='sam';
begin 
dbms_output.put_line(name);
end;
/


---select into

use mydb;


create table employees(id int,name varchar(10),salary int);

insert into employees values(1,'ram',20000);
insert into employees values(2,'sam',30000);

select * from employees;

---now plsql

declare 
    vSalary int;
    vName varchar(10);
begin
    select name,salary into vName,vSalary from employees where id=2;
    dbms_output.put_line('name: '||vName||' :: Salary: '||vSalary); 
end;
/


----anchor dtypes %type
declare 
    vSalary employees.salary%type;
    vName employees.name%type;
begin
    select name,salary into vName,vSalary from employees where id=1;
    dbms_output.put_line('name: '||vName||' :: Salary: '||vSalary); 
end;
/

--error
declare 
    vSalary employees.salary%type;
    vName char(2);---unable to cast varchar large to char small
begin
    select name,salary into vName,vSalary from employees where id=1;
    dbms_output.put_line('name: '||vName||' :: Salary: '||vSalary); 
end;
/


--constants
declare
age constant number(2);
begin 
    age:=23;
dbms_output.put_line(age);
end; --error
/

declare
    age constant number(2):=23;
begin 
    dbms_output.put_line(age);
end; 
/
--default
declare
    age number(2) default 83;
begin 
    dbms_output.put_line(age);
end; 
/

--constant with default
declare
    age constant number(2) default 23;
begin 
    dbms_output.put_line(age);
end; 
/


--not null
declare
    age number(2) not null:=63;
begin 
    dbms_output.put_line(age);
end; 
/

--const not null
declare
    age constant number(2) not null:=43;
begin 
    dbms_output.put_line(age);
end; 
/


--variable with default and not null
declare
    age number(2) not null default 13;
begin 
    --age:=null;--error
    dbms_output.put_line(age);
end; 
/





--constant with default and not null
declare
    age constant number(2) not null default 93;
begin 
    dbms_output.put_line(age);
end; 
/



---bind variables
variable var1 number;
print var1;

declare 
    variable v2 number;
begin
    variable v2 number;
end;
/---wrong

--inilize bindvariable 
--way1
exec :var1:=23;
--way2
begin
    :var1:=64;

end;
/


--displaying bind var vlue
--way1
print var1;
--way2
begin
    dbms_output.put_line(:var1);
end;
/
--way3
set autoprint on;
variable var2 number;
exec :var2 :=89;







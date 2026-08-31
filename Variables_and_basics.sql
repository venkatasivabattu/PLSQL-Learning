set serveroutput on;
set verify off;

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

--dtypes
--number(x,y)
declare
   /* a number:=3;
    b number(4,2):=3.4;
    c number(4,2):=3.44;
    d number(4,2):=33.44;
    --e number(4,2):=333.44; error
     f number(4,2):=33.444; --took upto 33.44
     g number(5,3):=33.44; 
     h number(4,2):=33.4567;--rounded to 2digits 33.46 
     --i number(4,2):=3334; --error  
     j number(4,2):=333.4; --error 
     k number(4,2):=4; 
     l number(4,2):=4.00; */
     m number(4,2):=4.001;
begin
    dbms_output.put_line('hii');
   /* dbms_output.put_line(a);
    dbms_output.put_line(b);
    dbms_output.put_line(c);
    dbms_output.put_line(d);
    --dbms_output.put_line(e); error 
    dbms_output.put_line('f '||f); 
    dbms_output.put_line(g); 
    dbms_output.put_line(h); 
    --dbms_output.put_line(i); 
    dbms_output.put_line(j);  
    dbms_output.put_line(k); 
    dbms_output.put_line(l); */
    dbms_output.put_line(m);  
end;
/
    
 
--float
declare
    a float:=3679576957.858588;
    b float(3):=3;
    c float(3):=33.3;
    d float(3):=333.3;
    e float(30):=33.3;
begin
    dbms_output.put_line(a);
    dbms_output.put_line(b);
    dbms_output.put_line(c);
    dbms_output.put_line(d);
    dbms_output.put_line(e);-- something with precision
    
end;
/

--natural: natural nums 0,1,2,3...
declare
    a natural:=45;
    b natural:=0;
    c natural:=45.56; --rounded to 46
    d natural:=null;
    --e naturaln:=null; --error
begin
    dbms_output.put_line(a);
    dbms_output.put_line(b);
    dbms_output.put_line(c);
   dbms_output.put_line(d);
  -- dbms_output.put_line(e);
    
end;
/


--positive (>0 ) 1,2,3,.........
declare
    a positive:=23;
    b positive:=23.43;
    --c positive:=0; --error
    d positive:=null;
   --e positiven:=null; --error
begin
    dbms_output.put_line(a);
    dbms_output.put_line(b);
    --dbms_output.put_line(c);
     dbms_output.put_line(d);
    --dbms_output.put_line(e);
    
end;
/

--char
declare
    --a char:='hi'; --error
        b char(3):='';
        c char(3):=null;
        d char(3):='hi';
        e char(3):='abc';
    --f char(3):='abcd'; --error
begin
    dbms_output.put_line(b||'b');
    dbms_output.put_line(c||'c');
    dbms_output.put_line(d);
     dbms_output.put_line(e);
     
end;
/

--varchar 
declare
        --a varchar:='hi'; --error
        b varchar(3):='';
        c varchar(3):=null;
        d varchar(3):='hi';
        e varchar(3):='abc';
        --f varchar(3):='abcd'; --error
begin
dbms_output.put_line('var');
    dbms_output.put_line(b||'b');
    dbms_output.put_line(c||'c');
    dbms_output.put_line(d);
     dbms_output.put_line(e);
     
end;
/

--long
declare
    a long:='abcd';
    b long:='';
    c long:=null;
    d long(3):='abc';
    --e long(3):='abcdefgh'; --error
    
       
begin
    dbms_output.put_line('long');
    dbms_output.put_line(a);
   dbms_output.put_line(b||'b');
   dbms_output.put_line(c||'c');
    dbms_output.put_line(d);
     dbms_output.put_line(e);
     
end;
/
   
--bool
declare
 a boolean:=True;
 b boolean:=False;
 c boolean:=null;
-- d boolean:=1;--error
begin
    --dbms_output.put_line(a); --error cant print directly
    dbms_output.put_line(case when a then 'True' else 'False' end);
    dbms_output.put_line(case when b then 'True' else 'False' end);
    dbms_output.put_line(case when c then 'True' when not(c)then 'False' else 'null' end);
end;
/


--dates
declare
    a date:=sysdate;
    b timestamp:=systimestamp;
begin
    dbms_output.put_line(a);
    dbms_output.put_line(b);
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

--- %rowtype
declare 
    emp employees%rowtype;
    
begin
    select * into emp from employees where id=1;
    dbms_output.put_line('id: '||emp.id||':: name: '||emp.name||' :: Salary: '||emp.salary); 
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











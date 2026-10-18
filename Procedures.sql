set serveroutput on;
set verify off;

--create a procedure
create or replace procedure proc1
is
    vname varchar(20):='sivaaaaaa';
begin
    dbms_output.put_line(vname);
end proc1;
/

--calling
--way1
execute proc1;
exec proc1;

--way2
begin
 proc1();
end;
/

--way3
call proc1();

--task calling procedure from named block:trihgger

create or replace trigger logt
after insert on pet
for each row
ENABLE
begin
    dbms_output.put_line('triger');
    proc1();
end;
/

insert into pet values('hen');
select * from pet;


--with params
create or replace procedure proc1(vid number,vsal number)
is
begin
    update employees set salary = salary*vsal where id=vid;
end;
/

select * from employees;
call proc1(8,2);

--task to find the third highest salry
create or replace procedure proc1
is
    emp employees%rowtype;
begin
    select * into emp from employees where id in (select id from employees order by salary desc fetch first 3 rows only) order by salary fetch first 1 rows only;
    dbms_output.put_line(emp.id||':'||emp.name||':'||emp.salary);
end;
/

call proc1();



--calling notations
--1.positional clling noatation
create or replace procedure proc1(vid number,vsal number)
is
begin
    update employees set salary = salary*vsal where id=vid;
end;
/

call proc1(8,2);

--2.named callng notation
create or replace procedure proc1(n1 number,n2 number default 0, n3 number)
is 
    s number;
begin
    dbms_output.put_line('n1'||'=>'||n1);
    dbms_output.put_line('n2'||'=>'||n2);
    dbms_output.put_line('n3'||'=>'||n3);
    s:=n1+n2+n3;
    dbms_output.put_line('sum'||'=>'||s);
end;
/
exec proc1(1,2,3);
exec proc1(2,3); --err
exec proc1(9,,7);--err
exec proc1(n3=>2,n1=>1);

--3.mixed callng notation
create or replace procedure proc1(n1 number,n2 number default 0, n3 number)
is 
    s number;
begin
    dbms_output.put_line('n1'||'=>'||n1);
    dbms_output.put_line('n2'||'=>'||n2);
    dbms_output.put_line('n3'||'=>'||n3);
    s:=n1+n2+n3;
    dbms_output.put_line('sum'||'=>'||s);
end;
/

exec proc1(1,n3=>2,n2=>1);
exec proc1(n3=>2,1,2); --err


--in, out, in out
create or replace procedure proc1(a in number, b number,c out number,d in out number)
is
begin
    dbms_output.put_line('proc strt a'||'=>'||a);
    dbms_output.put_line('proc strt b'||'=>'||b);
    dbms_output.put_line('proc strt c'||'=>'||c);
    dbms_output.put_line('proc strt d'||'=>'||d);
    dbms_output.put_line('-------------------------------------');
    --a:=a+1; error
    --b:=b+1; error
    c:=100;
    d:=d+1;
    dbms_output.put_line('proc end a'||'=>'||a);
    dbms_output.put_line('proc end b'||'=>'||b);
    dbms_output.put_line('proc end c'||'=>'||c);
    dbms_output.put_line('proc end d'||'=>'||d);
    dbms_output.put_line('-------------------------------------');
end;
/
declare
    a number:=1;
    b number:=2;
    c number:=3;
    d number:=4;
begin
    dbms_output.put_line('-------------------------------------');
    dbms_output.put_line('proc bef a'||'=>'||a);
    dbms_output.put_line('proc bef b'||'=>'||b);
    dbms_output.put_line('proc beft c'||'=>'||c);
    dbms_output.put_line('proc bef d'||'=>'||d);
    dbms_output.put_line('-------------------------------------');
    proc1(a,b,c,d);
    dbms_output.put_line('proc aftr a'||'=>'||a);
    dbms_output.put_line('proc aftrf b'||'=>'||b);
    dbms_output.put_line('proc aftrt c'||'=>'||c);
    dbms_output.put_line('proc aftr d'||'=>'||d);
end;
/
    

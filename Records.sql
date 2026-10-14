set serveroutput on;
set verify off;

select * from employees;

--table based record
declare
    emp employees%rowtype; --declare
begin
    select * into emp from employees where id=7;
    dbms_output.put_line(emp.name||':'||emp.salary);
end;
/

---table based record with seelcted cols
declare
    emp employees%rowtype; --declare
begin
    select id,name into emp.id,emp.name from employees where id=7;
    dbms_output.put_line(emp.id||':'||emp.name);
    
end;
/

---table based record with seelcted cols null cols
declare
    emp employees%rowtype; --declare
begin
    select id,name into emp.id,emp.name from employees where id=7;
    dbms_output.put_line(emp.id||':'||emp.name);
    dbms_output.put_line('sal:'||emp.salary); --defalut null is stored
    if emp.salary is null then
        dbms_output.put_line('sal is null');
    end if;
    
end;
/


--cursor based record

declare
    cursor emp_cur is select * from employees where id=7;
    emp emp_cur%rowtype; --declare
begin
    open emp_cur;
    fetch emp_cur into emp;
    dbms_output.put_line(emp.name||':'||emp.salary);
    close emp_cur;
end;
/

--cursor based record mutliple rows

declare
    cursor emp_cur is select * from employees;
    emp emp_cur%rowtype; --declare
begin
    open emp_cur;
    loop
        fetch emp_cur into emp;
        exit when emp_cur%notfound;
        dbms_output.put_line(emp.name||':'||emp.salary);
    end loop;
    close emp_cur;
   
end;
/

--cursor based record mutliple rows and for loop

declare
    cursor emp_cur is select * from employees where id=7;
    emp emp_cur%rowtype; --declare
begin
    for emp in emp_cur
    loop
        dbms_output.put_line(emp.name||':'||emp.salary);
    end loop;
    dbms_output.put_line(emp.name||':'||emp.salary);
end;
/


--user defined record
declare
    type emp_type is record(name varchar(20),salary number);
    emp_rec emp_type;
begin
    select name,salary into emp_rec.name,emp_rec.salary from employees where id=3;
     dbms_output.put_line(emp_rec.name||':'||emp_rec.salary);
end;
/
--user defined record
declare
    type emp_type is record(name varchar(20),salary number);
    emp_rec emp_type;
    
begin
    
    for emp_rec in (select name,salary from employees)
    loop
     dbms_output.put_line(emp_rec.name||':'||emp_rec.salary);
    end loop;
end;
/

create table teacher(name varchar(20),sid number);
create table subject(sid number,name varchar(20));

insert into teacher values('ram',2);
insert into teacher values('sam',1);
insert into teacher values('sam',2);

insert into subject values(2,'c');
insert into subject values(1,'java');

select * from subject;
select * from teacher;
select * from teacher inner join subject on subject.sid=teacher.sid;

--user record with multpiple cols
declare
    type mytype1 is record(
        tname teacher.name%type,
        sname subject.name%type);
    myrec mytype1;
begin
    select t.name,s.name into myrec.tname,myrec.sname from teacher t inner join subject s on s.sid=t.sid where s.sid=1;
    dbms_output.put_line(myrec.tname||':'||myrec.sname);
end;
/


drop table teacher;
drop table subject;
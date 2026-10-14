set serveroutput on;
set verify off;

insert into employees values(4,'lam',10000);
select * from employees;-- craete if not exists


--create a cusror on employees table
declare
    vname varchar(20);
    cursor emp_cursor
    is
    select name from employees; --declrng cursor
begin
    open emp_cursor; --opening a cursor
    loop
        fetch emp_cursor into vname; --fetching a cursor data
        if emp_cursor%NOTFOUND then
            dbms_output.put_line('no data');
            exit;
        else 
            dbms_output.put_line(vname);
        end if;
    end loop;
    close emp_cursor; --closing cursor
end;
/


--create a cusror on employees table eg2
declare
    vname varchar(20);
    cursor emp_cursor
    is
    select name from employees where salary<=30000; --declrng cursor
begin
    open emp_cursor; --opening a cursor
    loop
        fetch emp_cursor into vname; --fetching a cursor data
        if emp_cursor%NOTFOUND then
            dbms_output.put_line('no data');
            exit;
        else 
            dbms_output.put_line(vname);
        end if;
    end loop;
    close emp_cursor; --closing cursor
end;
/
    
    
--create a cusror on employees table with parameters
declare
    vname varchar(20);
    cursor emp_cursor(in_salary number)
    is
    select name from employees
    where salary <= in_salary; --declrng cursor
begin
    open emp_cursor(20000); --opening a cursor
    loop
        fetch emp_cursor into vname; --fetching a cursor data
        exit when emp_cursor%notfound;
        dbms_output.put_line(vname);
    end loop;
    close emp_cursor; --closing cursor
end;
/

--create a cusror on employees table with parameters:: default value
declare
    vname varchar(20);
    vsal number;
    cursor emp_cursor(in_salary number:=30000)
    is
    select name,salary from employees
    where salary <= in_salary
    order by salary; --declrng cursor
begin
    --open emp_cursor;--opening cursor without arg val
    open emp_cursor(20000); --opening a cursor with arg val
    loop
        fetch emp_cursor into vname,vsal; --fetching a cursor data
        exit when emp_cursor%notfound;
        dbms_output.put_line(vname||':'||vsal);
    end loop;
    close emp_cursor; --closing cursor
end;
/



--cursor for loop
--cursor for loop
declare
    cursor emp_cursor
    is
    select name from employees
    where salary <= 30000
    order by salary; --declrng cursor
begin
    for emp in emp_cursor
    loop
        dbms_output.put_line(emp.name);
    end loop;
end;
/

--eg2
declare
    cursor emp_cursor
    is
    select name,salary from employees
    where salary <= 30000
    order by salary; --declrng cursor
begin
    for emp in emp_cursor
    loop
        dbms_output.put_line(emp.name||':'||emp.salary);
    end loop;
end;
/

--cursoe for with params
declare
    cursor emp_cursor(in_salary number)
    is
    select name,salary from employees
    where salary <= in_salary
    order by salary; --declrng cursor
begin
    for emp in emp_cursor(30000)
    loop
        dbms_output.put_line(emp.name||':'||emp.salary);
    end loop;
end;
/


--cursoe for with params default value
declare
    cursor emp_cursor(in_salary number:=20000)
    is
    select name,salary from employees
    where salary <= in_salary
    order by salary; --declrng cursor
begin
    --for emp in emp_cursor
    --for emp in emp_cursor()
    for emp in emp_cursor(30000)
    loop
        dbms_output.put_line(emp.name||':'||emp.salary);
    end loop;
end;
/


--inline cursor
declare
begin
    for emp in (select name,salary from employees)
    loop
        dbms_output.put_line(emp.name||':'||emp.salary);
    end loop;
end;
/




--inline cursor with param
declare
    vsal number:=30000;
begin
    for emp in (select name,salary from employees where salary<=vsal)
    loop
        dbms_output.put_line(emp.name||':'||emp.salary);
    end loop;
end;
/


---updation and deleetion inside cursor

declare
    vname varchar(20);
    vsal number;
    vc number;
    cursor emp_cursor
    is
    select name,salary from employees
    where salary <= 40000
    order by salary
    for update; --for both update and deleet same
begin
   
    for emp in emp_cursor
    loop
        dbms_output.put_line('Before update: '||emp.name||':'||emp.salary);
        update employees set salary=salary+1 where current of emp_cursor;
        --fetch emp_cursor into vnamme,vsal;
        select name,salary into vname,vsal from employees where name=emp.name;
        dbms_output.put_line('After update: '||vname||':'||vsal);
        select count(*) into vc from employees;
        dbms_output.put_line('Before delete: '||vc);
        delete from employees where current of emp_cursor;
        select count(*) into vc from employees;
        dbms_output.put_line('After delete: '||vc||chr(10));
    end loop;
    
end;
/



---updation and deleetion inside cursor using fetch

declare
    vname varchar(20);
    vsal number;
    vc number:=0;
    cursor emp_cursor
    is
    select name,salary from employees
    where salary <= 40000
    order by salary
    for update; --for both update and deleet same
begin
   
    open emp_cursor;
    loop
        
        fetch emp_cursor into vname,vsal;
        exit when emp_cursor%notfound;
        dbms_output.put_line('Before update: '||vname||':'||vsal);
        update employees set salary=salary+10 where current of emp_cursor;
        --fetch emp_cursor into vnamme,vsal;
        select name,salary into vname,vsal from employees where name=vname;
        --fetch emp_cursor into vname,vsal;--it will fetch next row rather cureent row
        dbms_output.put_line('After update: '||vname||':'||vsal);
        select count(*) into vc from employees;
        dbms_output.put_line('Before delete: '||vc);
        delete from employees where current of emp_cursor;
        select count(*) into vc from employees;
        dbms_output.put_line('After delete: '||vc||chr(10));
        
    end loop;
    close emp_cursor;
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
    cursor emp_cur is select * from employees;
    emp emp_cur%rowtype; --declare
begin
    for emp in emp_cur
    loop
        dbms_output.put_line(emp.name||':'||emp.salary);
    end loop;
end;
/








select * from employees;

insert into employees values(5, 'ram', 15000);
insert into employees values(6, 'sam', 22000);
insert into employees values(7, 'pam', 28000);
insert into employees values(8, 'tim', 35000);

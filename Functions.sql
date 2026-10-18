set serveroutput on;
set verify off;
--creating a function 
create or replace function square_fun(num number) return number is
 sq number;
begin
    sq:=num*num;
    return sq;
end;
/

--callind function
begin
    dbms_output.put_line(square_fun(3));
end;
/
--callind function store val
declare
    sq number;
begin
    sq:=square_fun(4);
    dbms_output.put_line(sq);
end;
/
--select call
select square_fun(7) from dual;



--creating a function 
create or replace function hello_fun return varchar2 is
begin
    dbms_output.put_line('hello dearrrr');
    return null;
end;
/

--callind function
begin
   dbms_output.put_line(hello_fun||' pal');
end;
/

--sum of two nums
create or replace function sum_fun(num1 number,num2 number) return number is
begin
    return num1+num2;
end;
/

--callind function
begin
    dbms_output.put_line(sum_fun(3,5));
end;
/

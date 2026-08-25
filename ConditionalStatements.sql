set serveroutput on;
set verify off;

--if then
declare 
    a number:=19;
begin
    if a>=18 then
        dbms_output.put_line('hey major');
    end if;
    dbms_output.put_line('hey comm onnn');
end;
/

declare 
    a number:=18;
    vote boolean:=true;
begin
    if a>=18 and vote then
        dbms_output.put_line('hey voter');
    end if;
    dbms_output.put_line('hey comm onnn');
end;
/


--if else
set verify off;
declare 
    num number(8):=&number;
begin
    if mod(num,2)=0 then 
        dbms_output.put_line('hey even '||num);
    else
        dbms_output.put_line('hey odd '||num);
    end if;
    dbms_output.put_line('outt');
end;
/

--if elsif ladder
declare 
    g VARCHAR(2):='&Grade';
begin
    if g='A' then 
        dbms_output.put_line('A Grade');
    elsif g='B' then 
        dbms_output.put_line('B Grade');
    elsif g='C' then 
        dbms_output.put_line('c Grade');
    else
        dbms_output.put_line('F Grade');
    end if;
    dbms_output.put_line('outt of ladder');
end;
/


--simpple case
declare 
    g VARCHAR(2):='&Grade';
begin
    dbms_output.put_line('bef of case');
    case g
        when 'A' then dbms_output.put_line('A Grade');
        when 'B' then dbms_output.put_line('B Grade');
        else dbms_output.put_line('C Grade');
    end case;
    dbms_output.put_line('outt of case');
    
end; 
/

--eg2
declare 
    vname employees.name%type:=null;
begin

    select name into vname from employees where id=3;
    
    dbms_output.put_line('bef of case');
    case vname
        when 'sam' then dbms_output.put_line('samuuuuuuuuuuuuuuu');
        when 'ram' then dbms_output.put_line('ramuuuuuuuuuu');
        else dbms_output.put_line('who are uuuuuuuuuu');
    end case;
    dbms_output.put_line('outt of case');
    
end; 
/
insert into employees values(3,'mam',40000);
select * from employees;


--serached case
declare 
    g VARCHAR(2):='&Grade';
begin
    dbms_output.put_line('bef of case');
    case 
        when g='A' then dbms_output.put_line('A Grade');
        when g='B' then dbms_output.put_line('B Grade');
        else dbms_output.put_line('C Grade');
    end case;
    dbms_output.put_line('outt of case');
    
end; 
/

--eg2
declare 
    vid employees.id%type:=&Id;
    vname employees.name%type;
    vsal employees.salary%type;
begin

    select name,salary into vname,vsal from employees where id=vid;
    
    dbms_output.put_line('bef of case');
    case 
        when vname='sam' and vsal=30000 then dbms_output.put_line('samuuuuuuuuuuuuuuu');
        when vname='ram' and vsal<=20000 then dbms_output.put_line('ramuuuuuuuuuu');
        else dbms_output.put_line('who are uuuuuuuuuu');
    end case;
    dbms_output.put_line('outt of case');
    
end; 
/




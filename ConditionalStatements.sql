set serveroutput on;

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
    
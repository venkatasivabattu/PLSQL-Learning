set serveroutput on;
set verify off;

--simple loop
--may get error cause infinite loop
declare
    num number:=&Number;
    i number:=1;
    res number;
begin
    loop
    res:=num*i;
    dbms_output.put_line(num||'*'||i||'='||res);
    i:=i+1;
    end loop;
end;
/ 


--simple loop with exit
declare
    num number:=&Number;
    i number:=1;
    res number;
begin
    loop
    res:=num*i;
    dbms_output.put_line(num||'*'||i||'='||res);
    if i=10 then exit; end if;
    i:=i+1;
    end loop;
end;
/ 


--simple loop with exit when
declare
    num number:=&Number;
    i number:=1;
    res number;
begin
    loop
    res:=num*i;
    dbms_output.put_line(num||'*'||i||'=='||res);
    exit when i=10;
    i:=i+1;
    end loop;
end;
/ 



--while loop
declare
    num number:=&Number;
    i number:=1;
    res number;
begin
dbms_output.put_line('simple while.....');
    while i!=11 loop
    res:=num*i;
    dbms_output.put_line(num||'*'||i||'='||res);
    i:=i+1;
    end loop;
end;
/ 

--while loop with boolean
declare
    num number:=&Number;
    i number:=1;
    res number;
    flag boolean:=true;
begin
dbms_output.put_line('simple while boolean.....');
    while flag loop
    res:=num*i;
    dbms_output.put_line(num||'*'||i||'='||res);
    i:=i+1;
    if i=11 then flag:=false; end if;
    end loop;
end;
/ 


--while loop exit
declare
    num number:=&Number;
    i number:=1;
    res number;
begin
dbms_output.put_line('simple while exit.....');
    while i!=11 loop
    res:=num*i;
    dbms_output.put_line(num||'*'||i||'='||res);
    i:=i+1;
     if i=11 then exit; end if;
    end loop;
end;
/ 

--while loop exit when
declare
    num number:=&Number;
    i number:=1;
    res number;
begin
dbms_output.put_line('simple while exit when.....');
    while i!=11 loop
    res:=num*i;
    dbms_output.put_line(num||'*'||i||'='||res);
    i:=i+1;
    exit when i=11;
    end loop;
end;
/ 


--for loop 
declare
    num number:=&Number;
    res number;
begin
dbms_output.put_line('simple for loop.....');
    for i in 1 .. 10 loop
    --res:=num*i;
    dbms_output.put_line(num||'*'||i||'='||num*i);
    end loop;
end;
/ 


--for loop  reverse
declare
    num number:=&Number;
    res number;
begin
dbms_output.put_line('for loop reverse.....');
    for i in reverse 1 .. 10 loop
    --res:=num*i;
    dbms_output.put_line(num||'*'||i||'='||num*i);
    end loop;
end;
/ 

--for loop exit
declare
    num number:=&Number;
    res number;
begin
dbms_output.put_line('for loop exit.....');
    for i in 1 .. 10 loop
    dbms_output.put_line(num||'*'||i||'='||num*i);
    if i=6 then exit; end if;
    end loop;
end;
/ 


--for loop exit when
declare
    num number:=&Number;
    res number;
begin
dbms_output.put_line('for loop exit when.....');
    for i in 1 .. 10 loop
    dbms_output.put_line(num||'*'||i||'='||num*i);
    exit when i=5;
    end loop;
end;
/ 


--nested loops
declare
    a number:=1;
    i number:=1;
begin
    dbms_output.put_line('simpple loop');
    loop 
        exit when a=3;
        while i!=6 loop
            dbms_output.put_line('while loop.'||i);
            i:=i+1;
        end loop;
        i:=1;
        
        for i in 1 .. 5 loop
            dbms_output.put_line('for loop .'||i);
        end loop;
        a:=a+1;
        
        dbms_output.put_line('\n\n\n\n');
    end loop;
end;
/
        
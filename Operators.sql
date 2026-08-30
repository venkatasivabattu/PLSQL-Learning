set serveroutput on;
set verify off;

--Arithmetic operations

declare
    a number:=10;
    b number:=2;
begin
    dbms_output.put_line(a||'+'||b||'='||(a+b));
    dbms_output.put_line(a||'-'||b||'='||(a-b));
    dbms_output.put_line(a||'*'||b||'='||(a*b));
    dbms_output.put_line(a||'/'||b||'='||(a/b));
    dbms_output.put_line(a||'**'||b||'='||(a**b));
    dbms_output.put_line(a||'%'||b||'='||(mod(a,b)));
end;
/



--Relational operations

declare
    a number:=10;
    b number:=2;
begin
   
    dbms_output.put_line(a||'='||b||'='||case when (a=b) then 'True' else 'False' end);
    dbms_output.put_line(a||'!='||b||'='||case when (a!=b) then 'True' else 'False' end);
    dbms_output.put_line(a||'<>'||b||'='||case when (a<>b) then 'True' else 'False' end);
    dbms_output.put_line(a||'<'||b||'='||case when (a<b) then 'True' else 'False' end);
    dbms_output.put_line(a||'<='||b||'='||case when (a<=b) then 'True' else 'False' end);
    dbms_output.put_line(a||'>'||b||'='||case when (a>b) then 'True' else 'False' end);
    dbms_output.put_line(a||'>='||b||'='||case when (a>=b) then 'True' else 'False' end);
end;
/



--Comparison Operators
declare
    a varchar(10):='siva';
    b varchar(10):='_%';
    c number:=3;
begin
     dbms_output.put_line(a||':like:'||b||'='||case when (a like b) then 'True' else 'False' end);
     dbms_output.put_line(a||':not like:'||b||'='||case when (a not like b) then 'True' else 'False' end);
     
     dbms_output.put_line(c||':betweene:'||' 20 and 30'||'='||case when (c between 20 and 30) then 'True' else 'False' end);
     dbms_output.put_line(c||':not between:'||' 20 and 30'||'='||case when (c not between 20 and 30) then 'True' else 'False' end);
     
     dbms_output.put_line(c||':in:'||' (2,3,4)'||'='||case when (c in (2,3,4)) then 'True' else 'False' end);
     dbms_output.put_line(c||':not in:'||' (2,3,4)'||'='||case when (c not in (2,3,4)) then 'True' else 'False' end);
     
     dbms_output.put_line(c||':is null:'||'='||case when (c is null) then 'True' else 'False' end);
     dbms_output.put_line(c||':is not null:'||'='||case when (c is not null) then 'True' else 'False' end);
end;
/


--Logical operations

declare
    a boolean:=False;
    b boolean:=False;
begin
   
    dbms_output.put_line(case when a then 'True' else 'False' end||' and '||case when b then 'True' else 'False' end||'='||case when (a and b) then 'True' else 'False' end);
    dbms_output.put_line(case when a then 'True' else 'False' end||' or '||case when b then 'True' else 'False' end||'='||case when (a or b) then 'True' else 'False' end);
    dbms_output.put_line('not '||case when a then 'True' else 'False' end||'='||case when (not a) then 'True' else 'False' end);
end;
/


--String Operations and functions
declare
    a varchar(10):='hello ';
    b varchar(10):='world';
    c varchar(10);
begin
    dbms_output.put_line(a||'||'||b||'='||(a||b));
    
    dbms_output.put_line(ascii('a'));
    dbms_output.put_line(chr(97));
    dbms_output.put_line(concat(a,b));
    dbms_output.put_line(initcap('hGhh'));
    dbms_output.put_line(lower('Ghjkhjk'));
    dbms_output.put_line(upper('Ghjkhjk'));
    dbms_output.put_line(length('abcd'));
    dbms_output.put_line(instr('abcd','c'));
    dbms_output.put_line(substr('abcde',3));
    
    
end;
/




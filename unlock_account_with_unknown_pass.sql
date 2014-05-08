SET serveroutput ON;
begin
  for rec in (select
    regexp_substr( dbms_metadata.get_ddl('USER', username), '''[^'']+''') pw,
    username from dba_users where username IN ('SYSTEM')) loop
    execute immediate 'alter user ' || rec.username || ' account unlock';
    execute immediate 'alter user ' || rec.username || 
      ' identified by values ' || rec.pw;
    dbms_output.put_line(rec.pw);
  end loop;
end;
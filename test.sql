-- Test string input.
create table stringa (string char(25));
-- Double and single quoted versions of the same string.
insert into stringa values ("foo/bar\\baz");
insert into stringa values ('foo/bar\\baz');
insert into stringa values ("foo\\"bar\\"baz");
insert into stringa values ('foo"bar"baz');
insert into stringa values ("foo\\`bar\\$baz%");
insert into stringa values ('foo`bar$baz%');
insert into stringa values ("<foo(bar)baz>\\\\");
insert into stringa values ('<foo(bar)baz>\\');
-- Other strings that can be tricky.
insert into stringa values ("foo'bar&baz");
insert into stringa values ("foo bar,baz");
print stringa;

-- Test copying strings via insert.
create table stringb (string char(25));
insert into stringb select * from stringa;
select * from stringb;

-- Test the different methods of creating views.
create view std_view (stringa.string = stringb.string);
select * from std_view;
create view exp_view string (stringa.string = stringb.string);
select * from exp_view;
create view sql_view as select * from stringa where length(string) = 11;
select * from sql_view;

-- Test string functions.
delete from stringb;
insert into stringb values ("This is a test string.");
select * from stringb;
select lower(string) from stringb;
select upper(string) from stringb;
select length(string) from stringb;
select char_length(string) from stringb;
select index(string,"test") from stringb;
select position("a" in string) from stringb;
select match(string,"^This.*") from stringb;
select substr(string,6) from stringb;
select substr(string,11,4) from stringb;

-- Test number functions.
create table numbers (numa int(10),  numb int(10));
insert into numbers values (1, 5, 5, 3, 3, 5);
select * from numbers;
select numa * numb,
       numa / numb,
       numa + numb,
       numa - numb,
       numa % numb,
       numb ^ numa
       from numbers;
select cos(numa),
       exp(numa),
       int(exp(numa)),
       log(numa),
       sin(numa),
       sqrt(numa)
       from numbers;

-- Add a column to the numbers table.
alter table numbers add column string char(25);

-- Update the numbers table.
update numbers set string = "This is a test string.";

-- Try substring using all columns.
select substr(string,numa,numb) from numbers;

-- Try the aggregates.
select avg(numa),count(*),max(numa),min(numa),sum(numa) from numbers;

-- They work on strings too.
select count(*),max(string),min(string) from stringa;

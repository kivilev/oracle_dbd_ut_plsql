create table country_tax
(
  country_id char(2) not null,
  tax        number(10,2)
);
comment on table country_tax
  is 'Демо таблица "Страна"';
  
alter table country_tax
  add constraint country_pk primary key (country_id);
  
alter table country_tax
  add constraint country_tax_country_id_chk
  check (country_id = upper(country_id));

insert into country_tax (country_id, tax)
values ('RU', .17);
insert into country_tax (country_id, tax)
values ('US', .23);
commit;

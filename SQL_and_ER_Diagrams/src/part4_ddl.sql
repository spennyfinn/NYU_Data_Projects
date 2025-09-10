
drop table if exists staging_caers_event_product cascade;
create table staging_caers_event_product (
    caers_event_product_id serial,
    report_id varchar(255),
    created_date date,
    event_date date,
    product_code text references product(product_code),
    primary key(caers_event_product_id));



drop table if exists report_term;
create table report_term
	(
	id serial primary key,
	report_id int,
	symptoms text ,
	foreign key (report_id) references staging_caers_event_product(caers_event_product_id)
	);


drop table if exists report_outcomes;
create table report_outcomes
(
id serial primary key,
report_id int,
outcomes text,
foreign key (report_id) references staging_caers_event_product(caers_event_product_id)
);

drop table if exists product
create table product(
	product_code text primary key,
	product text,
	product_type varchar(12),
	description text
);

drop table if exists patient
create table patient (
  id int primary key,
  patient_age TEXT,
  age_units TEXT,
  sex TEXT,
  foreign key (id) references staging_caers_event_product(caers_event_product_id)
);

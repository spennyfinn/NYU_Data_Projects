drop table if exists staging_caers_event_product;
create table staging_caers_event_product (
    caers_event_product_id serial,
    report_id varchar(255),
    created_date date,
    event_date date,
    product_type text,
    product text,
    product_code text,
    description text,
    patient_age decimal,
    age_units varchar(255),
    sex varchar(255),
    terms text,
    outcomes text,
    primary key(caers_event_product_id));






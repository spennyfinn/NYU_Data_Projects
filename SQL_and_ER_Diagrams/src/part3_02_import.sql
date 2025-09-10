\copy staging_caers_event_product
    (created_date, report_id, event_date, 
	product_type, product, product_code, 
	description, patient_age, age_units, 
	sex, terms, outcomes)
from '/Users/spennyfinn/Documents/GitHub/homework07-spennyfinn/data/CAERS-Quarterly-20240731-CSV-PRODUCT-BASED.csv'
(format csv, header, encoding 'LATIN1')


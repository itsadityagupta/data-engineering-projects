DROP TABLE IF EXISTS population;
CREATE TABLE population (
zipcode VARCHAR(10) PRIMARY KEY,
population INT
);

DROP TABLE IF EXISTS customer_details;
CREATE TABLE customer_details (
id SERIAL PRIMARY KEY,
gender VARCHAR(20),
age INT,
married VARCHAR(10),
no_of_dependants INT,
city VARCHAR(50),
zipcode VARCHAR(10),
tenure INT,
offer VARCHAR(10),
phone_service VARCHAR(10),
internet_service VARCHAR(20),
total_charges NUMERIC,
total_revenue NUMERIC,
customer_status VARCHAR(20),

FOREIGN KEY(zipcode) REFERENCES population(zipcode)
);

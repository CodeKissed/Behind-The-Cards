CREATE SCHEMA financial_2010;
USE financial_2010;

CREATE TABLE users (
	id INT UNSIGNED NOT NULL,
    current_age TINYINT UNSIGNED,
    retirement_age TINYINT UNSIGNED,
    birth_year YEAR,
    birth_month TINYINT UNSIGNED,
    gender VARCHAR(10),
    address VARCHAR(40),
    latitude FLOAT,
    longitude FLOAT,
    per_capita_income INT,
    yearly_income INT,
    total_debt INT,
    credit_score SMALLINT UNSIGNED,
    num_credit_cards TINYINT UNSIGNED,
    PRIMARY KEY(id)
    );

 CREATE TABLE transactions (   
	id INT UNSIGNED NOT NULL,
    `date` DATETIME,
    client_id SMALLINT UNSIGNED,
    card_id SMALLINT UNSIGNED,
    amount DECIMAL(10,2),
    use_chip VARCHAR (20),
    merchant_id MEDIUMINT UNSIGNED,
    merchant_city VARCHAR (40),
    merchant_state VARCHAR (40),
    zip VARCHAR (6),
    mcc SMALLINT UNSIGNED,
    `errors` VARCHAR (80)
    );    

CREATE TABLE cards (       
    id SMALLINT UNSIGNED NOT NULL,
    client_id SMALLINT UNSIGNED,
    card_brand VARCHAR(15),
    card_type VARCHAR(20),
    expiration_month TINYINT UNSIGNED,
	expiration_year SMALLINT UNSIGNED,
	has_chip VARCHAR(5),
	num_cards_issued TINYINT UNSIGNED,
	credit_limit DECIMAL(10,0),
	acct_open_date_month TINYINT UNSIGNED,
	acct_open_date_year SMALLINT UNSIGNED,
	year_pin_last_changed SMALLINT UNSIGNED,
	card_on_dark_web VARCHAR(5),
	PRIMARY KEY(id),
    FOREIGN KEY (client_id) REFERENCES users (id)
     );    

USE financial_2010;
CREATE TABLE mcc (       
    mcc_code INT UNSIGNED NOT NULL,
    merchant text,
    PRIMARY KEY(mcc_code)
    );
    

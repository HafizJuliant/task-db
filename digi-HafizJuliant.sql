
CREATE TABLE public.accounts (
	account_id int8 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL,
	"name" varchar NOT NULL,
	balance int8 NOT NULL,
	referral_account_id int8 NULL,
	CONSTRAINT account_id PRIMARY KEY (account_id),
	CONSTRAINT fk_referral_account FOREIGN KEY (referral_account_id) REFERENCES public.accounts(account_id)
);


CREATE TABLE public.auths (
	auths_id int8 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL,
	username varchar NOT NULL,
	"password" varchar NOT NULL,
	account_id int8 NOT NULL,
	CONSTRAINT auths_pk PRIMARY KEY (auths_id),
	CONSTRAINT auths_unique UNIQUE (username),
	CONSTRAINT auths_unique_1 UNIQUE (account_id)
);


CREATE TABLE public."transaction" (
	transaction_id bigserial NOT NULL,
	transaction_category_id int8 NULL,
	account_id int8 NOT NULL,
	from_account_id int8 NULL,
	to_account_id int8 NULL,
	amount int8 NOT NULL,
	transaction_date timestamp NOT NULL,
	CONSTRAINT transaction_pkey PRIMARY KEY (transaction_id)
);


-- public."transaction" foreign keys

ALTER TABLE public."transaction" ADD CONSTRAINT transaction_transaction_category_id_fkey FOREIGN KEY (transaction_category_id) REFERENCES public.transaction_categories(transaction_category_id);

CREATE TABLE public.transaction_categories (
	transaction_category_id serial4 NOT NULL,
	"name" varchar(255) NOT NULL,
	CONSTRAINT transaction_categories_pkey PRIMARY KEY (transaction_category_id)
);


INSERT INTO public.accounts ("name",balance,referral_account_id) VALUES
	 ('rashford',100000,1),
	 ('garnacho',200000,2),
	 ('antony',150000,3),
	 ('bruno',80000,4),
	 ('Dalot',25000,5);

INSERT INTO public.transaction_categories ("name") VALUES
	 ('Expense'),
	 ('Income');

INSERT INTO public."transaction" (transaction_category_id,account_id,from_account_id,to_account_id,amount,transaction_date) VALUES
	 (1,1,NULL,2,5000,'2024-01-15 10:00:00'),
	 (2,2,NULL,NULL,3000,'2024-02-15 11:00:00'),
	 (1,3,NULL,1,7000,'2024-03-15 12:00:00'),
	 (2,4,NULL,NULL,2500,'2024-04-15 13:00:00'),
	 (1,5,NULL,2,5500,'2024-05-15 14:00:00'),
	 (2,1,NULL,NULL,3200,'2024-06-15 15:00:00'),
	 (1,2,NULL,3,6000,'2024-07-15 16:00:00'),
	 (2,3,NULL,NULL,2800,'2024-08-15 17:00:00'),
	 (1,4,NULL,5,7500,'2024-09-15 18:00:00'),
	 (2,5,NULL,NULL,3500,'2024-10-15 19:00:00');
INSERT INTO public."transaction" (transaction_category_id,account_id,from_account_id,to_account_id,amount,transaction_date) VALUES
	 (1,1,NULL,4,8000,'2024-11-15 20:00:00'),
	 (2,2,NULL,NULL,4000,'2024-12-15 21:00:00');



UPDATE accounts
SET name = 'Dalot'
WHERE account_id = 5;

UPDATE accounts
SET balance = 25000
WHERE account_id = 5;

--List semua data accounts
SELECT * FROM accounts;

--Query 1 data accounts dengan balance terbanyak
SELECT * 
FROM accounts
ORDER BY balance DESC
LIMIT 1;


--List semua data transactions join dengan accounts (account_id = account_id) dan tampilkan nama dari accounts
SELECT 
    t.*, 
    a.name 
FROM 
    transaction t
JOIN 
    accounts a 
ON 
    t.account_id = a.account_id;

--Query semua transaction yg terjadi di bulan Mei (Bulan 5)   
SELECT *
FROM transaction
WHERE EXTRACT(MONTH FROM transaction_date) = 5; 
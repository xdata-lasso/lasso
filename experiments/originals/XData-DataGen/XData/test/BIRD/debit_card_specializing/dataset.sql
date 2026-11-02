CREATE TABLE customers (
    customerid integer NOT NULL,
    segment varchar,
    currency varchar,
    PRIMARY KEY (customerid)
);
CREATE TABLE yearmonth_new (
    yrmnt varchar,
    customerid integer,
    consumption real
);
CREATE TABLE gasstations (
    gasstationid integer NOT NULL,
    chainid integer,
    country varchar,
    segment varchar,
    PRIMARY KEY (gasstationid)
);
CREATE TABLE products (
    productid integer NOT NULL,
    description varchar,
    PRIMARY KEY (productid)
);
CREATE TABLE transactions (
    transactionid integer NOT NULL,
    txn_date date,
    txn_time time,
    customerid integer,
    cardid integer,
    gasstationid integer,
    productid integer,
    amount integer,
    price real,
    PRIMARY KEY (transactionid)
);



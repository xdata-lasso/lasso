CREATE TABLE district (
    district_id integer NOT NULL,
    a varchar,
    b varchar,
    c varchar,
    d varchar,
    e varchar,
    f varchar,
    g integer,
    h integer,
    i real,
    j integer,
    k real,
    l real,
    m integer,
    n integer,
    o integer,
    PRIMARY KEY (district_id)
);
CREATE TABLE accounts (
    account_id integer NOT NULL,
    district_id integer,
    frequency varchar,
    acc_date date,
    PRIMARY KEY (account_id),
    FOREIGN KEY (district_id) REFERENCES district (district_id)
);
CREATE TABLE client (
    client_id integer NOT NULL,
    gender varchar,
    birth_date date,
    district_id integer,
    PRIMARY KEY (client_id),
    FOREIGN KEY (district_id) REFERENCES district (district_id)
);
CREATE TABLE disp (
    disp_id integer NOT NULL,
    client_id integer,
    account_id integer,
    disp_type varchar,
    PRIMARY KEY (disp_id),
    FOREIGN KEY (account_id) REFERENCES accounts (account_id),
    FOREIGN KEY (client_id) REFERENCES client (client_id)
);
CREATE TABLE card (
    card_id integer NOT NULL,
    disp_id integer,
    card_type varchar,
    issued date,
    PRIMARY KEY (card_id),
    FOREIGN KEY (disp_id) REFERENCES disp (disp_id)
);
CREATE TABLE loans (
    loan_id integer NOT NULL,
    account_id integer,
    loan_date date,
    amount integer,
    duration integer,
    payments real,
    status varchar,
    PRIMARY KEY (loan_id),
    FOREIGN KEY (account_id) REFERENCES accounts (account_id)
);
CREATE TABLE orders (
    order_id integer NOT NULL,
    account_id integer,
    bank_to varchar,
    account_to integer,
    amount real,
    k_symbol varchar,
    PRIMARY KEY (order_id),
    FOREIGN KEY (account_id) REFERENCES accounts (account_id)
);
CREATE TABLE transacs (
    trans_id integer NOT NULL,
    account_id integer,
    trans_date date,
    trans_type varchar,
    operation varchar,
    amount integer,
    balance integer,
    k_symbol varchar,
    bank varchar,
    account integer,
    PRIMARY KEY (trans_id),
    FOREIGN KEY (account_id) REFERENCES accounts (account_id)
);
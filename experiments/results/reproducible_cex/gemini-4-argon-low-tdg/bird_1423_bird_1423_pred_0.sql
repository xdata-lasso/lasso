-- Schema DDL
CREATE TABLE event (event_id TEXT CONSTRAINT event_pk PRIMARY KEY, event_name TEXT, event_date TEXT, type TEXT, notes TEXT, location TEXT, status TEXT);

CREATE TABLE major (major_id TEXT CONSTRAINT major_pk PRIMARY KEY, major_name TEXT, department TEXT, college TEXT);

CREATE TABLE zip_code (zip_code INTEGER CONSTRAINT zip_code_pk PRIMARY KEY, type TEXT, city TEXT, county TEXT, state TEXT, short_state TEXT);

CREATE TABLE "attendance" (link_to_event TEXT, link_to_member TEXT, PRIMARY KEY (link_to_event, link_to_member), FOREIGN KEY (link_to_event) REFERENCES event (event_id), FOREIGN KEY (link_to_member) REFERENCES member (member_id));

CREATE TABLE "budget" (budget_id TEXT PRIMARY KEY, category TEXT, spent REAL, remaining REAL, amount INTEGER, event_status TEXT, link_to_event TEXT, FOREIGN KEY (link_to_event) REFERENCES event (event_id));

CREATE TABLE "expense" (expense_id TEXT PRIMARY KEY, expense_description TEXT, expense_date TEXT, cost REAL, approved TEXT, link_to_member TEXT, link_to_budget TEXT, FOREIGN KEY (link_to_budget) REFERENCES budget (budget_id), FOREIGN KEY (link_to_member) REFERENCES member (member_id));

CREATE TABLE "income" (income_id TEXT CONSTRAINT income_pk PRIMARY KEY, date_received TEXT, amount INTEGER, source TEXT, notes TEXT, link_to_member TEXT, FOREIGN KEY (link_to_member) REFERENCES member (member_id));

CREATE TABLE "member" (member_id TEXT CONSTRAINT member_pk PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, position TEXT, t_shirt_size TEXT, phone TEXT, zip INTEGER, link_to_major TEXT, FOREIGN KEY (link_to_major) REFERENCES major (major_id), FOREIGN KEY (zip) REFERENCES zip_code (zip_code));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Target: Single matching row with NULL income_id (testing COUNT(income_id) vs COUNT(*)) and duplicate values in other columns (testing COUNT(DISTINCT ...)).
INSERT INTO major (major_id, major_name, department, college) VALUES ('M1', 'Bio', 'Sci', 'Science');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (20002, 'Standard', 'DC', 'DC', 'District', 'DC');
INSERT INTO "member" (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('MEM1', 'Sam', 'Smith', 's@s.com', 'Sec', 'S', '789', 20002, 'M1');
INSERT INTO "income" (income_id, date_received, amount, source, notes, link_to_member) VALUES (NULL, '2023-02-01', 50, 'Dues', 'SameNote', 'MEM1');
INSERT INTO "income" (income_id, date_received, amount, source, notes, link_to_member) VALUES ('50', '2023-02-01', 50, 'Dues', 'SameNote', 'MEM1');
INSERT INTO "income" (income_id, date_received, amount, source, notes, link_to_member) VALUES ('INC_OTHER', '2023-02-01', 25, '50', '50', 'MEM1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(income_id) FROM income WHERE amount = 50;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM income WHERE amount = 50;

/*
Prediction Result:
(2,)
*/
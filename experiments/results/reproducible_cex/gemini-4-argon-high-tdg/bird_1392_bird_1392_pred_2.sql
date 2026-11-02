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
-- DATASET 1
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (10001, 'Standard', 'New York', 'New York', 'New York', 'NY');
INSERT INTO major (major_id, major_name, department, college) VALUES ('maj1', 'Computer Science', 'CS', 'Engineering');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('mem1', 'Alice', 'Smith', 'alice@example.com', 'Treasurer', 'M', '555-0101', 10001, 'maj1');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('inc1', '2019-09-15', 50, 'Sponsorship', 'Note 1', 'mem1');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('inc2', '2019-09-25', 500, 'Fundraising', 'Note 2', 'mem1');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('inc3', '2019-09-20', 500, 'Fundraising', 'Note 3', 'mem1');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('inc4', '2019-09-05', 5000, 'Dues', 'Note 4', 'mem1');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('inc5', '2019-08-15', 9000, 'Z_Grant_Aug', 'Note 5', 'mem1');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('inc6', '2019-10-15', 9000, 'Z_Grant_Oct', 'Note 6', 'mem1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT source FROM income WHERE date_received BETWEEN '2019-09-01' AND '2019-09-30' ORDER BY source DESC, income.income_id NULLS LAST LIMIT 1;

/*
Gold Result:
('Sponsorship',)
*/

-- Prediction Query
SELECT source FROM income WHERE date_received LIKE '2019-09%' ORDER BY amount DESC, income.income_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Dues',)
*/
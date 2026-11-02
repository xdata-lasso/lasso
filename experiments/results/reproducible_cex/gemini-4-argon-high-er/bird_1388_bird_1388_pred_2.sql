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
INSERT INTO major (major_id, major_name, department, college) VALUES ('MAJ1', 'CS', 'Eng', 'Tech');
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (12345, 'Standard', 'City', 'County', 'State', 'ST');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M1', 'John', 'Doe', 'john@example.com', 'Member', 'L', '111-222-3333', 12345, 'MAJ1');
INSERT INTO member (member_id, first_name, last_name, email, position, t_shirt_size, phone, zip, link_to_major) VALUES ('M2', 'Jane', 'Smith', 'jane@example.com', 'Member', 'M', '444-555-6666', 12345, 'MAJ1');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('I1', '2023-01-01', 100, 'Dues', 'None', 'M1');
INSERT INTO income (income_id, date_received, amount, source, notes, link_to_member) VALUES ('I2', '2023-01-02', 50, 'Fundraising', 'None', 'M2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name, T2.source FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member GROUP BY T1.first_name, T1.last_name, T2.source ORDER BY SUM(T2.amount) DESC, T1.first_name NULLS LAST, T1.last_name NULLS LAST, T2.source NULLS LAST LIMIT 1;

/*
Gold Result:
('John', 'Doe', 'Dues')
*/

-- Prediction Query
SELECT "member"."first_name", "member"."last_name", "income"."source" FROM "member" INNER JOIN "income" ON "member"."member_id" = "income"."link_to_member" WHERE "income"."amount" = (SELECT MAX("amount") FROM "income" WHERE "income"."link_to_member" = "member"."member_id");

/*
Prediction Result:
('John', 'Doe', 'Dues')
('Jane', 'Smith', 'Fundraising')
*/
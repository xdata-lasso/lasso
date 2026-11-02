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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (0, 'default2', 'Finance', 'default2', 'Physics', NULL), (2, 'default2', 'Physics', 'Finance', 'default2', 'default1'), (-1, NULL, 'Finance', NULL, 'default2', 'Finance');
INSERT INTO major (major_id, major_name, department, college) VALUES ('default2', 'default2', 'default2', 'Finance'), ('Finance', 'Finance', 'Physics', 'Finance'), ('Physics', 'Finance', 'default1', 'Physics'), ('default1', 'Physics', 'Physics', 'default2');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('Physics', 'default1', -1, 'default1', 'default2', 'default2', 'Physics', 'default1', 'default1'), ('Finance', NULL, NULL, 'default2', 'default1', 'Physics', 'default2', 'default2', 'default1'), ('default2', 'default1', NULL, NULL, 'Finance', NULL, NULL, NULL, 'default1'), ('default1', 'Physics', NULL, 'Finance', NULL, 'default1', NULL, 'Finance', 'Physics'), ('unique_4', 'default1', 0, NULL, 'default2', 'default2', 'Finance', 'Physics', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(CASE WHEN major_name = 'Finance' THEN 1 ELSE 0 END) / SUM(CASE WHEN major_name = 'Physics' THEN 1 ELSE 0 END) AS ratio FROM major;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT CAST(SUM(major_name = 'Finance') AS REAL) / SUM(major_name = 'Physics') AS ratio FROM major INNER JOIN member ON major.major_id = member.link_to_major;

/*
Prediction Result:
(0.3333333333333333,)
*/
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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (-1, 'Maine', 'default2', 'New Jersey', 'default1', 'New Jersey'), (101, NULL, 'Maine', 'New Jersey', 'New Jersey', NULL), (2, 'Member', NULL, 'New Jersey', 'Maine', 'default1'), (1, NULL, 'Member', 'Vermont', 'Maine', 'Member'), (0, 'default2', 'Vermont', 'New Jersey', 'New Jersey', 'Vermont'), (100, 'default2', 'Member', 'Member', 'default2', 'Maine');
INSERT INTO major (major_id, major_name, department, college) VALUES ('New Jersey', 'default2', 'default1', 'New Jersey'), ('Vermont', 'default1', 'Member', 'New Jersey'), ('Maine', 'New Jersey', 'New Jersey', 'Member');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('Maine', NULL, 1, 'Vermont', NULL, 'Member', 'New Jersey', 'Maine', 'Maine'), ('New Jersey', 'Maine', NULL, 'Member', 'New Jersey', 'default1', NULL, 'Vermont', 'default1'), ('default1', 'New Jersey', 0, 'default1', 'default1', 'Member', 'Vermont', 'Maine', 'Member'), ('Vermont', 'Vermont', -1, 'default2', 'default2', NULL, NULL, 'Maine', 'New Jersey'), ('Member', 'Vermont', 100, NULL, 'default2', 'default2', 'default1', NULL, 'default1'), ('default2', 'New Jersey', NULL, 'Vermont', 'default1', 'Member', 'default1', 'default1', 'default2'), ('unique_6', NULL, 2, 'default2', NULL, 'default1', 'default2', 'default1', 'Member');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SUM(CASE WHEN T2.state = 'Maine' THEN 1 ELSE 0 END) - SUM(CASE WHEN T2.state = 'Vermont' THEN 1 ELSE 0 END)) AS REAL) * 100 / COUNT(T1.member_id) AS diff FROM member AS T1 INNER JOIN zip_code AS T2 ON T2.zip_code = T1.zip;

/*
Gold Result:
(40.0,)
*/

-- Prediction Query
SELECT (SUM(CASE WHEN z.state = 'New Jersey' THEN 1 ELSE 0 END) * 1.0 / COUNT(m.member_id)) - (SUM(CASE WHEN z.state = 'Vermont' THEN 1 ELSE 0 END) * 1.0 / COUNT(m.member_id)) AS percentage_difference FROM member AS m JOIN zip_code AS z ON m.zip = z.zip_code WHERE m.position = 'Member';

/*
Prediction Result:
(None,)
*/
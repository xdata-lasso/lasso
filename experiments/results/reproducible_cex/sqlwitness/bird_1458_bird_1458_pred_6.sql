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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (0, 'default1', 'Vermont', 'Vermont', 'Vermont', 'default2'), (1, 'default2', NULL, NULL, 'default2', 'Maine'), (-1, 'Vermont', 'New Jersey', NULL, 'Vermont', 'New Jersey');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('Maine', NULL, NULL, 'New Jersey', 'default2', NULL, 'New Jersey', 'Maine', 'Vermont'), ('default1', NULL, NULL, 'New Jersey', NULL, 'Vermont', 'Maine', 'Vermont', NULL), ('New Jersey', NULL, -1, 'default1', 'New Jersey', 'New Jersey', 'default1', 'default2', 'Maine'), ('default2', NULL, 1, NULL, 'Vermont', 'Maine', 'default1', 'Vermont', 'default1'), ('Vermont', NULL, -1, 'New Jersey', NULL, 'Vermont', 'default2', 'New Jersey', 'Vermont'), ('unique_5', NULL, 0, NULL, 'New Jersey', 'New Jersey', NULL, 'Vermont', 'New Jersey');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SUM(CASE WHEN T2.state = 'Maine' THEN 1 ELSE 0 END) - SUM(CASE WHEN T2.state = 'Vermont' THEN 1 ELSE 0 END)) AS REAL) * 100 / COUNT(T1.member_id) AS diff FROM member AS T1 INNER JOIN zip_code AS T2 ON T2.zip_code = T1.zip;

/*
Gold Result:
(-75.0,)
*/

-- Prediction Query
SELECT (SUM(CASE WHEN z.state = 'New Jersey' THEN 1 ELSE 0 END) * 100.0) / (COUNT(*) * 1.0) - (SUM(CASE WHEN z.state = 'Vermont' THEN 1 ELSE 0 END) * 100.0) FROM member AS m INNER JOIN zip_code AS z ON m.zip = z.zip_code;

/*
Prediction Result:
(-300.0,)
*/
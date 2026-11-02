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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (49, 'default2', 'default1', 'default1', 'default1', 'default2'), (1, NULL, 'default1', NULL, NULL, 'default1');
INSERT INTO major (major_id, major_name, department, college) VALUES ('default2', 'default1', 'default2', 'default1'), ('default1', 'default1', 'default1', NULL), ('unique_2', 'default1', 'default1', 'default1'), ('unique_3', NULL, 'default1', NULL), ('unique_4', NULL, 'default1', 'default1'), ('unique_5', 'default1', 'default2', NULL), ('unique_6', 'default1', 'default2', 'default1');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default1', 'unique_5', 1, 'default1', 'default1', NULL, 'default2', 'default2', 'default1'), ('default2', 'unique_5', 1, 'default2', NULL, NULL, 'default1', 'default2', 'default1'), ('unique_2', NULL, 1, 'default1', 'default1', 'default2', 'default2', 'default2', NULL), ('unique_3', 'unique_6', NULL, 'default1', 'default1', 'default1', 'default2', 'default2', 'default1'), ('unique_4', 'default1', 1, 'default1', NULL, NULL, 'default2', 'default2', 'default1'), ('unique_5', 'unique_5', NULL, 'default2', 'default2', 'default1', NULL, NULL, 'default2'), ('unique_6', 'unique_3', 49, 'default1', 'default1', NULL, 'default2', 'default2', 'default2');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default2', 'default1', 'default2', 'default2', 'default1', 'default2', 'default1'), ('default1', 'default1', 'default1', 'default1', 'default1', 'default2', 'default2'), ('unique_2', NULL, 'default1', 'default1', NULL, 'default1', 'default1'), ('unique_3', 'default1', 'default1', 'default2', 'default2', NULL, NULL), ('unique_4', NULL, 'default2', 'default1', NULL, NULL, NULL), ('unique_5', 'default1', 'default2', 'default2', NULL, 'default2', 'default2'), ('unique_6', 'default2', 'default1', NULL, 'default1', 'default2', 'default2');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('default2', 'unique_3', 'default2', NULL, 50.0, NULL, 'default2'), ('default1', 'unique_4', 'default1', 1.0, 49.0, 1, 'default1');
INSERT INTO expense (expense_id, link_to_budget, link_to_member, expense_description, expense_date, cost, approved) VALUES ('default2', 'default2', 'unique_2', NULL, NULL, 51.0, 'default2'), ('default1', 'default2', 'unique_5', 'default2', 'default1', 49.0, 'default2'), ('unique_2', NULL, NULL, NULL, 'default2', 51.0, 'default1'), ('unique_3', 'default2', 'unique_3', 'default1', 'default1', 0.0, 'default1'), ('unique_4', 'default2', 'unique_3', 'default2', 'default2', 49.0, 'default1'), ('unique_5', 'default2', 'unique_6', 'default1', 'default2', 51.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.zip FROM member AS T1 INNER JOIN expense AS T2 ON T1.member_id = T2.link_to_member WHERE T2.cost < 50;

/*
Gold Result:
(None,)
(None,)
(None,)
*/

-- Prediction Query
SELECT DISTINCT m.zip FROM member AS m JOIN expense AS e ON m.member_id = e.link_to_member WHERE e.cost < 50;

/*
Prediction Result:
(None,)
*/
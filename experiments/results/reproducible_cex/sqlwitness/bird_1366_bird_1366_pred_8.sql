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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1, NULL, 'default1', NULL, 'default1', 'default1'), (0, 'default2', 'October Meeting', 'default2', 'October Meeting', NULL), (2, 'default2', 'default2', NULL, 'default2', NULL), (3, 'October Meeting', NULL, 'default1', 'default2', 'default1'), (4, 'October Meeting', 'default2', 'default1', 'October Meeting', 'October Meeting'), (5, 'default1', 'default2', NULL, 'October Meeting', 'default2'), (6, NULL, 'default1', 'default1', 'default2', 'default1');
INSERT INTO major (major_id, major_name, department, college) VALUES ('October Meeting', 'default2', NULL, NULL), ('default1', 'default2', NULL, 'October Meeting'), ('default2', 'default1', NULL, 'default1'), ('unique_3', 'default1', 'default2', 'October Meeting'), ('unique_4', 'default2', 'default2', 'default2'), ('unique_5', 'default2', 'default2', NULL);
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default1', NULL, 6, 'October Meeting', NULL, 'default2', 'default1', NULL, 'default1'), ('default2', 'default1', 5, NULL, NULL, 'default2', NULL, 'October Meeting', 'default1'), ('October Meeting', 'unique_4', 6, 'default2', 'default2', 'default1', 'default1', 'default1', 'default2'), ('unique_3', 'default1', 6, 'default2', NULL, 'October Meeting', 'default1', NULL, 'default2'), ('unique_4', 'unique_4', NULL, 'default1', 'default2', 'default1', 'October Meeting', 'October Meeting', 'October Meeting');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default1', 'October Meeting', 'October Meeting', 'default1', 'default1', 'default2', 'October Meeting'), ('October Meeting', 'October Meeting', 'default2', NULL, 'default1', 'default2', NULL), ('default2', 'October Meeting', 'default1', 'default1', 'default2', 'default2', 'October Meeting'), ('unique_3', 'default2', 'October Meeting', NULL, 'October Meeting', 'default1', 'default1'), ('unique_4', 'October Meeting', 'default2', 'default1', 'October Meeting', 'October Meeting', 'October Meeting');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('default1', 'unique_3'), ('unique_3', 'default2'), ('unique_3', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.member_id FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event INNER JOIN member AS T3 ON T2.link_to_member = T3.member_id WHERE T1.event_name = 'October Meeting';

/*
Gold Result:
('unique_3',)
*/

-- Prediction Query
SELECT T3.first_name, T3.last_name FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event INNER JOIN member AS T3 ON T2.link_to_member = T3.member_id WHERE T1.event_name = 'October Meeting';

/*
Prediction Result:
('default2', None)
*/
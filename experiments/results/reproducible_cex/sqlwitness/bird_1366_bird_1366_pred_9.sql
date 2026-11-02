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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (0, NULL, 'default2', NULL, NULL, 'default2');
INSERT INTO major (major_id, major_name, department, college) VALUES ('default2', NULL, 'October Meeting', NULL), ('default1', NULL, 'default1', 'default1'), ('October Meeting', 'default2', 'October Meeting', 'default1'), ('unique_3', 'default1', 'October Meeting', 'default2'), ('unique_4', NULL, 'October Meeting', 'October Meeting'), ('unique_5', 'default1', 'October Meeting', 'default2'), ('unique_6', 'default1', 'default1', 'default1');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('October Meeting', 'unique_6', 0, 'October Meeting', 'October Meeting', 'default2', 'October Meeting', 'default1', 'October Meeting'), ('default1', 'unique_6', NULL, 'default1', 'default2', 'default2', 'default2', NULL, 'default1'), ('default2', 'unique_4', 0, 'default1', 'October Meeting', 'default1', 'default1', 'default1', 'default2'), ('unique_3', 'default1', NULL, NULL, 'default1', 'default2', 'October Meeting', NULL, NULL), ('unique_4', 'unique_4', 0, 'October Meeting', NULL, 'default2', NULL, 'October Meeting', 'default2'), ('unique_5', 'October Meeting', 0, 'default2', 'default1', NULL, NULL, 'default1', 'default1'), ('unique_6', 'default1', NULL, 'October Meeting', 'default1', 'default2', 'October Meeting', NULL, 'default1'), ('unique_7', 'unique_5', 0, 'default2', 'default2', 'default2', 'default2', NULL, 'October Meeting'), ('unique_8', 'unique_6', NULL, 'default1', 'default1', 'default1', NULL, 'October Meeting', 'default2');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('October Meeting', 'October Meeting', 'default2', 'default1', 'default2', 'default1', 'default2'), ('default1', 'October Meeting', 'October Meeting', NULL, NULL, 'default2', 'October Meeting'), ('default2', 'default2', 'October Meeting', NULL, 'October Meeting', 'default1', NULL), ('unique_3', NULL, 'default2', 'default1', 'default2', 'default2', 'default1'), ('unique_4', NULL, 'default2', 'default1', 'default2', 'default1', 'default1'), ('unique_5', 'October Meeting', 'October Meeting', 'default1', 'October Meeting', 'October Meeting', 'default2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('default1', 'unique_7'), ('default1', 'unique_8'), ('default1', 'default1'), ('October Meeting', 'unique_7'), ('unique_4', 'October Meeting');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.member_id FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event INNER JOIN member AS T3 ON T2.link_to_member = T3.member_id WHERE T1.event_name = 'October Meeting';

/*
Gold Result:
('unique_7',)
('unique_8',)
('default1',)
*/

-- Prediction Query
SELECT m.first_name, m.last_name FROM member AS m JOIN attendance AS a ON m.member_id = a.link_to_member JOIN event AS e ON a.link_to_event = e.event_id WHERE e.event_name = 'October Meeting';

/*
Prediction Result:
('default2', 'default2')
('default1', 'default1')
('default1', 'default2')
('default2', 'default2')
*/
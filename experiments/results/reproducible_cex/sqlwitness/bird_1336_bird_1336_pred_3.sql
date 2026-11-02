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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (0, 'default1', 'Guidi', 'Pierce', 'default1', 'default1');
INSERT INTO major (major_id, major_name, department, college) VALUES ('Pierce', 'default2', 'Pierce', 'default1'), ('default1', 'Guidi', 'Guidi', 'default2'), ('Guidi', 'default2', NULL, 'default2'), ('default2', 'Pierce', 'default2', 'Pierce'), ('unique_4', NULL, 'default1', 'Pierce'), ('unique_5', 'default2', 'default1', NULL);
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('Pierce', 'default1', 0, 'Pierce', 'Guidi', NULL, 'Guidi', 'default2', 'default2'), ('default2', NULL, 0, 'Pierce', 'Pierce', 'default2', NULL, NULL, NULL), ('default1', 'unique_4', 0, 'default1', 'Guidi', 'Pierce', 'Pierce', 'Pierce', 'default1'), ('Guidi', 'Guidi', NULL, 'Guidi', 'default2', 'default2', 'Guidi', NULL, 'Pierce'), ('unique_4', 'Pierce', NULL, 'default2', 'Guidi', NULL, NULL, 'Guidi', 'Guidi'), ('unique_5', 'Guidi', 0, 'Guidi', 'default2', NULL, 'default1', NULL, 'default1'), ('unique_6', 'unique_5', NULL, 'Pierce', NULL, 'default2', 'default2', NULL, 'default1'), ('unique_7', 'unique_4', NULL, 'Guidi', 'Guidi', 'default2', 'default1', 'default1', 'Pierce'), ('unique_8', NULL, 0, 'default1', NULL, NULL, NULL, 'Pierce', 'Guidi');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.department FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T1.last_name = 'Pierce' OR T1.last_name = 'Guidi';

/*
Gold Result:
('Guidi',)
('default1',)
('Pierce',)
('default1',)
*/

-- Prediction Query
SELECT DISTINCT m1.department FROM major AS m1 JOIN member AS mem1 ON m1.major_id = mem1.link_to_major WHERE mem1.last_name IN ('Pierce', 'Guidi');

/*
Prediction Result:
('Guidi',)
('default1',)
('Pierce',)
*/
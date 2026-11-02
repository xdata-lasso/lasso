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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1, 'default1', NULL, '2019-09-09', 'default1', 'default2'), (0, NULL, 'default1', 'default2', '2019-09-09', NULL), (2, 'default1', '2019-09-09', '2019-09-09', 'default2', 'default2'), (3, '2019-09-09', NULL, 'default2', '2019-09-09', NULL), (4, NULL, 'default1', '2019-09-09', 'default2', 'default2');
INSERT INTO major (major_id, major_name, department, college) VALUES ('default1', 'default2', '2019-09-09', 'default1'), ('2019-09-09', NULL, 'default2', '2019-09-09');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default2', '2019-09-09', 0, 'default1', NULL, 'default1', NULL, 'default1', 'default1'), ('2019-09-09', '2019-09-09', NULL, '2019-09-09', 'default2', '2019-09-09', 'default1', '2019-09-09', 'default2'), ('default1', 'default1', 2, 'default2', 'default1', 'default2', NULL, '2019-09-09', NULL), ('unique_3', NULL, 4, 'default2', NULL, 'default1', '2019-09-09', '2019-09-09', 'default2');
INSERT INTO income (income_id, link_to_member, date_received, amount, source, notes) VALUES ('default2', 'default2', '2019-09-09', 1, '2019-09-09', 'default2'), ('default1', 'default1', NULL, NULL, 'default2', 'default1'), ('2019-09-09', NULL, NULL, 1, '2019-09-09', '2019-09-09'), ('unique_3', '2019-09-09', '2019-09-09', 1, 'default1', '2019-09-09');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default2', 'default1', 'default2', '2019-09-09', NULL, 'default2', 'default1'), ('2019-09-09', '2019-09-09', '2019-09-09', 'default1', 'default2', '2019-09-09', NULL), ('default1', '2019-09-09', '2019-09-09', 'default1', 'default2', NULL, NULL), ('unique_3', 'default1', '2019-09-09', 'default1', 'default1', NULL, NULL);
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('unique_3', 'unique_3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.first_name, T3.last_name, T4.amount FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event INNER JOIN member AS T3 ON T3.member_id = T2.link_to_member INNER JOIN income AS T4 ON T4.link_to_member = T3.member_id WHERE T4.date_received = '2019-09-09';

/*
Gold Result:
*/

-- Prediction Query
SELECT member.first_name, member.last_name, income.amount FROM income INNER JOIN member ON income.link_to_member = member.member_id WHERE income.date_received = '2019-09-09';

/*
Prediction Result:
('default1', None, 1)
('2019-09-09', 'default2', 1)
*/
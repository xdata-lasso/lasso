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
INSERT INTO major (major_id, major_name, department, college) VALUES ('default1', 'default1', 'default2', 'X-Large'), ('X-Large', 'X-Large', NULL, NULL), ('default2', 'default2', 'default1', 'default2'), ('unique_3', NULL, NULL, 'default1'), ('unique_4', NULL, NULL, 'default2'), ('unique_5', 'default2', NULL, 'default1');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default2', NULL, NULL, NULL, NULL, NULL, 'default1', 'default2', 'X-Large'), ('default1', 'unique_5', NULL, 'default2', NULL, NULL, NULL, 'X-Large', NULL), ('X-Large', 'default1', NULL, 'default2', 'X-Large', NULL, 'default1', 'X-Large', NULL);
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default2', 'default1', 'default1', NULL, 'X-Large', 'default1', 'default2');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('X-Large', NULL, 'default1', 1.0, 1.0, 0, NULL), ('default1', 'default2', NULL, 1.0, 0.0, NULL, NULL), ('default2', NULL, 'default2', NULL, NULL, 1, 'X-Large'), ('unique_3', 'default2', NULL, NULL, NULL, NULL, NULL), ('unique_4', 'default2', 'X-Large', 0.0, 1.0, NULL, 'default1'), ('unique_5', 'default2', 'default1', NULL, 1.0, 0, 'default2');
INSERT INTO expense (expense_id, link_to_budget, link_to_member, expense_description, expense_date, cost, approved) VALUES ('default1', 'X-Large', 'X-Large', 'default1', 'default2', 0.0, NULL), ('X-Large', 'X-Large', NULL, 'X-Large', NULL, 0.0, 'default1'), ('default2', NULL, 'X-Large', 'default1', 'X-Large', 0.0, 'default2'), ('unique_3', 'X-Large', 'default2', NULL, 'default1', 1.0, 'X-Large'), ('unique_4', 'unique_5', 'X-Large', 'default1', 'default2', 1.0, 'default1'), ('unique_5', 'X-Large', NULL, 'default2', 'X-Large', NULL, 'default1'), ('unique_6', 'X-Large', 'X-Large', 'X-Large', 'X-Large', 1.0, 'default2'), ('unique_7', 'unique_5', 'default1', NULL, 'default1', 0.0, NULL), ('unique_8', 'unique_5', 'default2', 'default1', 'X-Large', NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.expense_description FROM member AS T1 INNER JOIN expense AS T2 ON T1.member_id = T2.link_to_member WHERE T1.t_shirt_size = 'X-Large';

/*
Gold Result:
('default1',)
('default1',)
('default1',)
('X-Large',)
(None,)
*/

-- Prediction Query
SELECT DISTINCT expense.expense_description FROM expense INNER JOIN member ON expense.link_to_member = member.member_id WHERE member.t_shirt_size = 'X-Large';

/*
Prediction Result:
('default1',)
('X-Large',)
(None,)
*/
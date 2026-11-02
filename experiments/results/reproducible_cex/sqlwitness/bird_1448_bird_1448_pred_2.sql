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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (0, 'default2', 'default2', 'default2', 'default1', 'default1'), (51, 'default2', NULL, NULL, 'Pizza', 'default1'), (1, NULL, 'default1', 'default2', 'default1', 'default2'), (100, NULL, 'default2', 'Pizza', 'default1', 'default2'), (101, 'default2', NULL, 'Pizza', NULL, 'default1'), (50, 'default1', NULL, NULL, 'default2', 'default2'), (99, 'default1', 'default2', 'default1', 'default1', NULL), (49, 'default1', NULL, 'Pizza', NULL, 'default1'), (2, NULL, 'Pizza', NULL, 'Pizza', 'default1'), (3, 'default1', NULL, NULL, 'Pizza', 'default2'), (4, NULL, 'default1', 'Pizza', 'Pizza', 'Pizza'), (5, 'Pizza', 'Pizza', 'Pizza', 'Pizza', 'default2'), (6, 'default1', 'default2', 'default1', 'default2', NULL), (7, 'default1', NULL, 'default1', 'Pizza', 'default2'), (8, 'Pizza', 'default2', NULL, NULL, NULL), (9, 'default1', 'default2', 'Pizza', 'default1', NULL), (10, NULL, 'default2', 'default2', 'default1', 'Pizza'), (11, NULL, 'default1', 'default1', 'default1', 'default2'), (12, 'Pizza', 'default2', 'default2', NULL, 'Pizza'), (13, 'default1', 'Pizza', 'Pizza', 'Pizza', 'Pizza');
INSERT INTO major (major_id, major_name, department, college) VALUES ('default1', NULL, NULL, 'Pizza'), ('Pizza', 'default2', NULL, 'Pizza'), ('default2', 'default2', 'default2', 'default2'), ('unique_3', NULL, 'Pizza', NULL), ('unique_4', 'default2', 'Pizza', 'default1'), ('unique_5', NULL, 'default1', 'Pizza'), ('unique_6', NULL, 'default1', 'Pizza');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('Pizza', 'default2', 9, 'default1', NULL, NULL, 'Pizza', 'Pizza', 'default2'), ('default2', 'default2', 9, 'Pizza', 'default2', 'Pizza', 'default1', 'default2', 'Pizza'), ('default1', 'unique_4', 10, NULL, 'default2', 'default1', 'Pizza', 'Pizza', NULL);
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default1', 'default1', 'Pizza', NULL, 'default1', 'default2', 'Pizza'), ('default2', NULL, 'Pizza', NULL, 'Pizza', 'Pizza', NULL), ('Pizza', 'default2', 'default1', 'Pizza', NULL, NULL, 'Pizza'), ('unique_3', 'default1', 'default2', NULL, 'default2', 'default2', 'Pizza'), ('unique_4', 'default2', 'Pizza', 'default2', NULL, 'default1', 'default2');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('Pizza', 'default2', 'Pizza', 0.0, 1.0, 100, NULL), ('default2', NULL, 'default1', 100.0, 1.0, 51, 'default2'), ('default1', 'unique_4', 'default2', 50.0, 99.0, 0, 'default2'), ('unique_3', NULL, 'default1', 51.0, NULL, 50, 'default2');
INSERT INTO expense (expense_id, link_to_budget, link_to_member, expense_description, expense_date, cost, approved) VALUES ('default1', 'Pizza', NULL, 'Pizza', 'default1', 0.0, NULL), ('default2', 'Pizza', 'default2', 'default1', 'default1', 99.0, 'default2'), ('Pizza', NULL, NULL, 'default1', NULL, NULL, 'default1'), ('unique_3', 'Pizza', 'default1', NULL, 'Pizza', NULL, 'default2'), ('unique_4', 'default2', 'Pizza', 'Pizza', 'Pizza', 99.0, 'default1'), ('unique_5', NULL, 'default2', 'default1', NULL, 100.0, 'default2'), ('unique_6', 'default2', 'default1', NULL, NULL, 0.0, 'Pizza'), ('unique_7', 'Pizza', 'default2', NULL, NULL, 101.0, 'default2'), ('unique_8', 'default2', NULL, 'Pizza', NULL, 100.0, 'default2'), ('unique_9', 'default1', 'Pizza', 'Pizza', 'default1', 50.0, 'default1'), ('unique_10', 'default1', NULL, 'default2', 'default1', 99.0, 'Pizza');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name, T1.event_date FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T3.expense_description = 'Pizza' AND T3.cost > 50 AND T3.cost < 100;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.event_name, T1.event_date FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T3.expense_description = 'Pizza' AND T3.cost BETWEEN 50 AND 100;

/*
Prediction Result:
('default2', 'Pizza')
*/
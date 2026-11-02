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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1, 'Yearly Kickoff', 'default2', 'Yearly Kickoff', 'default2', NULL), (0, 'Yearly Kickoff', 'Yearly Kickoff', 'default1', 'Yearly Kickoff', NULL), (2, 'default1', 'default1', 'default2', 'default2', 'default2'), (3, 'default2', 'default2', 'default2', 'default1', NULL), (4, 'default1', 'default1', NULL, NULL, NULL), (5, 'default1', 'default1', NULL, 'default2', 'Yearly Kickoff');
INSERT INTO major (major_id, major_name, department, college) VALUES ('default1', 'default1', 'default2', 'Yearly Kickoff'), ('Yearly Kickoff', NULL, NULL, 'Yearly Kickoff');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('Yearly Kickoff', 'default1', 4, 'default1', NULL, 'default2', 'default2', 'default1', 'default2'), ('default1', 'Yearly Kickoff', NULL, 'default2', NULL, 'default1', 'Yearly Kickoff', NULL, 'default1'), ('default2', 'default1', 3, 'default2', 'default2', 'default1', 'default2', 'default1', 'default1'), ('unique_3', NULL, 2, 'default1', NULL, NULL, 'default1', 'Yearly Kickoff', NULL), ('unique_4', 'Yearly Kickoff', 4, NULL, 'Yearly Kickoff', 'default2', 'Yearly Kickoff', 'default2', 'default2'), ('unique_5', 'Yearly Kickoff', 0, 'default1', 'default2', 'default1', 'Yearly Kickoff', 'default2', 'Yearly Kickoff'), ('unique_6', NULL, 0, 'default1', 'Yearly Kickoff', 'default1', NULL, NULL, 'Yearly Kickoff'), ('unique_7', 'Yearly Kickoff', NULL, 'default1', 'default1', 'default1', 'default1', NULL, 'default2'), ('unique_8', NULL, 5, NULL, 'default2', 'default1', NULL, NULL, 'Yearly Kickoff'), ('unique_9', 'Yearly Kickoff', 0, 'default2', NULL, 'default2', 'default2', 'default2', 'default2'), ('unique_10', 'default1', 4, 'default1', 'default1', 'default2', 'default1', NULL, 'default2'), ('unique_11', 'default1', NULL, 'default2', NULL, 'default1', 'Yearly Kickoff', 'default1', 'default1'), ('unique_12', NULL, 0, 'Yearly Kickoff', 'default2', NULL, 'default2', NULL, 'Yearly Kickoff'), ('unique_13', NULL, 3, NULL, 'default2', NULL, 'Yearly Kickoff', NULL, 'default1'), ('unique_14', 'Yearly Kickoff', 0, 'Yearly Kickoff', 'default1', NULL, 'default2', NULL, 'default1'), ('unique_15', 'default1', 2, 'Yearly Kickoff', 'default1', 'default2', NULL, 'default2', NULL), ('unique_16', 'default1', 5, NULL, 'default1', 'Yearly Kickoff', 'default1', 'Yearly Kickoff', 'default2'), ('unique_17', NULL, 1, 'Yearly Kickoff', 'Yearly Kickoff', 'default2', 'Yearly Kickoff', 'default1', 'Yearly Kickoff');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default2', NULL, 'Yearly Kickoff', 'default1', 'Yearly Kickoff', 'default2', 'default2'), ('default1', 'default2', 'Yearly Kickoff', 'default1', NULL, 'Yearly Kickoff', 'default1'), ('Yearly Kickoff', NULL, NULL, 'default2', 'default1', NULL, 'default2'), ('unique_3', 'default1', NULL, 'Yearly Kickoff', NULL, 'default2', 'default2'), ('unique_4', 'default2', 'Yearly Kickoff', 'default1', 'Yearly Kickoff', 'default1', 'Yearly Kickoff'), ('unique_5', 'Yearly Kickoff', 'default2', 'default1', 'default2', 'default2', 'default2'), ('unique_6', 'default2', 'Yearly Kickoff', 'default1', NULL, 'default1', 'Yearly Kickoff'), ('unique_7', 'Yearly Kickoff', 'default2', 'default1', NULL, 'Yearly Kickoff', 'default2'), ('unique_8', 'Yearly Kickoff', NULL, NULL, 'default1', NULL, 'default1'), ('unique_9', 'default1', 'default1', NULL, 'default2', NULL, 'default1'), ('unique_10', 'default2', NULL, 'default1', 'default1', 'default2', 'default1'), ('unique_11', 'default2', 'default2', 'Yearly Kickoff', 'default2', 'Yearly Kickoff', 'default2'), ('unique_12', 'Yearly Kickoff', 'Yearly Kickoff', 'default2', 'Yearly Kickoff', 'default2', 'default2'), ('unique_13', 'Yearly Kickoff', 'Yearly Kickoff', 'default1', 'Yearly Kickoff', 'default1', 'Yearly Kickoff');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('default2', 'Yearly Kickoff', 'Yearly Kickoff', 0.0, 1.0, NULL, 'default1'), ('Yearly Kickoff', 'unique_9', 'default1', 0.0, 0.0, 0, NULL), ('default1', 'unique_13', 'default2', NULL, 1.0, 1, 'default1'), ('unique_3', 'Yearly Kickoff', 'default2', NULL, 1.0, 0, NULL), ('unique_4', 'unique_9', 'default2', 0.0, 1.0, NULL, 'default2'), ('unique_5', 'unique_12', 'Yearly Kickoff', 1.0, NULL, NULL, 'default1'), ('unique_6', 'unique_6', 'default1', NULL, 1.0, NULL, 'default2'), ('unique_7', 'unique_11', NULL, 1.0, 0.0, NULL, 'default2'), ('unique_8', 'unique_7', NULL, NULL, NULL, 0, 'default1'), ('unique_9', 'unique_8', 'Yearly Kickoff', 0.0, NULL, 0, NULL), ('unique_10', 'unique_12', 'default2', 1.0, 1.0, NULL, 'Yearly Kickoff'), ('unique_11', 'unique_4', NULL, NULL, 0.0, 1, 'default1'), ('unique_12', 'Yearly Kickoff', 'Yearly Kickoff', NULL, 0.0, 0, 'default1'), ('unique_13', 'unique_8', NULL, 1.0, NULL, 0, NULL), ('unique_14', 'Yearly Kickoff', 'default2', NULL, 0.0, NULL, 'Yearly Kickoff'), ('unique_15', 'unique_7', 'default1', NULL, NULL, 1, NULL);
INSERT INTO expense (expense_id, link_to_budget, link_to_member, expense_description, expense_date, cost, approved) VALUES ('default1', NULL, 'default1', 'Yearly Kickoff', 'default2', NULL, NULL), ('Yearly Kickoff', 'unique_13', 'unique_8', NULL, NULL, 1.0, 'default1'), ('default2', 'unique_3', NULL, NULL, NULL, NULL, 'default1'), ('unique_3', 'unique_8', 'unique_3', 'default2', 'Yearly Kickoff', NULL, 'Yearly Kickoff'), ('unique_4', NULL, 'unique_12', NULL, 'default2', 0.0, 'default2'), ('unique_5', 'default2', 'default1', 'default2', 'default2', 1.0, 'default2'), ('unique_6', 'unique_15', 'unique_10', NULL, NULL, 1.0, 'default2'), ('unique_7', 'default1', 'default2', 'default2', 'default1', 0.0, 'default1'), ('unique_8', 'unique_5', 'unique_13', 'Yearly Kickoff', NULL, 0.0, NULL), ('unique_9', 'unique_13', 'unique_16', 'default2', 'Yearly Kickoff', 0.0, 'default2'), ('unique_10', 'unique_5', 'unique_10', NULL, NULL, 0.0, 'default1'), ('unique_11', 'unique_4', 'unique_5', 'default2', 'default2', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T3.cost) FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T1.event_name = 'Yearly Kickoff';

/*
Gold Result:
(2.0,)
*/

-- Prediction Query
SELECT SUM(cost) FROM expense WHERE link_to_budget IN (SELECT budget_id FROM budget WHERE link_to_event = (SELECT event_id FROM event WHERE event_name = 'Yearly Kickoff'));

/*
Prediction Result:
(None,)
*/
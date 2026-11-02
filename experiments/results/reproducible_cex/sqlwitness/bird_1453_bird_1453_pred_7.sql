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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1, 'default2', 'default2', 'Parking', 'default1', 'default1'), (0, NULL, 'default1', 'default1', 'default2', 'default1'), (2, 'Parking', 'default2', 'Parking', 'Parking', NULL), (3, NULL, 'default1', 'Parking', NULL, 'Parking'), (4, 'Parking', 'Parking', 'default1', 'Parking', NULL), (5, 'default2', 'default2', 'default1', 'Parking', NULL), (6, 'Parking', 'default1', 'default1', 'Parking', 'default1'), (7, 'Parking', 'Parking', 'default2', 'default1', NULL);
INSERT INTO major (major_id, major_name, department, college) VALUES ('default2', 'default1', NULL, 'default1'), ('Parking', 'Parking', 'default1', 'Parking'), ('default1', NULL, 'default2', NULL), ('unique_3', 'default2', NULL, 'Parking'), ('unique_4', 'Parking', 'Parking', 'default1'), ('unique_5', 'default2', NULL, 'default2'), ('unique_6', NULL, 'Parking', 'Parking'), ('unique_7', 'default2', NULL, 'default2'), ('unique_8', 'default2', NULL, 'Parking'), ('unique_9', 'Parking', 'default2', 'Parking'), ('unique_10', NULL, NULL, 'default1'), ('unique_11', 'default1', NULL, NULL), ('unique_12', 'default1', 'default2', 'Parking'), ('unique_13', 'default1', NULL, 'default1'), ('unique_14', 'default1', 'default2', NULL), ('unique_15', 'default2', 'Parking', 'default2'), ('unique_16', 'Parking', 'default1', 'default2');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('Parking', NULL, NULL, 'Parking', 'default1', NULL, 'default2'), ('default2', 'Parking', 'Parking', 'Parking', NULL, 'Parking', NULL), ('default1', 'default1', NULL, NULL, NULL, 'default1', NULL), ('unique_3', 'Parking', NULL, 'Parking', 'default1', 'default2', 'Parking');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('Parking', 'Parking', 'default2', 1.0, NULL, NULL, 'Parking'), ('default2', 'default1', 'default2', 1.0, 0.0, 1, NULL), ('default1', 'default2', 'default1', 0.0, 1.0, 0, 'Parking'), ('unique_3', 'default2', 'default2', 1.0, 0.0, 0, 'Parking'), ('unique_4', 'default2', 'Parking', 0.0, NULL, 1, 'default1'), ('unique_5', 'Parking', 'default1', 1.0, 1.0, 0, NULL), ('unique_6', 'default2', NULL, NULL, NULL, NULL, 'default2'), ('unique_7', 'default2', NULL, NULL, NULL, 1, NULL), ('unique_8', 'unique_3', 'default2', NULL, 0.0, 0, NULL), ('unique_9', NULL, 'default1', 1.0, NULL, NULL, 'Parking'), ('unique_10', NULL, NULL, 1.0, 1.0, 1, 'default1'), ('unique_11', 'default2', 'default2', 0.0, 0.0, 0, 'default1'), ('unique_12', 'default1', NULL, 1.0, 1.0, NULL, 'Parking'), ('unique_13', 'default2', 'default1', NULL, 1.0, NULL, NULL), ('unique_14', NULL, 'default1', 0.0, NULL, 0, 'Parking'), ('unique_15', 'unique_3', 'Parking', 0.0, NULL, NULL, 'Parking'), ('unique_16', NULL, NULL, NULL, 1.0, 1, NULL), ('unique_17', NULL, NULL, 0.0, 0.0, 1, 'Parking'), ('unique_18', 'default1', 'default1', NULL, 1.0, 0, 'Parking'), ('unique_19', NULL, 'default1', 1.0, 0.0, NULL, 'Parking');
INSERT INTO expense (expense_id, link_to_budget, link_to_member, expense_description, expense_date, cost, approved) VALUES ('default2', 'unique_3', NULL, 'default2', NULL, NULL, 'default2'), ('Parking', 'unique_4', NULL, 'default2', 'default2', 0.0, 'Parking'), ('default1', 'unique_11', NULL, NULL, 'default2', 0.0, NULL), ('unique_3', 'unique_16', NULL, 'default2', NULL, 1.0, 'Parking'), ('unique_4', 'unique_6', NULL, 'default1', 'default2', 0.0, 'default1'), ('unique_5', 'unique_14', NULL, 'default2', 'default2', NULL, 'default1'), ('unique_6', 'unique_13', NULL, 'Parking', 'default1', 0.0, 'default2'), ('unique_7', 'unique_17', NULL, NULL, 'Parking', 1.0, 'default1'), ('unique_8', 'unique_16', NULL, 'Parking', 'default2', 0.0, 'default2'), ('unique_9', NULL, NULL, NULL, 'default2', 0.0, 'Parking'), ('unique_10', 'unique_10', NULL, 'default1', 'default2', NULL, 'default1'), ('unique_11', 'unique_9', NULL, 'default2', NULL, NULL, NULL), ('unique_12', 'unique_6', NULL, 'Parking', 'Parking', NULL, 'default2'), ('unique_13', 'unique_19', NULL, NULL, 'default1', 1.0, 'Parking'), ('unique_14', NULL, NULL, 'Parking', NULL, 1.0, NULL), ('unique_15', 'unique_9', NULL, 'default2', 'default1', 1.0, NULL), ('unique_16', 'unique_11', NULL, 'default2', 'Parking', 0.0, 'Parking');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T2.category = 'Parking' AND T3.cost < (SELECT AVG(cost) FROM expense);

/*
Gold Result:
('Parking',)
*/

-- Prediction Query
SELECT T1.event_name FROM event AS T1 JOIN budget AS T2 ON T1.event_id = T2.link_to_event JOIN expense AS T3 ON T3.link_to_budget = T2.budget_id WHERE T2.category = 'Parking' AND T3.cost < (SELECT AVG(cost) FROM expense WHERE link_to_budget IN (SELECT budget_id FROM budget WHERE category = 'Parking'));

/*
Prediction Result:
*/
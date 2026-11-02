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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (0, NULL, 'Parking', 'default2', NULL, 'Parking'), (1, 'Parking', 'Parking', 'default1', 'Parking', 'default1'), (2, NULL, 'default1', 'default1', 'default2', NULL), (3, 'Parking', 'Parking', 'default1', 'default2', 'default2'), (4, 'default1', 'default1', 'default2', 'default2', NULL), (5, 'default2', NULL, 'default1', 'default1', NULL), (6, 'Parking', 'Parking', 'default1', 'default2', 'default1'), (7, 'default1', 'default2', NULL, NULL, 'Parking'), (8, 'default2', NULL, NULL, 'default2', 'default2'), (9, NULL, 'default1', 'default1', NULL, 'default2'), (10, 'Parking', 'default2', NULL, 'default1', 'default2'), (11, NULL, 'default2', 'default2', NULL, NULL);
INSERT INTO major (major_id, major_name, department, college) VALUES ('default2', NULL, 'default2', 'Parking'), ('Parking', NULL, NULL, NULL), ('default1', 'default1', 'default1', 'default1'), ('unique_3', 'default2', 'Parking', NULL), ('unique_4', 'default1', 'default2', 'Parking'), ('unique_5', 'default1', 'default2', 'Parking'), ('unique_6', NULL, 'default1', NULL), ('unique_7', NULL, NULL, 'default2');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('Parking', 'unique_5', 3, 'default1', 'default1', NULL, NULL, 'default1', 'default1'), ('default2', 'unique_4', 8, NULL, 'default2', 'default2', 'default1', 'Parking', NULL), ('default1', 'unique_6', 11, 'Parking', NULL, 'default1', NULL, 'default1', NULL), ('unique_3', 'Parking', 10, NULL, 'default1', 'default1', 'default2', 'default1', 'default1'), ('unique_4', NULL, 6, 'default1', 'Parking', NULL, 'default1', 'default1', 'default2'), ('unique_5', NULL, 3, 'default1', 'Parking', 'default2', 'Parking', 'default2', NULL), ('unique_6', 'default2', NULL, 'Parking', NULL, NULL, 'default2', 'default2', 'default1'), ('unique_7', 'unique_6', NULL, 'default2', 'Parking', 'default2', 'default1', 'Parking', 'default1'), ('unique_8', NULL, 10, NULL, 'default1', NULL, 'default2', NULL, 'Parking'), ('unique_9', 'unique_7', 6, 'default1', 'Parking', 'default1', 'default2', 'default2', 'default2');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('Parking', 'default1', 'default1', 'default1', 'default2', NULL, 'default2'), ('default2', 'Parking', NULL, NULL, 'Parking', NULL, 'Parking'), ('default1', 'default1', 'default1', NULL, 'default1', 'Parking', 'default2'), ('unique_3', NULL, 'Parking', 'Parking', 'Parking', 'default2', 'default2'), ('unique_4', 'Parking', 'default2', NULL, 'Parking', 'default1', 'default2'), ('unique_5', NULL, 'Parking', 'Parking', NULL, 'default2', 'Parking'), ('unique_6', 'Parking', 'default1', NULL, NULL, 'default1', NULL), ('unique_7', 'default2', NULL, 'Parking', NULL, 'Parking', 'Parking'), ('unique_8', 'default2', 'default2', 'default2', 'default1', NULL, 'default1'), ('unique_9', 'Parking', 'Parking', 'default1', 'Parking', 'default2', 'Parking'), ('unique_10', 'default1', 'default1', 'default2', 'default2', NULL, 'default1'), ('unique_11', 'Parking', NULL, 'default1', 'Parking', 'default1', 'default2');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('default1', 'unique_10', 'Parking', 0.0, 0.0, 1, 'default2'), ('Parking', 'unique_10', 'default2', NULL, 1.0, NULL, 'default2'), ('default2', 'default1', 'default2', NULL, 0.0, 1, 'default1');
INSERT INTO expense (expense_id, link_to_budget, link_to_member, expense_description, expense_date, cost, approved) VALUES ('default2', 'default1', 'unique_7', NULL, NULL, 0.0, NULL), ('Parking', 'default2', 'unique_8', 'default1', 'Parking', NULL, 'default1'), ('default1', 'Parking', 'unique_8', NULL, 'default1', 1.0, NULL), ('unique_3', 'Parking', 'unique_8', 'default1', 'default1', 0.0, NULL), ('unique_4', NULL, 'default2', NULL, 'default1', 1.0, 'default2'), ('unique_5', 'Parking', 'unique_3', 'default2', 'Parking', 0.0, 'default2'), ('unique_6', NULL, 'unique_7', 'default2', 'default2', NULL, NULL), ('unique_7', 'default2', 'unique_8', 'default1', 'Parking', 1.0, 'default2'), ('unique_8', NULL, 'unique_7', 'Parking', NULL, NULL, 'Parking'), ('unique_9', 'default1', 'Parking', 'default1', 'Parking', 1.0, 'default2'), ('unique_10', 'default1', 'unique_6', 'default2', 'Parking', 1.0, 'Parking'), ('unique_11', 'default2', 'Parking', NULL, NULL, NULL, 'default1'), ('unique_12', 'Parking', NULL, 'Parking', NULL, 0.0, 'default2'), ('unique_13', NULL, 'Parking', 'default2', NULL, 1.0, 'default1'), ('unique_14', 'Parking', 'default2', 'Parking', 'Parking', 1.0, 'Parking'), ('unique_15', 'default1', 'unique_5', NULL, 'Parking', 1.0, 'default2'), ('unique_16', 'default1', 'unique_5', NULL, 'Parking', 0.0, NULL), ('unique_17', 'default1', 'unique_8', 'default2', 'Parking', 0.0, 'default1'), ('unique_18', 'default1', 'default1', NULL, 'default2', NULL, NULL), ('unique_19', 'default2', 'unique_7', 'Parking', 'Parking', 1.0, 'default2'), ('unique_20', 'default1', 'Parking', 'default1', NULL, 0.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T2.category = 'Parking' AND T3.cost < (SELECT AVG(cost) FROM expense);

/*
Gold Result:
('default1',)
('default1',)
('default1',)
('default1',)
*/

-- Prediction Query
SELECT e.event_name FROM budget AS b INNER JOIN event AS e ON b.link_to_event = e.event_id INNER JOIN expense AS ex ON ex.link_to_budget = b.budget_id WHERE b.category = 'Parking' GROUP BY e.event_name HAVING SUM(ex.cost) / COUNT(b.budget_id) < (SELECT AVG(cost) FROM expense WHERE category = 'Parking');

/*
Prediction Result:
('default1',)
*/
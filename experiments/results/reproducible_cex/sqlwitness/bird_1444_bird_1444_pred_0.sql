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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (49, NULL, 'default1', 'default1', 'default1', 'default2'), (0, 'default2', NULL, 'default1', 'default1', 'default2'), (50, 'default1', NULL, 'default2', NULL, 'default2'), (1, NULL, 'default1', 'default2', 'default1', 'default1'), (51, 'default1', NULL, NULL, NULL, NULL), (2, 'default2', 'default1', 'default1', 'default2', 'default2'), (3, NULL, NULL, NULL, 'default1', 'default1'), (4, NULL, NULL, NULL, 'default1', 'default1'), (5, 'default2', 'default1', 'default1', NULL, 'default1'), (6, NULL, NULL, NULL, 'default1', NULL), (7, 'default1', NULL, NULL, NULL, NULL), (8, NULL, 'default1', 'default1', NULL, 'default1'), (9, NULL, NULL, 'default2', NULL, NULL), (10, 'default1', NULL, NULL, 'default1', NULL), (11, 'default2', 'default1', 'default2', NULL, NULL), (12, 'default2', 'default2', 'default1', NULL, NULL), (13, 'default1', 'default2', 'default2', 'default2', NULL), (14, NULL, 'default1', 'default2', 'default1', NULL), (15, 'default1', 'default1', 'default2', NULL, 'default1'), (16, 'default2', 'default2', 'default1', 'default1', 'default2'), (17, NULL, 'default2', 'default1', 'default1', NULL), (18, 'default2', NULL, NULL, 'default1', NULL);
INSERT INTO major (major_id, major_name, department, college) VALUES ('default2', 'default1', 'default1', 'default2'), ('default1', 'default1', NULL, NULL), ('unique_2', 'default2', NULL, 'default1'), ('unique_3', 'default2', NULL, 'default1'), ('unique_4', 'default1', 'default1', NULL), ('unique_5', 'default1', NULL, NULL), ('unique_6', 'default2', 'default1', NULL), ('unique_7', 'default1', NULL, NULL), ('unique_8', 'default2', 'default2', 'default2'), ('unique_9', NULL, NULL, 'default1'), ('unique_10', 'default1', 'default2', NULL), ('unique_11', 'default2', 'default2', 'default2'), ('unique_12', 'default2', 'default2', 'default1'), ('unique_13', 'default1', 'default1', 'default1'), ('unique_14', NULL, 'default1', 'default1'), ('unique_15', NULL, 'default2', NULL), ('unique_16', 'default2', 'default1', 'default2'), ('unique_17', 'default2', NULL, NULL), ('unique_18', NULL, 'default1', 'default1');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default1', 'unique_13', 50, NULL, 'default1', 'default1', 'default1', 'default2', 'default1'), ('default2', 'unique_17', 0, 'default1', 'default1', 'default2', 'default1', 'default1', 'default1'), ('unique_2', 'unique_9', 16, 'default1', 'default2', NULL, 'default1', 'default1', NULL), ('unique_3', 'unique_15', 17, NULL, 'default2', 'default1', NULL, 'default2', 'default1'), ('unique_4', 'unique_11', 9, NULL, 'default2', NULL, 'default1', NULL, 'default2'), ('unique_5', 'unique_9', 50, 'default1', 'default2', 'default2', 'default2', 'default2', 'default2');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default2', 'default2', 'default1', NULL, NULL, 'default1', NULL), ('default1', NULL, NULL, NULL, NULL, 'default2', 'default2'), ('unique_2', 'default1', NULL, 'default1', 'default1', NULL, NULL), ('unique_3', 'default2', 'default1', 'default2', 'default1', 'default2', 'default1'), ('unique_4', 'default1', 'default2', 'default1', 'default2', NULL, 'default2'), ('unique_5', 'default1', 'default2', 'default1', 'default1', 'default1', 'default1'), ('unique_6', NULL, NULL, 'default2', NULL, NULL, 'default2'), ('unique_7', 'default2', 'default2', 'default2', NULL, 'default2', NULL), ('unique_8', 'default1', 'default1', 'default2', 'default2', 'default1', 'default2');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('default2', 'unique_2', NULL, 51.0, NULL, 49, 'default2'), ('default1', 'unique_3', NULL, 0.0, 0.0, NULL, NULL), ('unique_2', 'unique_3', NULL, 50.0, 51.0, 0, 'default1'), ('unique_3', 'default2', NULL, 1.0, 51.0, 50, NULL), ('unique_4', 'unique_2', NULL, 50.0, 51.0, 51, 'default1');
INSERT INTO expense (expense_id, link_to_budget, link_to_member, expense_description, expense_date, cost, approved) VALUES ('default2', 'default2', 'default2', 'default1', 'default1', NULL, NULL), ('default1', 'default2', 'unique_5', 'default2', 'default2', 50.0, 'default2'), ('unique_2', 'unique_2', 'unique_2', 'default1', NULL, 51.0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT expense_description FROM expense GROUP BY expense_description HAVING AVG(cost) > 50;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT expense_description FROM expense GROUP BY expense_description HAVING SUM(cost) / COUNT(expense_id) > 50;

/*
Prediction Result:
*/
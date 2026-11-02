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
INSERT INTO major (major_id, major_name, department, college) VALUES ('default2', 'default1', 'default1', 'default1'), ('default1', NULL, 'Posters', NULL), ('Posters', 'Posters', 'default1', 'default1'), ('unique_3', 'default2', 'Posters', 'default1'), ('unique_4', NULL, NULL, 'Posters');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default2', 'default1', NULL, 'Posters', 'default2', 'default2', 'default2', 'Posters', 'Posters'), ('Posters', 'default2', NULL, 'default1', NULL, 'default2', 'default1', NULL, 'default2'), ('default1', 'unique_3', NULL, 'Posters', 'Posters', 'default1', NULL, 'default2', 'default1'), ('unique_3', 'default2', NULL, 'Posters', 'default2', NULL, NULL, 'default2', 'Posters'), ('unique_4', 'unique_4', NULL, 'default2', 'Posters', NULL, 'default1', NULL, 'default1'), ('unique_5', 'unique_3', NULL, 'default2', 'default2', 'Posters', 'Posters', 'default1', NULL), ('unique_6', 'unique_4', NULL, NULL, 'default2', NULL, 'Posters', 'default2', NULL), ('unique_7', NULL, NULL, NULL, 'Posters', 'default1', NULL, NULL, 'Posters'), ('unique_8', 'unique_3', NULL, 'default2', NULL, 'default1', 'Posters', 'default1', 'default2');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('default1', NULL, 'default2', 0.0, 1.0, 0, 'default1'), ('default2', NULL, NULL, NULL, 1.0, 1, NULL), ('Posters', NULL, 'default2', 0.0, 1.0, NULL, NULL), ('unique_3', NULL, 'default1', 1.0, 0.0, 0, NULL), ('unique_4', NULL, NULL, 0.0, 0.0, NULL, 'default1'), ('unique_5', NULL, 'Posters', 0.0, NULL, 1, 'default2'), ('unique_6', NULL, 'default1', NULL, 1.0, 0, 'default2'), ('unique_7', NULL, NULL, 0.0, 0.0, 0, NULL), ('unique_8', NULL, NULL, 1.0, 1.0, 0, 'default1');
INSERT INTO expense (expense_id, link_to_budget, link_to_member, expense_description, expense_date, cost, approved) VALUES ('default1', 'unique_7', 'unique_3', 'Posters', 'default2', 0.0, 'default2'), ('Posters', 'Posters', 'unique_5', 'default1', 'default1', 1.0, 'default1'), ('default2', 'Posters', 'unique_6', 'Posters', NULL, NULL, 'default2'), ('unique_3', 'unique_7', 'unique_6', 'default2', 'default1', 0.0, 'Posters'), ('unique_4', 'unique_8', 'default1', 'default1', 'default1', 1.0, 'default2'), ('unique_5', 'unique_7', 'unique_5', 'Posters', 'Posters', 0.0, 'default2'), ('unique_6', 'unique_3', 'unique_7', NULL, NULL, 0.0, 'default2'), ('unique_7', 'unique_5', 'unique_6', 'default2', 'default1', 1.0, NULL), ('unique_8', 'default1', 'unique_3', 'default2', NULL, 1.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.category FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id WHERE T1.expense_description = 'Posters';

/*
Gold Result:
(None,)
('default2',)
*/

-- Prediction Query
SELECT b.category FROM expense AS e JOIN budget AS b ON e.link_to_budget = b.budget_id WHERE e.expense_description = 'Posters';

/*
Prediction Result:
(None,)
('default2',)
(None,)
*/
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
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default1', 'default1', NULL, 'default1', 'default1', 'default2', NULL), ('Advertisement', 'default1', NULL, 'default1', 'default2', 'Advertisement', 'default1'), ('default2', 'default1', NULL, 'Advertisement', NULL, 'Advertisement', 'Advertisement'), ('unique_3', NULL, NULL, 'default1', 'default1', 'Advertisement', 'default1'), ('unique_4', 'default2', NULL, 'default1', 'default2', 'Advertisement', NULL), ('unique_5', 'default1', 'Advertisement', 'default2', NULL, 'default2', 'Advertisement'), ('unique_6', NULL, 'default2', NULL, NULL, 'default1', 'default2'), ('unique_7', 'default2', 'default1', 'default2', 'Advertisement', 'default2', 'default1'), ('unique_8', 'Advertisement', 'default1', 'default2', 'default2', 'default1', 'Advertisement'), ('unique_9', 'Advertisement', 'Advertisement', 'Advertisement', 'Advertisement', NULL, 'default1'), ('unique_10', 'Advertisement', NULL, 'default1', 'default2', NULL, NULL), ('unique_11', NULL, 'default2', 'Advertisement', 'default2', 'default1', 'Advertisement'), ('unique_12', 'default1', 'default1', 'Advertisement', 'Advertisement', 'Advertisement', 'default1'), ('unique_13', 'default1', 'Advertisement', 'Advertisement', 'Advertisement', 'default1', 'Advertisement'), ('unique_14', 'default2', 'default2', 'Advertisement', 'Advertisement', 'Advertisement', 'Advertisement'), ('unique_15', NULL, 'default2', 'default1', 'Advertisement', 'default2', 'Advertisement'), ('unique_16', 'default2', NULL, 'default1', 'Advertisement', NULL, 'Advertisement'), ('unique_17', 'default1', 'default1', NULL, 'default2', 'default2', NULL), ('unique_18', NULL, 'default1', 'default1', NULL, 'Advertisement', NULL), ('unique_19', NULL, 'default1', NULL, 'Advertisement', NULL, 'default2'), ('unique_20', NULL, 'default1', 'default1', 'default2', NULL, 'default1'), ('unique_21', 'default2', NULL, 'default2', 'Advertisement', 'default2', NULL);
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('Advertisement', 'unique_18', 'Advertisement', 2.0, NULL, NULL, NULL), ('default2', 'default1', 'default2', 2.0, 1.0, NULL, 'default2'), ('default1', 'default2', 'default1', 1.0, 0.0, 0, 'default1'), ('unique_3', 'unique_7', 'Advertisement', 1.0, 2.0, 2, 'default2'), ('unique_4', 'unique_17', NULL, 2.0, 0.0, 0, 'default1'), ('unique_5', 'unique_11', 'default1', 2.0, NULL, NULL, 'default2'), ('unique_6', 'unique_5', 'default1', 1.0, 1.0, 2, 'default2'), ('unique_7', 'unique_20', 'Advertisement', 0.0, 2.0, 1, 'default1'), ('unique_8', NULL, 'default2', 2.0, 1.0, NULL, NULL), ('unique_9', 'unique_21', 'Advertisement', 2.0, NULL, 1, NULL), ('unique_10', 'unique_14', 'Advertisement', 2.0, 2.0, 2, 'default1'), ('unique_11', 'Advertisement', 'default2', 0.0, 2.0, 1, NULL), ('unique_12', 'unique_17', 'default1', 0.0, 2.0, NULL, 'Advertisement'), ('unique_13', 'unique_13', 'default1', NULL, 1.0, 1, 'Advertisement'), ('unique_14', 'unique_3', 'Advertisement', 1.0, 2.0, NULL, 'default1'), ('unique_15', 'unique_17', NULL, 0.0, 2.0, NULL, 'Advertisement');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.event_name FROM budget AS T1 INNER JOIN event AS T2 ON T1.link_to_event = T2.event_id WHERE T1.category = 'Advertisement' ORDER BY T1.spent DESC, T1.budget_id NULLS LAST, T2.event_id NULLS LAST LIMIT 1;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT e.event_name FROM event AS e JOIN budget AS b ON e.event_id = b.link_to_event WHERE b.category = 'Advertisement' ORDER BY b.spent DESC, e.event_id NULLS LAST, b.budget_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('default2',)
*/
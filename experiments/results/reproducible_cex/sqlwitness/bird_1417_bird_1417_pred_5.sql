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
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default1', NULL, 'default1', NULL, 'default1', 'default1', 'default2'), ('default2', NULL, 'default1', NULL, NULL, 'default2', 'default2'), ('unique_2', 'default1', 'default1', 'default2', 'default1', 'default2', 'default2'), ('unique_3', NULL, 'default1', 'default1', 'default1', 'default2', 'default1'), ('unique_4', NULL, 'default1', 'default1', 'default1', 'default1', NULL), ('unique_5', NULL, NULL, 'default1', NULL, NULL, NULL), ('unique_6', 'default1', NULL, 'default2', 'default2', 'default2', NULL), ('unique_7', 'default1', 'default2', NULL, 'default2', NULL, NULL), ('unique_8', 'default1', NULL, NULL, NULL, NULL, 'default2'), ('unique_9', 'default2', 'default1', 'default2', 'default1', NULL, 'default1'), ('unique_10', 'default2', 'default2', NULL, 'default1', NULL, 'default2'), ('unique_11', NULL, NULL, NULL, 'default2', NULL, 'default2'), ('unique_12', 'default1', 'default1', 'default1', 'default2', NULL, 'default1'), ('unique_13', NULL, NULL, 'default2', NULL, 'default2', 'default2'), ('unique_14', 'default2', 'default2', 'default2', 'default2', 'default1', NULL), ('unique_15', 'default2', 'default1', 'default2', 'default1', NULL, 'default2'), ('unique_16', NULL, 'default2', 'default2', 'default1', 'default2', 'default2'), ('unique_17', NULL, 'default2', NULL, 'default1', 'default1', 'default2'), ('unique_18', 'default1', 'default1', 'default2', NULL, 'default1', NULL), ('unique_19', 'default1', 'default2', 'default2', NULL, 'default1', 'default2'), ('unique_20', 'default2', 'default2', 'default1', 'default1', 'default2', 'default2'), ('unique_21', 'default2', 'default2', 'default1', 'default1', NULL, 'default2'), ('unique_22', NULL, 'default2', NULL, 'default1', NULL, 'default1'), ('unique_23', 'default2', 'default1', NULL, NULL, 'default2', 'default1'), ('unique_24', NULL, NULL, 'default2', NULL, NULL, 'default1'), ('unique_25', NULL, 'default1', NULL, 'default2', 'default1', 'default2'), ('unique_26', 'default2', 'default2', 'default2', 'default2', 'default2', NULL), ('unique_27', 'default1', 'default1', 'default1', NULL, NULL, 'default2'), ('unique_28', 'default1', 'default2', 'default2', 'default2', 'default2', 'default2'), ('unique_29', NULL, 'default2', NULL, NULL, NULL, 'default2'), ('unique_30', 'default2', 'default2', 'default1', 'default2', 'default2', 'default2');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('default2', 'unique_6', 'default1', 1.0, 31.0, 30, 'default2'), ('default1', 'unique_11', NULL, 30.0, 1.0, 31, 'default1'), ('unique_2', 'unique_24', 'default2', 30.0, NULL, NULL, 'default2'), ('unique_3', 'unique_25', NULL, 1.0, 31.0, 29, 'default2'), ('unique_4', 'unique_15', 'default2', 29.0, 29.0, 30, NULL), ('unique_5', 'unique_15', NULL, 0.0, NULL, 0, NULL), ('unique_6', 'unique_7', NULL, NULL, 0.0, 29, 'default2'), ('unique_7', 'unique_19', 'default1', NULL, NULL, 0, NULL), ('unique_8', 'unique_7', 'default1', 31.0, 30.0, 31, NULL), ('unique_9', 'unique_3', 'default2', NULL, 0.0, 30, 'default1'), ('unique_10', 'unique_26', 'default2', 30.0, 1.0, 29, 'default2'), ('unique_11', 'unique_30', NULL, NULL, 1.0, NULL, 'default1'), ('unique_12', 'unique_28', 'default2', 30.0, 1.0, 29, NULL), ('unique_13', 'unique_3', 'default1', 0.0, 31.0, 30, 'default1'), ('unique_14', 'unique_8', 'default1', 29.0, 31.0, 1, NULL), ('unique_15', 'unique_4', NULL, 30.0, 1.0, 29, 'default1'), ('unique_16', 'unique_5', 'default2', 0.0, 31.0, 30, 'default1'), ('unique_17', 'unique_19', 'default2', 30.0, 30.0, 30, 'default1'), ('unique_18', 'unique_9', 'default2', 31.0, 1.0, 1, 'default1'), ('unique_19', 'unique_23', NULL, 31.0, 1.0, 29, 'default1'), ('unique_20', 'unique_17', 'default2', 29.0, 1.0, 30, 'default1'), ('unique_21', 'unique_19', 'default1', 0.0, 31.0, 0, 'default2'), ('unique_22', 'unique_15', 'default2', NULL, 0.0, 0, NULL), ('unique_23', 'unique_2', 'default1', 0.0, 31.0, 31, NULL), ('unique_24', 'unique_17', 'default1', 31.0, NULL, NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.type FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event WHERE T2.remaining > 30;

/*
Gold Result:
('default2',)
(None,)
('default1',)
(None,)
('default1',)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT DISTINCT event.type FROM event INNER JOIN budget ON event.event_id = budget.link_to_event WHERE budget.remaining > 30;

/*
Prediction Result:
('default2',)
(None,)
('default1',)
*/
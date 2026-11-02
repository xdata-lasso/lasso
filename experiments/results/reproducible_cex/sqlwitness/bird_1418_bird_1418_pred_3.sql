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
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('MU 215', NULL, NULL, 'MU 215', 'MU 215', 'default1', 'MU 215'), ('default1', NULL, 'default2', 'default2', 'MU 215', 'default2', 'default2'), ('default2', NULL, 'default1', 'default2', NULL, 'default1', 'MU 215'), ('unique_3', 'default1', 'default1', 'MU 215', 'default2', NULL, NULL), ('unique_4', NULL, 'default1', 'default2', 'MU 215', 'default2', 'default2'), ('unique_5', NULL, 'MU 215', 'default2', 'MU 215', 'MU 215', 'MU 215'), ('unique_6', 'default1', 'MU 215', 'default2', 'default2', 'default2', 'MU 215'), ('unique_7', 'MU 215', 'default2', 'MU 215', 'default1', 'default1', 'MU 215'), ('unique_8', NULL, NULL, 'default2', NULL, NULL, NULL), ('unique_9', NULL, 'MU 215', 'default1', 'MU 215', NULL, 'default2'), ('unique_10', 'default2', NULL, NULL, 'default1', 'default1', 'default1'), ('unique_11', 'MU 215', 'MU 215', NULL, NULL, 'default1', 'default2'), ('unique_12', 'default1', 'MU 215', NULL, 'MU 215', 'MU 215', 'default2'), ('unique_13', 'default1', NULL, 'MU 215', NULL, 'default2', 'default1'), ('unique_14', 'MU 215', 'default2', 'default2', 'default2', 'MU 215', NULL), ('unique_15', NULL, 'default1', 'default2', 'default2', 'MU 215', 'default2'), ('unique_16', 'default2', NULL, 'default1', 'MU 215', 'default1', NULL), ('unique_17', 'default2', 'default1', 'MU 215', 'default1', NULL, 'default1'), ('unique_18', 'default2', NULL, 'default1', NULL, 'MU 215', 'default1'), ('unique_19', 'default1', NULL, 'default1', 'default1', 'default1', 'default1'), ('unique_20', 'default1', 'default1', 'default1', 'MU 215', 'MU 215', 'default1'), ('unique_21', NULL, NULL, NULL, 'default2', 'default2', 'default1');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('default2', 'unique_8', 'MU 215', 0.0, NULL, 0, 'default1'), ('default1', 'unique_11', 'MU 215', NULL, 0.0, 1, 'MU 215'), ('MU 215', 'default2', NULL, NULL, 0.0, 1, 'MU 215'), ('unique_3', 'unique_14', 'default1', NULL, 0.0, 0, 'MU 215'), ('unique_4', 'unique_18', 'default2', 1.0, 0.0, 0, 'default2'), ('unique_5', 'unique_20', NULL, 1.0, 0.0, 0, 'default1'), ('unique_6', 'unique_10', 'MU 215', 1.0, 1.0, 0, 'default2'), ('unique_7', 'unique_21', 'default2', 1.0, 0.0, 0, 'MU 215'), ('unique_8', 'default1', 'MU 215', NULL, 1.0, NULL, 'MU 215'), ('unique_9', 'unique_17', 'default1', 1.0, 1.0, 1, 'default2'), ('unique_10', 'unique_8', NULL, 0.0, 0.0, NULL, 'default2'), ('unique_11', 'unique_5', NULL, NULL, 0.0, NULL, 'default2'), ('unique_12', 'default2', 'default1', NULL, NULL, 1, NULL), ('unique_13', 'default1', 'default2', NULL, 1.0, 0, 'MU 215'), ('unique_14', 'default2', 'default1', 1.0, NULL, NULL, 'MU 215'), ('unique_15', 'MU 215', 'default2', 1.0, NULL, 1, 'default2'), ('unique_16', 'unique_5', 'default1', NULL, NULL, NULL, 'MU 215'), ('unique_17', 'unique_19', 'default1', 0.0, 0.0, NULL, 'default2'), ('unique_18', 'unique_16', 'MU 215', 0.0, NULL, 1, 'MU 215');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.category FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event WHERE T1.location = 'MU 215';

/*
Gold Result:
('default1',)
('default2',)
(None,)
(None,)
('default1',)
*/

-- Prediction Query
SELECT DISTINCT "budget"."category" FROM "event" INNER JOIN "budget" ON "event"."event_id" = "budget"."link_to_event" WHERE "event"."location" = 'MU 215';

/*
Prediction Result:
('default1',)
('default2',)
(None,)
*/
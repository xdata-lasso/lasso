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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (0, 'Harrison', 'Sacha', 'default2', 'Sacha', 'default1'), (1, 'default1', 'default2', 'Sacha', 'Harrison', 'Sacha'), (2, 'Sacha', 'default2', 'default2', 'Harrison', NULL), (3, 'default2', 'default1', 'default1', 'default2', 'Sacha');
INSERT INTO major (major_id, major_name, department, college) VALUES ('Sacha', NULL, 'default1', 'Harrison'), ('Harrison', NULL, 'default1', 'default1'), ('default1', 'default1', 'default2', 'Sacha'), ('default2', 'Sacha', 'Sacha', 'Sacha');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('Sacha', NULL, 1, 'Harrison', 'default2', 'default1', 'Harrison', 'Sacha', 'Sacha'), ('default2', 'Sacha', NULL, 'Sacha', 'Harrison', 'default2', 'default1', NULL, NULL), ('Harrison', 'Sacha', 2, 'default1', 'default1', 'default1', 'default2', 'Sacha', 'default1'), ('default1', 'Sacha', NULL, 'default1', NULL, 'Harrison', 'default2', NULL, 'default2'), ('unique_4', 'default2', 2, 'Harrison', 'Sacha', 'Harrison', 'Sacha', 'Sacha', NULL), ('unique_5', 'default1', 3, NULL, 'default2', 'Sacha', 'default1', 'Harrison', 'default2'), ('unique_6', 'default2', 0, 'Harrison', 'Harrison', NULL, 'Sacha', 'Sacha', 'Harrison'), ('unique_7', 'default2', 2, 'Harrison', 'Sacha', 'Harrison', 'Sacha', NULL, 'default2');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('Sacha', 'Sacha', 'Harrison', 'Harrison', 'default1', 'Harrison', NULL), ('default1', 'Harrison', 'Sacha', 'default2', NULL, 'Sacha', 'Sacha'), ('Harrison', 'Sacha', 'Sacha', 'Harrison', 'default1', NULL, NULL);
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('default1', 'default1', 'default2', 1.0, NULL, 1, NULL), ('Harrison', 'default1', 'default1', 0.0, 0.0, NULL, NULL), ('Sacha', 'default1', 'default1', 1.0, 0.0, NULL, 'Sacha'), ('default2', NULL, 'Harrison', 1.0, 0.0, NULL, 'Harrison'), ('unique_4', 'Sacha', NULL, 1.0, 0.0, 0, 'Sacha'), ('unique_5', 'Sacha', 'default2', 0.0, 0.0, 1, NULL), ('unique_6', 'default1', 'Harrison', 1.0, 1.0, 0, NULL), ('unique_7', NULL, 'Harrison', 1.0, NULL, NULL, 'default1'), ('unique_8', 'Harrison', 'default1', 0.0, NULL, 1, 'default1');
INSERT INTO expense (expense_id, link_to_budget, link_to_member, expense_description, expense_date, cost, approved) VALUES ('default2', NULL, 'unique_7', 'Sacha', NULL, 0.0, 'default2'), ('Harrison', 'Sacha', 'unique_5', NULL, NULL, NULL, NULL), ('Sacha', 'unique_8', 'default2', NULL, 'Sacha', 1.0, NULL), ('default1', 'Harrison', 'default1', 'Sacha', 'Sacha', 1.0, 'default1'), ('unique_4', 'unique_4', 'default1', 'Sacha', 'Harrison', NULL, 'default2'), ('unique_5', 'Sacha', 'default2', 'default2', 'Harrison', 1.0, 'Harrison'), ('unique_6', 'unique_6', 'unique_4', 'default2', 'default1', 0.0, 'Harrison'), ('unique_7', 'unique_4', 'Sacha', 'Harrison', 'default1', 0.0, 'default1'), ('unique_8', 'default2', 'default1', 'default2', 'default1', NULL, 'Sacha'), ('unique_9', 'unique_8', 'Harrison', NULL, NULL, 0.0, NULL), ('unique_10', 'Harrison', 'default2', 'default1', NULL, NULL, 'Sacha'), ('unique_11', 'unique_5', 'default1', 'default2', 'Sacha', 1.0, 'default1'), ('unique_12', 'unique_5', 'unique_5', 'Harrison', 'Sacha', 1.0, 'Harrison'), ('unique_13', 'unique_8', 'Sacha', 'Sacha', 'Harrison', 1.0, 'Sacha'), ('unique_14', 'unique_7', 'Sacha', 'Harrison', 'Sacha', 1.0, 'Sacha'), ('unique_15', 'Harrison', 'default2', 'default1', 'Sacha', 0.0, 'Harrison'), ('unique_16', 'default2', 'unique_6', 'Sacha', 'default2', NULL, 'Harrison');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.expense_description FROM member AS T1 INNER JOIN expense AS T2 ON T1.member_id = T2.link_to_member WHERE T1.first_name = 'Sacha' AND T1.last_name = 'Harrison';

/*
Gold Result:
(None,)
('default2',)
('default1',)
('default1',)
*/

-- Prediction Query
SELECT DISTINCT "expense"."expense_description" FROM "expense" INNER JOIN "member" ON "expense"."link_to_member" = "member"."member_id" WHERE "member"."first_name" = 'Sacha' AND "member"."last_name" = 'Harrison';

/*
Prediction Result:
(None,)
('default2',)
('default1',)
*/
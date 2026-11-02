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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (2, NULL, 'default2', 'default1', 'default1', NULL), (0, NULL, 'default1', NULL, 'default2', NULL), (1, 'default1', 'default2', 'default2', NULL, 'default1'), (3, 'default1', 'default2', 'default1', NULL, NULL), (4, 'default2', NULL, NULL, 'default2', NULL), (5, 'default1', 'default2', NULL, NULL, 'default2'), (6, 'default2', 'default1', 'default2', 'default2', 'default2'), (7, 'default1', 'default2', NULL, NULL, NULL), (8, 'default2', 'default1', 'default1', NULL, 'default1'), (9, 'default2', 'default2', 'default2', 'default1', 'default2'), (10, 'default2', 'default2', 'default2', 'default1', 'default1'), (11, 'default1', 'default2', 'default1', NULL, 'default2'), (12, NULL, 'default1', 'default2', 'default1', 'default2');
INSERT INTO major (major_id, major_name, department, college) VALUES ('default1', 'default2', 'default2', 'default1'), ('default2', NULL, NULL, NULL), ('unique_2', 'default2', 'default2', 'default2'), ('unique_3', 'default1', NULL, NULL), ('unique_4', 'default2', 'default2', 'default1'), ('unique_5', 'default1', 'default2', 'default2'), ('unique_6', NULL, 'default1', NULL), ('unique_7', 'default1', 'default1', NULL), ('unique_8', 'default2', 'default1', 'default1'), ('unique_9', NULL, 'default2', 'default1'), ('unique_10', NULL, 'default1', 'default1'), ('unique_11', 'default2', 'default1', 'default1'), ('unique_12', NULL, 'default1', 'default2'), ('unique_13', NULL, 'default2', 'default1'), ('unique_14', NULL, NULL, NULL);
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default1', 'unique_7', 10, 'default1', 'default2', 'default2', 'default2', 'default2', 'default1'), ('default2', 'default2', 4, NULL, 'default1', 'default1', 'default2', NULL, 'default2'), ('unique_2', 'unique_14', 1, 'default2', NULL, NULL, 'default2', 'default2', 'default1'), ('unique_3', 'unique_3', 10, NULL, 'default1', 'default2', 'default2', NULL, 'default2'), ('unique_4', 'unique_6', 3, 'default1', NULL, 'default2', NULL, NULL, NULL), ('unique_5', 'unique_12', 9, NULL, NULL, NULL, 'default1', NULL, 'default1'), ('unique_6', 'unique_13', 7, NULL, 'default2', NULL, NULL, NULL, NULL), ('unique_7', 'unique_10', 11, 'default1', 'default1', 'default2', 'default1', 'default2', 'default1'), ('unique_8', 'unique_12', 5, 'default1', 'default1', NULL, NULL, 'default2', 'default1'), ('unique_9', 'unique_12', 1, 'default2', NULL, 'default1', NULL, 'default2', 'default1'), ('unique_10', 'unique_7', 4, 'default2', 'default1', 'default1', NULL, 'default2', 'default2'), ('unique_11', 'unique_13', 8, 'default1', 'default2', 'default2', NULL, 'default2', 'default1'), ('unique_12', 'unique_9', 9, 'default2', 'default1', NULL, NULL, 'default2', 'default2'), ('unique_13', 'unique_9', 3, 'default2', NULL, NULL, NULL, 'default1', NULL), ('unique_14', 'unique_14', 3, 'default1', 'default2', 'default1', 'default2', NULL, 'default2'), ('unique_15', 'default1', 8, NULL, 'default1', 'default1', NULL, 'default1', 'default1'), ('unique_16', 'unique_3', 3, 'default2', 'default2', NULL, 'default1', 'default2', 'default2'), ('unique_17', NULL, 3, 'default2', 'default2', NULL, 'default2', NULL, 'default2');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default1', 'default1', 'default2', 'default2', NULL, 'default1', NULL), ('default2', 'default2', 'default1', 'default1', 'default2', 'default2', NULL), ('unique_2', NULL, NULL, 'default1', NULL, 'default1', 'default1'), ('unique_3', 'default2', 'default2', 'default2', NULL, 'default2', 'default2'), ('unique_4', NULL, NULL, 'default2', NULL, 'default1', NULL), ('unique_5', 'default1', 'default1', 'default2', 'default1', NULL, NULL), ('unique_6', 'default1', 'default2', 'default2', NULL, 'default1', NULL), ('unique_7', 'default2', 'default1', 'default1', NULL, 'default2', NULL), ('unique_8', 'default2', 'default1', 'default1', NULL, NULL, 'default1'), ('unique_9', 'default2', 'default2', NULL, NULL, 'default1', 'default1'), ('unique_10', NULL, 'default2', 'default2', 'default2', 'default2', 'default2'), ('unique_11', NULL, NULL, 'default2', 'default2', 'default2', 'default2'), ('unique_12', 'default2', 'default1', 'default2', 'default1', NULL, 'default1'), ('unique_13', NULL, NULL, NULL, 'default2', NULL, 'default1'), ('unique_14', NULL, 'default1', NULL, 'default2', 'default1', NULL), ('unique_15', NULL, NULL, 'default2', 'default2', 'default1', 'default2'), ('unique_16', NULL, 'default1', 'default2', 'default1', NULL, 'default1'), ('unique_17', 'default1', 'default2', NULL, 'default1', NULL, NULL), ('unique_18', NULL, NULL, 'default1', 'default1', 'default2', 'default1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('unique_5', 'unique_3'), ('default1', 'unique_4'), ('unique_16', 'unique_15'), ('unique_10', 'unique_10'), ('unique_18', 'default1'), ('default2', 'unique_3'), ('unique_9', 'unique_17');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event GROUP BY T1.event_name ORDER BY COUNT(T2.link_to_event) DESC, T1.event_name NULLS LAST LIMIT 1;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT T.event_name FROM (SELECT T1.event_name, COUNT(T2.link_to_event) AS num FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event GROUP BY T1.event_id) AS T ORDER BY T.num DESC, T.event_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/
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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1, 'Luisa', 'default2', 'Luisa', 'Guidi', 'Luisa'), (0, 'Guidi', 'Guidi', 'Luisa', 'Guidi', 'default1'), (2, NULL, 'default1', NULL, 'default1', NULL), (3, 'default1', NULL, 'default1', NULL, 'default1'), (4, 'Guidi', 'Guidi', 'Luisa', 'default1', NULL), (5, NULL, 'Guidi', 'default1', 'Luisa', 'default1'), (6, 'Guidi', 'Guidi', 'default1', 'default1', 'Luisa'), (7, 'default1', 'Luisa', 'Guidi', NULL, 'default2'), (8, 'Guidi', 'Luisa', 'default2', 'default2', 'Guidi'), (9, NULL, 'Guidi', 'default1', 'default1', 'Guidi');
INSERT INTO major (major_id, major_name, department, college) VALUES ('default1', 'Luisa', 'Luisa', 'default2'), ('Guidi', 'Guidi', 'Luisa', 'default1'), ('Luisa', 'Luisa', NULL, 'Luisa'), ('default2', 'default1', 'default2', 'Luisa'), ('unique_4', 'default2', 'Luisa', NULL), ('unique_5', 'Guidi', NULL, 'Luisa'), ('unique_6', 'Guidi', 'default2', 'Guidi'), ('unique_7', 'default1', 'Luisa', NULL), ('unique_8', 'Guidi', 'default2', NULL), ('unique_9', 'Luisa', NULL, 'Guidi'), ('unique_10', 'default2', 'Guidi', 'Luisa'), ('unique_11', NULL, 'default1', 'Guidi'), ('unique_12', 'Guidi', 'Guidi', 'default1'), ('unique_13', NULL, NULL, 'Guidi'), ('unique_14', 'Guidi', 'default1', NULL), ('unique_15', 'default1', 'default2', NULL), ('unique_16', NULL, 'Luisa', NULL), ('unique_17', 'default2', NULL, 'default2'), ('unique_18', 'default1', 'default2', NULL), ('unique_19', 'Guidi', NULL, 'default2'), ('unique_20', 'default2', 'default2', 'Guidi'), ('unique_21', NULL, 'Luisa', 'Guidi'), ('unique_22', NULL, 'default2', 'default1'), ('unique_23', 'default2', 'Guidi', 'default2');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('Guidi', 'unique_7', 1, NULL, 'default1', NULL, 'default2', 'default1', 'Luisa'), ('default2', NULL, 2, 'Luisa', 'Guidi', 'Luisa', NULL, 'default2', 'Guidi'), ('Luisa', 'unique_20', 7, NULL, 'Guidi', 'default2', NULL, 'Guidi', 'default2'), ('default1', 'unique_6', 1, 'Luisa', 'default2', 'Luisa', NULL, NULL, NULL), ('unique_4', 'unique_18', 0, NULL, NULL, 'default1', NULL, 'default1', 'Guidi'), ('unique_5', 'Luisa', 3, 'default2', 'Guidi', 'Luisa', NULL, 'default1', 'Luisa'), ('unique_6', 'unique_19', 9, NULL, NULL, 'Guidi', 'Guidi', 'Guidi', NULL), ('unique_7', 'unique_13', 0, 'Guidi', 'Luisa', 'Luisa', 'default1', NULL, 'Luisa'), ('unique_8', 'unique_17', 5, 'Guidi', 'Luisa', 'default2', 'Luisa', NULL, 'Guidi'), ('unique_9', 'unique_9', 7, NULL, 'Luisa', NULL, 'default2', 'Luisa', NULL), ('unique_10', 'Guidi', 2, NULL, 'default2', 'Luisa', 'Guidi', 'Luisa', 'default2');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('Luisa', 'default1', 'default1', 'default1', 'Luisa', NULL, 'default2'), ('default2', 'default2', 'Luisa', 'Guidi', NULL, 'default2', 'Luisa'), ('Guidi', 'default2', 'Luisa', 'default2', 'default2', 'default1', 'default1'), ('default1', 'default2', NULL, 'Guidi', NULL, 'default2', NULL), ('unique_4', 'Luisa', 'default2', 'default2', 'Guidi', 'default2', NULL), ('unique_5', 'default2', 'default1', NULL, 'Guidi', NULL, NULL), ('unique_6', 'Luisa', 'Guidi', 'Luisa', 'Guidi', 'Luisa', 'default2'), ('unique_7', NULL, 'Guidi', 'default2', NULL, 'default1', NULL), ('unique_8', 'Guidi', 'default1', 'Guidi', 'default1', 'default2', 'Guidi'), ('unique_9', NULL, 'default1', 'Guidi', 'default2', 'default1', 'Guidi'), ('unique_10', 'default2', NULL, 'default1', 'Luisa', 'default2', 'Luisa'), ('unique_11', 'Luisa', 'default2', 'Luisa', 'default1', 'default1', NULL), ('unique_12', 'default1', 'Luisa', NULL, 'Luisa', 'Luisa', 'Luisa'), ('unique_13', 'Luisa', NULL, NULL, 'Guidi', 'default2', 'Guidi'), ('unique_14', 'default1', 'Guidi', 'default2', 'Luisa', NULL, 'Guidi'), ('unique_15', 'Guidi', 'Guidi', 'default1', 'default1', 'Guidi', NULL), ('unique_16', 'Guidi', 'default1', 'Luisa', 'default2', 'Guidi', 'Guidi'), ('unique_17', 'Luisa', 'default2', 'default1', NULL, 'default1', NULL), ('unique_18', 'Guidi', 'default2', 'default1', 'default1', 'default2', 'Luisa'), ('unique_19', NULL, 'Luisa', 'default1', 'default2', 'default2', 'Guidi'), ('unique_20', 'default1', 'default1', 'Luisa', 'Guidi', 'default1', 'default2'), ('unique_21', 'Luisa', 'default2', 'default1', 'Luisa', 'default2', 'Guidi'), ('unique_22', 'Luisa', 'Luisa', 'default2', 'default1', 'default2', 'default1'), ('unique_23', NULL, 'Guidi', 'default2', 'default2', 'default2', 'default2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('unique_17', 'unique_5'), ('unique_22', 'default2'), ('default1', 'default1'), ('unique_5', 'unique_6'), ('unique_9', 'unique_4'), ('unique_19', 'unique_5'), ('unique_9', 'default2'), ('unique_13', 'Luisa'), ('unique_9', 'unique_7'), ('unique_8', 'unique_4'), ('unique_19', 'unique_7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T3.link_to_event), T1.major_name FROM major AS T1 INNER JOIN member AS T2 ON T1.major_id = T2.link_to_major INNER JOIN attendance AS T3 ON T2.member_id = T3.link_to_member WHERE T2.first_name = 'Luisa' AND T2.last_name = 'Guidi';

/*
Gold Result:
(0, None)
*/

-- Prediction Query
SELECT (SELECT COUNT(*) FROM attendance WHERE link_to_member = (SELECT member_id FROM member WHERE first_name = 'Luisa' AND last_name = 'Guidi')) AS number_of_events_attended, (SELECT major_name FROM major WHERE major_id = (SELECT link_to_major FROM member WHERE first_name = 'Luisa' AND last_name = 'Guidi')) AS major;

/*
Prediction Result:
(2, None)
*/
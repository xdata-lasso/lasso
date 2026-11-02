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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (0, 'Luisa', 'default2', 'default2', NULL, 'Luisa'), (1, NULL, NULL, 'default2', 'Guidi', 'Luisa'), (2, 'Luisa', 'Guidi', 'Luisa', NULL, 'Luisa'), (3, 'Luisa', 'default1', 'Luisa', NULL, 'default1'), (4, 'Luisa', NULL, 'Luisa', NULL, 'default1'), (5, 'default2', 'default2', 'default1', NULL, NULL), (6, 'Luisa', 'default2', 'Luisa', NULL, 'default2'), (7, NULL, 'Luisa', NULL, 'Guidi', 'default1'), (8, 'default1', 'Guidi', 'Luisa', NULL, NULL), (9, 'Luisa', 'Luisa', 'default2', 'default2', 'Guidi'), (10, NULL, 'default2', 'default2', 'Guidi', NULL), (11, NULL, 'Luisa', NULL, NULL, 'default2'), (12, NULL, 'default2', 'default2', 'Luisa', 'Luisa'), (13, 'Luisa', NULL, NULL, 'Guidi', 'Guidi'), (14, NULL, 'default1', NULL, 'Guidi', 'default1'), (15, NULL, 'default1', 'default1', NULL, NULL), (16, 'Guidi', NULL, 'default2', NULL, 'default1'), (17, NULL, 'default2', 'Guidi', 'Guidi', 'Luisa'), (18, 'Guidi', 'default2', NULL, 'default2', NULL), (19, 'Luisa', 'Luisa', 'default1', NULL, 'default1'), (20, NULL, NULL, 'Luisa', NULL, 'Guidi');
INSERT INTO major (major_id, major_name, department, college) VALUES ('Guidi', NULL, 'default1', 'default1'), ('default2', NULL, 'Guidi', NULL), ('default1', 'default2', 'default1', 'default1'), ('Luisa', 'Guidi', 'Luisa', 'Luisa'), ('unique_4', 'Guidi', 'default2', NULL), ('unique_5', 'default2', 'default2', NULL), ('unique_6', 'default2', NULL, 'default1'), ('unique_7', 'Guidi', 'Luisa', NULL), ('unique_8', NULL, 'Luisa', 'Guidi'), ('unique_9', 'Guidi', NULL, NULL), ('unique_10', NULL, NULL, 'Guidi'), ('unique_11', 'Guidi', 'Guidi', 'Guidi'), ('unique_12', 'default1', 'Luisa', 'default1'), ('unique_13', 'default2', 'default1', 'Luisa'), ('unique_14', NULL, 'Luisa', 'Luisa'), ('unique_15', 'Luisa', NULL, 'default2'), ('unique_16', 'Guidi', 'default1', NULL), ('unique_17', 'default2', 'default2', 'Guidi'), ('unique_18', NULL, 'default1', 'Guidi'), ('unique_19', NULL, 'Guidi', 'Luisa');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default1', 'unique_8', 17, 'Luisa', 'Luisa', 'default2', 'default1', 'Luisa', 'default2'), ('Luisa', 'unique_18', 9, NULL, 'Guidi', NULL, 'default2', 'default2', 'default1'), ('Guidi', 'Guidi', NULL, 'default1', NULL, 'default1', 'Guidi', 'Guidi', NULL), ('default2', 'unique_15', 11, 'Luisa', NULL, 'default1', 'default2', NULL, 'Guidi'), ('unique_4', NULL, 1, 'Guidi', 'default1', 'default2', 'default2', 'default2', NULL), ('unique_5', 'unique_19', 19, NULL, 'default2', 'Guidi', 'Guidi', 'default1', 'Guidi'), ('unique_6', NULL, 17, NULL, 'default2', 'default1', 'Guidi', 'Luisa', 'default2'), ('unique_7', 'unique_10', 1, 'Guidi', 'default2', 'Guidi', 'default2', NULL, 'Guidi'), ('unique_8', 'unique_17', 19, NULL, NULL, NULL, 'Guidi', 'Luisa', NULL), ('unique_9', 'unique_19', 11, 'Luisa', NULL, 'Luisa', 'Guidi', 'Guidi', NULL), ('unique_10', 'Guidi', 13, NULL, 'default1', NULL, 'default2', 'default1', 'Guidi'), ('unique_11', 'Luisa', 1, 'Luisa', 'Guidi', 'default1', NULL, 'Guidi', NULL), ('unique_12', 'unique_5', 17, 'Guidi', 'Luisa', 'default2', NULL, 'Guidi', 'Guidi'), ('unique_13', 'unique_13', 18, NULL, 'default1', 'Luisa', 'Luisa', 'Luisa', 'Luisa'), ('unique_14', 'default2', 20, 'Guidi', NULL, NULL, 'Luisa', 'Luisa', 'Guidi'), ('unique_15', 'default1', 16, 'default2', NULL, 'Luisa', 'default2', 'default1', 'default2'), ('unique_16', 'unique_10', 9, 'Luisa', 'Luisa', 'default1', NULL, NULL, 'default2'), ('unique_17', 'unique_15', 11, NULL, 'default2', 'default1', NULL, NULL, NULL), ('unique_18', 'unique_8', 9, 'Luisa', 'default2', 'default2', 'default1', 'default1', 'Luisa'), ('unique_19', 'unique_4', 18, NULL, 'default1', 'Guidi', 'Guidi', NULL, 'Luisa');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('Guidi', NULL, 'Guidi', 'default1', NULL, 'Guidi', 'default2'), ('default1', 'default1', 'default1', 'Guidi', 'default1', 'default1', 'Guidi'), ('default2', 'default2', 'default1', 'Guidi', 'default1', 'Luisa', NULL), ('Luisa', NULL, 'default1', 'Luisa', 'default2', 'default2', 'default2'), ('unique_4', NULL, 'Luisa', 'Luisa', 'Luisa', 'Luisa', 'Luisa'), ('unique_5', 'Luisa', 'default2', 'Luisa', NULL, 'default2', 'default2'), ('unique_6', 'Guidi', NULL, 'default2', 'Luisa', 'Guidi', 'Luisa'), ('unique_7', 'Luisa', NULL, 'Luisa', 'default2', 'default2', 'Guidi'), ('unique_8', 'default1', 'default2', 'Guidi', 'Luisa', 'default1', 'Luisa');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T3.link_to_event), T1.major_name FROM major AS T1 INNER JOIN member AS T2 ON T1.major_id = T2.link_to_major INNER JOIN attendance AS T3 ON T2.member_id = T3.link_to_member WHERE T2.first_name = 'Luisa' AND T2.last_name = 'Guidi';

/*
Gold Result:
(0, None)
*/

-- Prediction Query
SELECT COUNT(attendance.link_to_event) AS event_count, major.major_name FROM member LEFT JOIN attendance ON member.member_id = attendance.link_to_member LEFT JOIN major ON member.link_to_major = major.major_id WHERE member.first_name = 'Luisa' AND member.last_name = 'Guidi';

/*
Prediction Result:
(0, 'Guidi')
*/
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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1, '%Y', '2019', 'Harrison', 'Harrison', 'Student_Club'), (5, NULL, 'Harrison', 'Student_Club', 'Sacha', 'default2'), (3, '%Y', 'Sacha', 'Sacha', '%Y', 'Student_Club'), (4, 'default2', 'default1', 'Student_Club', '%Y', 'default2'), (0, 'default2', 'Harrison', 'Student_Club', 'Student_Club', 'default2'), (2, '%Y', 'default1', '2019', 'Harrison', 'Sacha'), (6, '2019', '2019', 'Sacha', 'Harrison', 'Harrison'), (7, NULL, '2019', '%Y', '2019', 'default2'), (8, '%Y', '2019', 'Sacha', 'default1', '2019'), (9, '2019', 'Harrison', '%Y', 'default1', '2019'), (10, 'Sacha', 'default1', '2019', 'default2', 'default2'), (11, 'default2', 'default2', 'default1', 'Student_Club', '2019'), (12, '2019', 'Sacha', NULL, 'Sacha', 'default1'), (13, NULL, 'Harrison', 'Harrison', NULL, 'default1'), (14, 'Student_Club', 'Student_Club', '%Y', '2019', 'default2'), (15, 'Student_Club', 'Harrison', 'default2', 'Sacha', 'Sacha'), (16, '%Y', NULL, NULL, 'Student_Club', 'Sacha'), (17, '2019', NULL, 'Harrison', 'Harrison', 'Harrison'), (18, 'default2', 'default1', 'Sacha', NULL, NULL), (19, '2019', '%Y', '2019', NULL, NULL), (20, '%Y', 'default2', 'Sacha', 'Student_Club', 'Student_Club'), (21, 'Sacha', 'default1', 'Harrison', 'Harrison', NULL), (22, 'Harrison', NULL, 'default1', 'default1', 'Harrison'), (23, 'Harrison', 'Student_Club', 'Sacha', 'Harrison', '2019'), (24, '2019', NULL, '2019', 'Student_Club', NULL), (25, 'Student_Club', 'Student_Club', NULL, 'default1', '%Y'), (26, 'Student_Club', 'Sacha', 'Sacha', 'Student_Club', 'default2'), (27, 'default1', 'default2', '%Y', 'default2', 'Sacha'), (28, '%Y', '%Y', NULL, NULL, 'Sacha'), (29, '2019', 'Student_Club', 'default2', '%Y', 'default2'), (30, 'default2', 'Harrison', NULL, '%Y', '2019');
INSERT INTO major (major_id, major_name, department, college) VALUES ('default2', 'Student_Club', 'default2', 'Sacha'), ('default1', NULL, NULL, '%Y'), ('Sacha', 'default1', 'default2', 'default2'), ('2019', '%Y', 'Sacha', NULL), ('Student_Club', 'default2', '%Y', 'Sacha'), ('Harrison', 'default2', 'Sacha', 'Student_Club');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('Sacha', 'default1', 18, 'Sacha', 'default1', '2019', 'Student_Club', 'default1', NULL), ('default2', 'Harrison', 28, 'Sacha', 'default2', '2019', NULL, 'default1', '%Y'), ('2019', NULL, 5, 'default2', 'Student_Club', 'Harrison', 'Student_Club', '2019', '2019'), ('%Y', '2019', 27, 'default1', 'Sacha', 'Student_Club', 'Harrison', '2019', '%Y'), ('Student_Club', 'Sacha', 17, 'Student_Club', 'Student_Club', 'default1', '%Y', '2019', 'Sacha'), ('default1', 'Sacha', 14, 'default2', 'default1', '%Y', NULL, '2019', 'Sacha'), ('Harrison', '2019', 15, 'default1', 'Student_Club', NULL, '2019', NULL, '%Y'), ('unique_7', 'Harrison', 15, 'default2', 'default1', 'Harrison', 'default1', '2019', NULL), ('unique_8', 'Student_Club', 8, 'Harrison', '2019', 'Student_Club', 'Harrison', 'Sacha', 'default1'), ('unique_9', 'Harrison', 0, 'Student_Club', 'Student_Club', 'Sacha', 'Sacha', 'Harrison', 'Student_Club'), ('unique_10', 'Sacha', 1, 'Student_Club', '%Y', '2019', 'Student_Club', 'Sacha', '%Y'), ('unique_11', '2019', 22, NULL, 'default1', NULL, 'Harrison', '%Y', '2019'), ('unique_12', 'Harrison', 30, 'default1', 'default1', NULL, '2019', '%Y', NULL), ('unique_13', 'Harrison', 21, 'Sacha', 'Harrison', 'Sacha', '2019', 'Student_Club', '%Y'), ('unique_14', 'default1', 8, NULL, 'Sacha', '%Y', NULL, 'default1', 'Harrison'), ('unique_15', 'default1', 30, 'default1', '%Y', 'Harrison', 'Student_Club', 'Student_Club', 'Sacha'), ('unique_16', 'Harrison', 21, '2019', '2019', NULL, 'Sacha', 'default1', 'Sacha'), ('unique_17', 'default2', 20, 'default1', 'Harrison', 'default1', 'default1', 'Harrison', NULL), ('unique_18', '2019', 5, 'Sacha', 'Student_Club', 'Sacha', 'Sacha', '2019', 'Student_Club'), ('unique_19', 'default2', 15, '2019', '2019', 'default2', '%Y', NULL, '%Y'), ('unique_20', 'Harrison', 2, NULL, '2019', NULL, '2019', 'default1', '2019'), ('unique_21', '2019', 18, 'Sacha', 'default2', '%Y', 'Harrison', 'Student_Club', 'default2'), ('unique_22', '2019', 23, '2019', NULL, 'default1', 'default2', 'Sacha', 'default1');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('Harrison', 'default1', 'Student_Club', 'default1', 'default2', 'Harrison', 'Student_Club'), ('default2', 'default2', 'default1', 'Harrison', 'Sacha', '2019', 'Student_Club'), ('Sacha', 'Student_Club', NULL, 'Student_Club', NULL, NULL, '2019'), ('%Y', '%Y', '%Y', 'default2', 'Harrison', '%Y', 'Harrison'), ('Student_Club', 'Harrison', '%Y', 'Harrison', '%Y', NULL, 'Harrison'), ('2019', 'default2', 'default2', 'Sacha', 'default1', '2019', NULL), ('default1', 'default1', 'default1', 'Student_Club', '%Y', 'default2', '2019'), ('unique_7', 'default1', 'Harrison', '%Y', '%Y', '2019', 'Sacha'), ('unique_8', 'Sacha', 'default2', 'default2', 'default2', 'Sacha', 'default1'), ('unique_9', 'default1', 'Harrison', 'Sacha', 'Student_Club', 'Sacha', 'default1'), ('unique_10', 'default1', '2019', 'Harrison', 'default1', 'Sacha', 'Student_Club'), ('unique_11', 'default2', 'Sacha', 'default1', '2019', 'Harrison', 'default2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('Sacha', 'unique_18'), ('unique_8', 'unique_21'), ('unique_7', 'unique_8'), ('unique_9', 'unique_15'), ('Harrison', 'unique_9'), ('Student_Club', 'unique_12'), ('Student_Club', 'unique_8'), ('unique_10', 'unique_13'), ('unique_7', 'Sacha'), ('unique_7', 'default1'), ('Harrison', 'unique_19'), ('unique_11', '%Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.event_id) FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event INNER JOIN member AS T3 ON T2.link_to_member = T3.member_id WHERE T3.first_name = 'Sacha' AND T3.last_name = 'Harrison' AND SUBSTRING(T1.event_date, 1, 4) = '2019';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(T1.event_id) FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event INNER JOIN member AS T3 ON T2.link_to_member = T3.member_id WHERE T1.type = 'Student_Club' AND T3.first_name = 'Sacha' AND T3.last_name = 'Harrison' AND STRFTIME('%Y', T1.event_date) = '2019';

/*
Prediction Result:
(0,)
*/
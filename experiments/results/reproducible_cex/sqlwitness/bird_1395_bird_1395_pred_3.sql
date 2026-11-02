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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (2, 'default2', 'default2', 'default1', 'default1', '%Y'), (1, NULL, '%Y', '2019', '%Y', 'default2'), (5, 'default1', 'default2', 'default2', 'default1', 'default1'), (3, 'Community Theater', 'Community Theater', '2019', NULL, 'default2'), (0, NULL, '%Y', 'Community Theater', 'default2', 'Community Theater'), (4, 'default1', 'default2', '2019', '%Y', '%Y'), (6, 'default2', '2019', 'default2', 'Community Theater', '2019'), (7, 'Community Theater', 'Community Theater', 'default2', '2019', '%Y'), (8, '2019', 'default2', 'default1', 'default1', '%Y'), (9, '2019', '%Y', 'default1', 'default1', 'default1'), (10, '%Y', '2019', 'default1', 'default1', 'default1');
INSERT INTO major (major_id, major_name, department, college) VALUES ('default2', 'default1', '%Y', 'default1'), ('%Y', '%Y', 'Community Theater', 'Community Theater'), ('2019', 'default1', NULL, 'Community Theater'), ('Community Theater', NULL, 'default2', 'Community Theater'), ('default1', NULL, 'default1', '2019'), ('unique_5', 'default2', 'default1', 'Community Theater'), ('unique_6', 'default1', '%Y', 'Community Theater'), ('unique_7', 'default1', '%Y', 'Community Theater'), ('unique_8', '2019', 'Community Theater', 'default2'), ('unique_9', NULL, '2019', 'Community Theater'), ('unique_10', 'default2', 'default2', 'default1'), ('unique_11', 'default1', '2019', 'Community Theater'), ('unique_12', NULL, '2019', 'default1'), ('unique_13', '2019', 'default2', 'Community Theater'), ('unique_14', '%Y', NULL, 'default1'), ('unique_15', 'default1', NULL, '%Y'), ('unique_16', NULL, 'Community Theater', '%Y'), ('unique_17', '2019', '2019', '%Y');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('Community Theater', 'unique_16', 9, '%Y', 'Community Theater', 'Community Theater', '%Y', 'Community Theater', 'default2'), ('default2', 'unique_6', 6, 'default2', 'Community Theater', '2019', NULL, '2019', '2019'), ('default1', 'unique_7', 0, 'default1', 'default2', 'Community Theater', 'Community Theater', NULL, '2019'), ('%Y', 'unique_5', 2, 'default1', NULL, NULL, '2019', '2019', 'default1'), ('2019', 'default1', NULL, 'default1', NULL, 'Community Theater', 'Community Theater', 'Community Theater', '%Y'), ('unique_5', 'Community Theater', NULL, 'Community Theater', NULL, NULL, 'default2', 'Community Theater', '2019'), ('unique_6', 'unique_6', 10, '%Y', '2019', '%Y', NULL, 'default1', NULL), ('unique_7', 'default2', 6, NULL, 'default2', '2019', '%Y', '%Y', 'Community Theater'), ('unique_8', 'unique_10', 8, '2019', 'default2', 'default2', 'Community Theater', 'default2', '2019'), ('unique_9', 'unique_11', 0, 'Community Theater', '%Y', '2019', NULL, 'default1', 'default1'), ('unique_10', 'unique_12', 0, '2019', 'default2', '2019', NULL, 'default2', NULL), ('unique_11', '%Y', NULL, 'default2', 'default2', 'default2', 'Community Theater', '%Y', 'Community Theater'), ('unique_12', 'unique_5', 0, '%Y', 'Community Theater', NULL, 'default1', '%Y', '%Y'), ('unique_13', 'default2', 9, NULL, 'default1', 'default1', '%Y', NULL, '%Y'), ('unique_14', 'default2', 9, '%Y', 'Community Theater', 'default2', '%Y', '2019', 'Community Theater'), ('unique_15', 'unique_11', 6, NULL, 'default2', '%Y', NULL, '%Y', 'default2'), ('unique_16', 'unique_13', 2, 'default2', NULL, NULL, '2019', 'default2', NULL), ('unique_17', '2019', 7, 'default2', '2019', 'default2', '%Y', '%Y', 'default1'), ('unique_18', 'unique_15', 6, '%Y', 'default2', 'default2', '2019', 'Community Theater', NULL), ('unique_19', 'unique_6', 0, 'Community Theater', NULL, 'Community Theater', 'default1', '2019', NULL);
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default1', 'Community Theater', '2019', '2019', 'default1', 'default1', 'Community Theater'), ('%Y', 'default1', '2019', NULL, '2019', '2019', 'default2'), ('default2', 'Community Theater', 'Community Theater', NULL, 'default1', '2019', '%Y'), ('2019', 'default1', 'default2', 'Community Theater', '%Y', 'default1', '2019'), ('Community Theater', '2019', '2019', '2019', 'Community Theater', '%Y', 'default2'), ('unique_5', 'default1', 'Community Theater', 'default2', '2019', '%Y', 'default1'), ('unique_6', 'default2', 'Community Theater', '%Y', 'default1', '%Y', '%Y'), ('unique_7', 'Community Theater', NULL, '%Y', '2019', 'Community Theater', '2019'), ('unique_8', 'default2', '2019', 'Community Theater', 'default2', 'default1', 'default1'), ('unique_9', 'Community Theater', NULL, 'default1', 'default2', 'Community Theater', '2019'), ('unique_10', 'Community Theater', NULL, 'Community Theater', 'default2', 'Community Theater', '2019'), ('unique_11', 'default1', 'default1', 'Community Theater', 'default2', '%Y', NULL), ('unique_12', 'default1', 'default2', NULL, 'default2', NULL, NULL), ('unique_13', NULL, 'default2', 'default2', NULL, 'default1', 'Community Theater'), ('unique_14', NULL, 'Community Theater', '2019', 'Community Theater', 'Community Theater', 'default1'), ('unique_15', '%Y', 'default2', '%Y', '2019', NULL, 'default1'), ('unique_16', '2019', 'default1', 'Community Theater', '%Y', NULL, 'default2'), ('unique_17', '2019', 'default2', 'default2', '%Y', 'default2', 'default2');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('unique_11', 'unique_10'), ('Community Theater', 'unique_8'), ('unique_8', 'unique_19'), ('unique_10', 'unique_16'), ('unique_17', 'unique_5'), ('unique_17', '2019'), ('default1', 'unique_19'), ('unique_16', '2019'), ('unique_12', 'default1'), ('default2', '%Y'), ('%Y', 'unique_16'), ('unique_15', 'unique_11'), ('unique_5', 'unique_10'), ('default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.link_to_member) FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event WHERE T1.event_name = 'Community Theater' AND SUBSTRING(T1.event_date, 1, 4) = '2019';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(T2.link_to_member) FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event WHERE T1.event_name = 'Community Theater' AND STRFTIME('%Y', T1.event_date) = '2019';

/*
Prediction Result:
(0,)
*/
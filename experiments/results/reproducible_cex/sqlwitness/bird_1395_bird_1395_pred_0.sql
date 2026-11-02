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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (4, '2019', '2019', NULL, 'default1', 'Community Theater'), (0, 'default1', '%Y', '%Y', 'default2', 'default2'), (2, 'Community Theater', '2019', 'default1', '%Y', '%Y'), (5, '2019', '2019', '%Y', '2019', 'default1'), (1, 'Community Theater', '%Y', '%Y', 'default1', 'default1'), (3, '%Y', NULL, 'default2', '%Y', '%Y'), (6, '2019', '%Y', '%Y', NULL, 'default2'), (7, NULL, 'Community Theater', '2019', 'default2', 'Community Theater'), (8, NULL, NULL, 'default2', 'default2', '2019');
INSERT INTO major (major_id, major_name, department, college) VALUES ('default2', 'default1', NULL, '%Y'), ('default1', '2019', '%Y', 'default2'), ('%Y', '%Y', 'Community Theater', '2019'), ('2019', '%Y', '%Y', 'Community Theater'), ('Community Theater', 'Community Theater', 'Community Theater', 'default1'), ('unique_5', 'Community Theater', '2019', '2019'), ('unique_6', 'default1', '%Y', '%Y'), ('unique_7', NULL, 'Community Theater', 'default2'), ('unique_8', 'Community Theater', NULL, '2019'), ('unique_9', 'Community Theater', 'Community Theater', '%Y'), ('unique_10', '2019', 'Community Theater', '%Y'), ('unique_11', '%Y', '%Y', 'default1'), ('unique_12', NULL, NULL, 'default2'), ('unique_13', 'Community Theater', 'Community Theater', NULL), ('unique_14', 'default1', '%Y', NULL), ('unique_15', 'default1', NULL, 'default2'), ('unique_16', '%Y', NULL, NULL);
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default2', 'unique_12', 6, 'Community Theater', NULL, 'default1', 'Community Theater', 'default1', 'Community Theater'), ('default1', 'unique_16', 7, '%Y', NULL, '%Y', '%Y', 'default1', 'Community Theater'), ('%Y', NULL, 2, NULL, '2019', 'Community Theater', '2019', NULL, '2019'), ('2019', 'unique_14', 0, '2019', 'default2', 'default1', '2019', '2019', 'default1'), ('Community Theater', 'default2', 0, 'default2', 'default2', 'default1', '%Y', '%Y', '%Y'), ('unique_5', 'unique_5', 5, 'default2', 'default1', 'Community Theater', NULL, 'default1', '2019'), ('unique_6', 'unique_5', 5, 'default2', 'default1', 'default2', NULL, NULL, NULL), ('unique_7', 'unique_14', 4, '2019', '%Y', 'Community Theater', NULL, NULL, '2019');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default2', 'Community Theater', '2019', '2019', 'Community Theater', 'default2', 'Community Theater'), ('default1', 'Community Theater', '%Y', NULL, '%Y', 'default1', 'default2'), ('Community Theater', '2019', 'Community Theater', '%Y', 'Community Theater', 'default2', 'default2'), ('2019', '2019', 'default1', '%Y', 'default1', 'default1', 'Community Theater'), ('%Y', 'default2', '2019', 'default2', '2019', 'default2', 'Community Theater'), ('unique_5', '2019', '%Y', NULL, NULL, 'default2', 'default2'), ('unique_6', NULL, 'Community Theater', NULL, '%Y', NULL, 'default2'), ('unique_7', 'default1', '2019', 'default1', '%Y', '2019', 'Community Theater'), ('unique_8', NULL, NULL, '2019', 'Community Theater', 'default2', '2019');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('2019', 'unique_7'), ('default2', 'unique_6'), ('Community Theater', 'unique_7'), ('Community Theater', 'unique_5'), ('default2', 'default1'), ('unique_8', 'default2'), ('%Y', 'unique_7'), ('unique_6', '%Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.link_to_member) FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event WHERE T1.event_name = 'Community Theater' AND SUBSTRING(T1.event_date, 1, 4) = '2019';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT link_to_member) FROM attendance AS T1 INNER JOIN event AS T2 ON T1.link_to_event = T2.event_id WHERE T2.event_name = 'Community Theater' AND STRFTIME('%Y', T2.event_date) = '2019';

/*
Prediction Result:
(0,)
*/
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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (2, 'Meeting', '2020', NULL, 'default1', 'default1'), (1, 'Meeting', 'default1', 'default2', 'default1', '%Y'), (0, '%Y', 'default1', 'default2', 'default1', '%Y'), (3, NULL, 'default2', NULL, NULL, NULL);
INSERT INTO major (major_id, major_name, department, college) VALUES ('Meeting', '%Y', 'default1', 'default1'), ('default1', 'default2', 'default2', '2020'), ('%Y', NULL, 'default2', '%Y'), ('2020', NULL, 'default1', 'Meeting'), ('default2', 'Meeting', '2020', 'default1'), ('unique_5', '%Y', 'default1', '2020'), ('unique_6', NULL, 'default2', 'default1'), ('unique_7', 'Meeting', 'default2', NULL), ('unique_8', NULL, NULL, '%Y'), ('unique_9', '%Y', NULL, 'Meeting'), ('unique_10', NULL, '2020', NULL), ('unique_11', NULL, 'default1', 'default2'), ('unique_12', 'default1', 'default2', '%Y'), ('unique_13', '%Y', 'default2', '2020'), ('unique_14', '%Y', 'default2', 'default1'), ('unique_15', 'Meeting', NULL, 'Meeting'), ('unique_16', 'default2', NULL, '%Y'), ('unique_17', 'default2', 'default1', '2020'), ('unique_18', 'default2', 'Meeting', '%Y'), ('unique_19', 'Meeting', 'default2', '%Y'), ('unique_20', '%Y', 'default2', 'default2'), ('unique_21', 'default2', NULL, '2020'), ('unique_22', '2020', 'default2', '2020'), ('unique_23', 'Meeting', '2020', 'default1'), ('unique_24', '2020', 'Meeting', 'default2'), ('unique_25', '2020', 'Meeting', 'default1'), ('unique_26', '2020', '%Y', 'default1'), ('unique_27', 'default2', 'default2', '2020'), ('unique_28', 'default2', 'default2', '2020'), ('unique_29', 'default1', NULL, NULL), ('unique_30', '2020', NULL, '%Y'), ('unique_31', 'default1', 'default2', 'default2'), ('unique_32', '%Y', 'default1', 'default1'), ('unique_33', 'Meeting', '2020', 'Meeting'), ('unique_34', '%Y', '2020', 'default2'), ('unique_35', 'default2', NULL, 'default2'), ('unique_36', '%Y', 'default2', '%Y'), ('unique_37', '2020', 'default1', 'Meeting'), ('unique_38', '%Y', 'default1', '%Y');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('2020', 'unique_29', NULL, 'default1', '%Y', NULL, '2020', '2020', 'Meeting'), ('default1', 'unique_29', 1, 'Meeting', '2020', NULL, 'Meeting', 'Meeting', 'Meeting'), ('%Y', 'unique_34', 2, 'Meeting', NULL, NULL, 'Meeting', '%Y', NULL), ('Meeting', 'default2', 0, 'Meeting', 'default1', '%Y', 'default1', '2020', '2020'), ('default2', 'unique_17', 0, 'default1', '%Y', 'Meeting', 'Meeting', 'Meeting', 'Meeting'), ('unique_5', 'unique_35', 2, 'default2', 'default1', '%Y', 'Meeting', 'Meeting', 'Meeting'), ('unique_6', 'unique_24', 1, '2020', NULL, '%Y', 'Meeting', 'default2', '2020'), ('unique_7', 'unique_9', 3, 'default2', 'default1', '2020', '2020', '%Y', 'default2'), ('unique_8', 'unique_21', 3, 'Meeting', 'default1', '2020', 'default2', 'default1', 'default1'), ('unique_9', 'Meeting', 0, '2020', NULL, 'Meeting', 'Meeting', NULL, NULL), ('unique_10', 'unique_11', 1, 'Meeting', '%Y', '2020', 'default2', 'Meeting', 'default1'), ('unique_11', 'unique_14', 0, '%Y', 'Meeting', 'Meeting', 'default1', '%Y', '2020'), ('unique_12', 'unique_32', 3, NULL, '%Y', '2020', '2020', 'default2', '%Y'), ('unique_13', 'unique_32', NULL, 'default2', 'default1', 'Meeting', '%Y', 'default1', 'default2'), ('unique_14', 'unique_24', 0, NULL, 'default2', 'default2', 'default2', '2020', '%Y'), ('unique_15', 'unique_23', 0, '2020', NULL, 'default1', 'default1', 'default2', 'default2'), ('unique_16', 'unique_36', 2, 'Meeting', '%Y', NULL, 'Meeting', NULL, 'default2'), ('unique_17', 'unique_12', 2, 'default2', '%Y', '2020', 'default2', NULL, 'default2'), ('unique_18', 'unique_30', 0, 'default2', '%Y', '2020', 'default1', 'default1', 'default2'), ('unique_19', 'unique_37', 0, NULL, 'default2', 'default1', NULL, 'default1', 'default2'), ('unique_20', 'unique_34', NULL, 'default1', NULL, NULL, 'default2', '%Y', '2020'), ('unique_21', 'unique_30', 2, '2020', '%Y', NULL, NULL, '%Y', 'Meeting'), ('unique_22', 'unique_19', 1, NULL, '2020', NULL, NULL, '2020', 'Meeting'), ('unique_23', 'unique_23', NULL, NULL, 'Meeting', 'default1', 'default2', 'Meeting', 'default1'), ('unique_24', 'unique_31', NULL, 'default2', 'Meeting', '2020', 'Meeting', 'Meeting', 'Meeting'), ('unique_25', 'unique_27', NULL, NULL, 'default1', '%Y', '2020', 'default2', '%Y'), ('unique_26', 'unique_14', 3, '%Y', '%Y', 'default2', '%Y', 'Meeting', '2020'), ('unique_27', 'unique_33', NULL, NULL, 'default1', NULL, 'default2', 'default1', 'default2'), ('unique_28', 'unique_19', 1, 'default1', 'Meeting', 'Meeting', '%Y', 'default1', NULL), ('unique_29', 'unique_34', NULL, '%Y', '2020', '2020', 'default2', '%Y', 'default2'), ('unique_30', 'unique_38', 1, '%Y', 'default1', NULL, '%Y', NULL, '2020'), ('unique_31', 'unique_30', 0, 'default2', NULL, NULL, 'default2', '2020', NULL);
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('%Y', 'default1', 'Meeting', NULL, '2020', 'default2', NULL), ('Meeting', '2020', 'Meeting', '%Y', '%Y', 'default1', 'default2'), ('default1', 'default1', NULL, '%Y', NULL, 'default1', 'Meeting'), ('default2', NULL, NULL, 'Meeting', 'default1', 'Meeting', 'default1'), ('2020', NULL, '2020', 'Meeting', '2020', '%Y', 'default1'), ('unique_5', NULL, NULL, 'default1', 'default1', NULL, '2020'), ('unique_6', '%Y', '2020', '%Y', NULL, 'Meeting', '2020'), ('unique_7', '%Y', 'default2', '%Y', '%Y', 'default1', 'Meeting'), ('unique_8', 'default2', 'default1', '%Y', '%Y', '%Y', NULL);
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('default2', 'unique_18'), ('unique_7', 'unique_26'), ('unique_6', '2020'), ('unique_6', 'unique_13'), ('unique_7', 'Meeting'), ('unique_7', 'unique_24'), ('2020', 'default1'), ('unique_5', 'unique_22'), ('2020', 'unique_6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(T2.link_to_event) AS REAL) / COUNT(DISTINCT T2.link_to_event) FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event WHERE SUBSTRING(T1.event_date, 1, 4) = '2020' AND T1.type = 'Meeting';

/*
Gold Result:
(2.0,)
*/

-- Prediction Query
SELECT CAST(COUNT(e.event_id) AS REAL) / COUNT(DISTINCT e.event_name) AS average_attendance FROM event AS e JOIN attendance AS a ON e.event_id = a.link_to_event WHERE e.type = 'Meeting' AND STRFTIME('%Y', e.event_date) = '2020';

/*
Prediction Result:
(None,)
*/
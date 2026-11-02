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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (2, NULL, NULL, 'default1', 'default1', 'default2'), (1, 'default2', NULL, 'default2', 'default1', 'default2'), (0, NULL, 'default1', NULL, NULL, 'default1'), (3, 'default1', 'default1', 'default1', 'default1', 'default1'), (4, NULL, NULL, 'default1', 'default1', NULL);
INSERT INTO major (major_id, major_name, department, college) VALUES ('default2', 'default1', 'default2', 'default1'), ('default1', NULL, 'default1', 'default2'), ('unique_2', 'default1', NULL, 'default2'), ('unique_3', 'default1', 'default2', 'default1'), ('unique_4', 'default1', 'default1', NULL), ('unique_5', 'default1', 'default1', 'default1'), ('unique_6', 'default1', NULL, NULL), ('unique_7', 'default1', 'default1', NULL), ('unique_8', NULL, 'default1', NULL), ('unique_9', 'default1', 'default1', 'default1'), ('unique_10', 'default2', 'default1', 'default2'), ('unique_11', 'default2', NULL, NULL), ('unique_12', NULL, NULL, NULL), ('unique_13', NULL, 'default2', NULL), ('unique_14', 'default1', 'default1', NULL), ('unique_15', 'default1', NULL, NULL), ('unique_16', 'default1', 'default2', 'default1'), ('unique_17', 'default1', 'default2', 'default2'), ('unique_18', NULL, 'default2', NULL), ('unique_19', 'default2', 'default1', 'default2'), ('unique_20', 'default1', 'default1', 'default1'), ('unique_21', 'default1', 'default2', 'default2'), ('unique_22', NULL, NULL, NULL), ('unique_23', 'default1', NULL, NULL), ('unique_24', NULL, NULL, 'default1'), ('unique_25', 'default2', 'default2', 'default1'), ('unique_26', 'default2', 'default1', 'default1'), ('unique_27', 'default2', NULL, 'default1'), ('unique_28', NULL, 'default2', 'default1'), ('unique_29', NULL, 'default1', NULL), ('unique_30', 'default2', NULL, 'default1'), ('unique_31', NULL, NULL, 'default2'), ('unique_32', NULL, NULL, NULL), ('unique_33', 'default1', 'default1', 'default2');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default1', 'unique_29', NULL, 'default2', 'default1', 'default1', NULL, NULL, 'default1'), ('default2', 'unique_6', 2, NULL, 'default1', 'default2', 'default2', 'default2', NULL), ('unique_2', 'unique_27', NULL, 'default2', 'default1', 'default2', 'default2', 'default1', 'default1'), ('unique_3', 'default1', 2, 'default1', NULL, 'default2', NULL, 'default2', NULL), ('unique_4', 'unique_3', 3, 'default1', NULL, 'default2', NULL, NULL, 'default2'), ('unique_5', 'unique_14', 2, 'default2', 'default1', 'default2', 'default1', 'default1', 'default1'), ('unique_6', 'unique_28', 4, 'default1', 'default2', 'default1', 'default2', NULL, NULL), ('unique_7', 'unique_4', 1, NULL, 'default1', 'default2', NULL, NULL, 'default1'), ('unique_8', 'unique_7', 0, NULL, 'default1', NULL, NULL, 'default1', 'default1'), ('unique_9', 'unique_28', NULL, 'default2', NULL, 'default1', 'default2', NULL, 'default1'), ('unique_10', 'unique_2', 3, 'default1', NULL, 'default2', 'default2', 'default1', 'default1');
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default1', NULL, NULL, NULL, 'default1', NULL, 'default1'), ('default2', 'default1', 'default2', NULL, NULL, NULL, 'default2'), ('unique_2', NULL, 'default1', NULL, NULL, NULL, NULL), ('unique_3', NULL, 'default1', NULL, 'default1', 'default1', 'default2'), ('unique_4', 'default1', NULL, 'default2', NULL, NULL, 'default1'), ('unique_5', 'default1', NULL, 'default2', NULL, NULL, NULL), ('unique_6', 'default1', NULL, 'default1', 'default1', NULL, 'default2'), ('unique_7', NULL, 'default1', 'default2', 'default1', 'default1', NULL), ('unique_8', 'default1', NULL, NULL, 'default2', NULL, NULL), ('unique_9', 'default1', NULL, 'default2', NULL, 'default2', 'default1'), ('unique_10', NULL, 'default1', 'default1', 'default1', 'default2', 'default1'), ('unique_11', NULL, 'default1', 'default2', 'default1', 'default2', NULL), ('unique_12', 'default2', 'default1', NULL, 'default1', NULL, 'default1');
INSERT INTO attendance (link_to_event, link_to_member) VALUES ('unique_2', 'unique_7'), ('unique_5', 'unique_10'), ('unique_9', 'unique_5'), ('unique_5', 'unique_5'), ('unique_12', 'unique_7'), ('unique_10', 'default2'), ('unique_7', 'unique_4'), ('default1', 'default1'), ('unique_12', 'unique_9'), ('unique_10', 'unique_3'), ('unique_11', 'unique_9');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event GROUP BY T1.event_name ORDER BY COUNT(T2.link_to_event) DESC, T1.event_name NULLS LAST LIMIT 1;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT T1.event_name FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event GROUP BY T1.event_id ORDER BY COUNT(T2.link_to_member) DESC, T1.event_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/
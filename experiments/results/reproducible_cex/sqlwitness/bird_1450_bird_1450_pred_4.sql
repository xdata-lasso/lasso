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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (39, 'default1', NULL, 'default2', 'default2', 'default1'), (0, 'default1', 'default1', NULL, 'default1', 'default1'), (40, 'default1', 'default2', 'default1', NULL, NULL), (41, 'default1', NULL, 'default2', 'default2', NULL), (1, 'default1', 'default1', NULL, NULL, 'default1'), (2, 'default1', 'default2', NULL, 'default1', 'default1');
INSERT INTO major (major_id, major_name, department, college) VALUES ('default2', NULL, 'default2', 'default2'), ('default1', 'default2', 'default2', 'default2');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('default2', NULL, 2, 'default1', NULL, 'default1', 'default2', NULL, NULL), ('default1', NULL, 39, NULL, NULL, NULL, NULL, NULL, NULL), ('unique_2', 'default1', 2, 'default2', NULL, 'default1', 'default2', 'default1', NULL), ('unique_3', 'default1', 2, NULL, NULL, 'default1', 'default2', 'default1', 'default1'), ('unique_4', NULL, NULL, NULL, 'default1', NULL, 'default2', 'default1', 'default1'), ('unique_5', NULL, 2, NULL, 'default1', NULL, NULL, NULL, NULL), ('unique_6', 'default2', 1, 'default1', NULL, 'default2', 'default1', NULL, NULL);
INSERT INTO income (income_id, link_to_member, date_received, amount, source, notes) VALUES ('default1', 'unique_2', 'default2', 41, 'default2', 'default2'), ('default2', 'default2', NULL, NULL, 'default2', 'default2'), ('unique_2', 'default1', 'default2', 1, NULL, NULL), ('unique_3', 'unique_4', NULL, 1, 'default2', NULL), ('unique_4', 'unique_6', NULL, 0, 'default1', NULL), ('unique_5', 'unique_3', 'default1', 40, 'default2', NULL);
INSERT INTO event (event_id, event_name, event_date, type, notes, location, status) VALUES ('default2', NULL, 'default2', 'default1', 'default1', 'default2', 'default2'), ('default1', 'default1', 'default2', NULL, 'default2', 'default1', NULL), ('unique_2', 'default2', NULL, 'default1', 'default1', 'default2', 'default2'), ('unique_3', NULL, 'default2', NULL, 'default1', NULL, 'default1'), ('unique_4', 'default1', 'default2', 'default2', NULL, 'default2', NULL), ('unique_5', 'default2', 'default1', 'default2', 'default1', 'default1', 'default2'), ('unique_6', 'default1', NULL, 'default2', NULL, 'default2', 'default2'), ('unique_7', 'default2', 'default1', NULL, NULL, NULL, 'default2'), ('unique_8', 'default1', NULL, NULL, 'default1', 'default1', NULL), ('unique_9', NULL, 'default1', NULL, NULL, 'default1', 'default2');
INSERT INTO budget (budget_id, link_to_event, category, spent, remaining, amount, event_status) VALUES ('default2', 'unique_9', 'default2', 0.0, 40.0, 39, 'default1'), ('default1', 'default1', 'default1', 41.0, 41.0, 41, 'default2'), ('unique_2', 'unique_9', NULL, NULL, 39.0, NULL, 'default1'), ('unique_3', NULL, 'default1', 0.0, NULL, 41, NULL), ('unique_4', 'default2', 'default1', NULL, 39.0, 40, NULL), ('unique_5', 'unique_2', 'default2', 39.0, 39.0, 41, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.city, T3.county FROM income AS T1 INNER JOIN member AS T2 ON T1.link_to_member = T2.member_id INNER JOIN zip_code AS T3 ON T3.zip_code = T2.zip WHERE T1.amount > 40;

/*
Gold Result:
('default2', None)
*/

-- Prediction Query
SELECT z.city, z.county FROM event AS e JOIN budget AS b ON e.event_id = b.link_to_event JOIN income AS i ON b.link_to_event = e.event_id JOIN member AS m ON i.link_to_member = m.member_id JOIN zip_code AS z ON m.zip = z.zip_code GROUP BY e.event_id HAVING COUNT(i.income_id) > 40;

/*
Prediction Result:
*/
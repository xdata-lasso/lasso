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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (0, 'default2', '2019-09-01', '%Y-%m', '%Y-%m', '2019-09-01'), (1, '%Y-%m', '2019-09-01', '%Y-%m', '2019-09-30', '2019-09'), (2, '2019-09-30', '2019-09-30', NULL, '%Y-%m', 'default1'), (3, '2019-09-30', '2019-09-30', 'default1', NULL, NULL), (4, 'default1', 'default2', NULL, '2019-09-30', '2019-09'), (5, NULL, '%Y-%m', 'default2', '%Y-%m', '2019-09-01'), (6, 'default1', '%Y-%m', '2019-09-30', '%Y-%m', '2019-09'), (7, '2019-09-30', '2019-09-01', '2019-09', 'default1', '%Y-%m'), (8, '%Y-%m', '2019-09', 'default2', 'default2', 'default2'), (9, NULL, NULL, '%Y-%m', 'default2', 'default2'), (10, 'default2', 'default2', '2019-09', 'default1', '2019-09-30'), (11, '2019-09', '2019-09-30', 'default1', '%Y-%m', '%Y-%m'), (12, '2019-09-01', 'default1', 'default1', '%Y-%m', 'default1'), (13, '2019-09-01', '%Y-%m', 'default2', 'default2', '2019-09-01'), (14, NULL, '2019-09', '2019-09-30', '2019-09', NULL), (15, 'default2', '2019-09', '2019-09', 'default1', 'default2'), (16, NULL, '2019-09', NULL, '%Y-%m', '2019-09-01'), (17, '%Y-%m', 'default2', NULL, 'default2', 'default1'), (18, 'default2', NULL, '%Y-%m', '%Y-%m', '2019-09-01');
INSERT INTO major (major_id, major_name, department, college) VALUES ('2019-09', '2019-09-01', NULL, 'default2'), ('default2', '2019-09', '2019-09-01', 'default2'), ('2019-09-01', NULL, '2019-09-01', '2019-09-01'), ('default1', '2019-09-30', 'default1', '2019-09'), ('%Y-%m', '2019-09-01', '2019-09', '%Y-%m'), ('2019-09-30', '2019-09-30', 'default2', '2019-09-30'), ('unique_6', '2019-09', 'default1', '2019-09'), ('unique_7', '%Y-%m', NULL, 'default1'), ('unique_8', 'default2', '2019-09-01', '%Y-%m'), ('unique_9', '%Y-%m', 'default1', 'default1'), ('unique_10', NULL, '2019-09', NULL), ('unique_11', '%Y-%m', '%Y-%m', '%Y-%m');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('2019-09', 'default1', 16, '2019-09-30', 'default2', '2019-09-01', '2019-09-01', '%Y-%m', '%Y-%m'), ('2019-09-01', 'unique_8', 6, NULL, NULL, '2019-09-30', '2019-09', NULL, NULL);
INSERT INTO income (income_id, link_to_member, date_received, amount, source, notes) VALUES ('%Y-%m', '2019-09-01', '2019-09-30', 0, NULL, '2019-09-01'), ('2019-09-30', NULL, '2019-09-30', NULL, '2019-09', '2019-09'), ('default2', '2019-09', 'default1', 2, '2019-09-30', '2019-09-01'), ('2019-09', NULL, 'default1', 0, '2019-09-30', 'default2'), ('2019-09-01', NULL, '2019-09-01', 1, '%Y-%m', '2019-09-30'), ('default1', '2019-09-01', '2019-09-30', NULL, '%Y-%m', '%Y-%m'), ('unique_6', NULL, '2019-09-01', 1, '2019-09', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT source FROM income WHERE date_received BETWEEN '2019-09-01' AND '2019-09-30' ORDER BY source DESC, income.income_id NULLS LAST LIMIT 1;

/*
Gold Result:
('2019-09',)
*/

-- Prediction Query
SELECT source FROM income WHERE STRFTIME('%Y-%m', date_received) = '2019-09' GROUP BY source ORDER BY SUM(amount) DESC, source NULLS LAST LIMIT 1;

/*
Prediction Result:
('%Y-%m',)
*/
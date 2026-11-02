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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (2, NULL, 'default2', 'default2', '2019-09-30', 'default1'), (0, '2019-09-01', NULL, '2019-09-30', '2019-09-01', '2019-09-01'), (1, 'default2', NULL, NULL, 'default1', NULL), (3, NULL, 'default2', 'default1', 'default1', 'default2'), (4, 'default2', 'default1', 'default2', 'default2', '2019-09-30'), (5, 'default1', NULL, 'default1', '2019-09-01', 'default2'), (6, '2019-09-30', '2019-09-01', NULL, '2019-09-30', NULL), (7, '2019-09-30', 'default2', NULL, 'default2', '2019-09-01');
INSERT INTO major (major_id, major_name, department, college) VALUES ('default2', '2019-09-30', '2019-09-30', '2019-09-30'), ('default1', 'default1', NULL, 'default1'), ('2019-09-01', NULL, 'default1', 'default1');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('2019-09-30', NULL, 7, 'default1', '2019-09-30', '2019-09-01', 'default1', '2019-09-30', '2019-09-01'), ('default1', '2019-09-01', 2, '2019-09-30', '2019-09-01', '2019-09-01', '2019-09-30', NULL, 'default1'), ('default2', 'default2', 1, 'default1', NULL, '2019-09-01', '2019-09-30', NULL, NULL), ('2019-09-01', NULL, 1, 'default2', '2019-09-30', 'default2', '2019-09-30', '2019-09-01', '2019-09-30'), ('unique_4', 'default1', 3, NULL, '2019-09-30', 'default2', 'default2', NULL, '2019-09-30'), ('unique_5', 'default2', 4, 'default2', 'default2', NULL, 'default1', 'default1', '2019-09-01'), ('unique_6', NULL, 3, NULL, 'default2', '2019-09-01', '2019-09-01', 'default2', 'default2'), ('unique_7', '2019-09-01', 2, '2019-09-30', 'default2', 'default1', 'default1', NULL, '2019-09-01'), ('unique_8', 'default2', 6, '2019-09-01', 'default1', '2019-09-01', '2019-09-01', 'default2', '2019-09-30'), ('unique_9', 'default1', 3, '2019-09-30', 'default1', '2019-09-30', 'default2', '2019-09-01', 'default1'), ('unique_10', NULL, 5, NULL, 'default1', NULL, '2019-09-01', 'default1', '2019-09-30');
INSERT INTO income (income_id, link_to_member, date_received, amount, source, notes) VALUES ('default1', NULL, 'default2', 0, NULL, NULL), ('2019-09-01', 'unique_10', 'default1', NULL, 'default2', '2019-09-30'), ('default2', 'unique_5', 'default1', 0, '2019-09-30', 'default2'), ('2019-09-30', NULL, NULL, 0, NULL, 'default2'), ('unique_4', 'unique_7', '2019-09-30', 2, 'default1', '2019-09-30'), ('unique_5', '2019-09-30', NULL, 0, 'default1', '2019-09-30'), ('unique_6', 'unique_6', 'default1', 1, NULL, 'default2'), ('unique_7', '2019-09-30', '2019-09-30', 2, 'default2', 'default2'), ('unique_8', '2019-09-01', '2019-09-30', 1, 'default2', '2019-09-01'), ('unique_9', 'unique_9', 'default2', 1, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT source FROM income WHERE date_received BETWEEN '2019-09-01' AND '2019-09-30' ORDER BY source DESC, income.income_id NULLS LAST LIMIT 1;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT source FROM income WHERE date_received BETWEEN '2019-09-01' AND '2019-09-30' ORDER BY amount DESC, income.income_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/
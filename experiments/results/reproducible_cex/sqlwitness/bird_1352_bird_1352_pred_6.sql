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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (0, 'default2', 'Medium', 'Large', 'Large', 'Medium'), (1, 'default2', 'default2', 'Human Development AND Family Studies', 'default2', 'Business'), (2, 'default1', 'Business', 'default1', 'Large', NULL), (3, 'Large', 'Human Development AND Family Studies', 'Business', 'default2', 'Business'), (4, 'Medium', NULL, 'default2', NULL, NULL), (5, 'default2', 'Business', 'Human Development AND Family Studies', 'Human Development AND Family Studies', 'Human Development AND Family Studies'), (6, 'Human Development AND Family Studies', NULL, 'Medium', 'default1', 'Large'), (7, NULL, 'Medium', 'Business', 'default2', 'Human Development AND Family Studies'), (8, NULL, 'Medium', 'default1', 'Business', 'Large'), (9, 'Large', 'default2', 'Human Development AND Family Studies', 'Business', 'default2'), (10, 'Business', 'default1', 'Large', 'Medium', 'Medium'), (11, 'default1', 'Business', NULL, 'default2', 'Human Development AND Family Studies'), (12, 'default2', 'default1', 'Large', 'Human Development AND Family Studies', NULL);
INSERT INTO major (major_id, major_name, department, college) VALUES ('Large', 'Human Development AND Family Studies', 'Business', 'Human Development AND Family Studies'), ('Medium', 'default2', 'Human Development AND Family Studies', 'Business'), ('Business', 'Human Development AND Family Studies', 'Human Development AND Family Studies', 'Human Development AND Family Studies'), ('default2', 'Medium', 'Medium', 'default2'), ('Human Development AND Family Studies', 'Medium', 'Business', NULL), ('default1', 'Human Development AND Family Studies', 'Medium', 'default2'), ('unique_6', 'Human Development AND Family Studies', 'Medium', 'Medium');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('Human Development AND Family Studies', 'unique_6', 12, 'default2', 'default2', 'Business', 'Large', 'Medium', 'Large'), ('default1', 'Human Development AND Family Studies', 9, 'default1', 'Large', 'Large', 'default1', 'Human Development AND Family Studies', 'Large'), ('default2', 'Human Development AND Family Studies', 5, NULL, 'Human Development AND Family Studies', NULL, 'Medium', NULL, 'default2'), ('Large', 'unique_6', NULL, 'Medium', 'Large', 'Medium', 'Human Development AND Family Studies', 'default2', 'default1'), ('Medium', 'default1', 12, 'Human Development AND Family Studies', 'Human Development AND Family Studies', 'default1', NULL, 'default2', 'Large'), ('Business', NULL, 10, 'Medium', 'Large', 'default2', 'default2', 'Human Development AND Family Studies', 'Large'), ('unique_6', 'default1', 1, 'default2', 'Business', NULL, 'default1', 'Human Development AND Family Studies', 'default1'), ('unique_7', 'unique_6', 3, NULL, 'Business', NULL, 'Large', 'default2', 'Business'), ('unique_8', 'default2', 4, 'default2', NULL, 'Human Development AND Family Studies', 'Human Development AND Family Studies', 'default2', 'Business'), ('unique_9', 'Human Development AND Family Studies', 11, 'Large', 'Human Development AND Family Studies', 'Human Development AND Family Studies', 'Medium', 'Human Development AND Family Studies', 'Human Development AND Family Studies'), ('unique_10', 'Medium', 11, 'Human Development AND Family Studies', 'Large', 'Business', 'default2', NULL, NULL), ('unique_11', 'default1', 10, NULL, 'Medium', 'Business', 'default1', 'Large', 'default2'), ('unique_12', 'Medium', NULL, 'default1', 'Human Development AND Family Studies', 'Human Development AND Family Studies', 'Large', 'Business', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.member_id) FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T2.major_name = 'Human Development AND Family Studies' AND T1.t_shirt_size = 'Large';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(m.member_id) AS count FROM member AS m INNER JOIN major AS maj ON m.link_to_major = maj.major_id WHERE maj.major_name = 'Business' AND m.t_shirt_size = 'Medium';

/*
Prediction Result:
(0,)
*/
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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1, 'Medium', 'Large', 'Human Development AND Family Studies', 'Business', 'Large'), (0, 'Human Development AND Family Studies', 'Medium', 'Human Development AND Family Studies', 'Medium', 'Business'), (2, 'default1', 'default2', 'Medium', 'Human Development AND Family Studies', 'Medium'), (3, 'default2', 'default2', 'Large', 'Medium', 'Large'), (4, 'Medium', 'Large', 'Medium', 'default2', 'Business');
INSERT INTO major (major_id, major_name, department, college) VALUES ('Business', 'Human Development AND Family Studies', 'Medium', 'Business');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('Medium', 'Business', NULL, 'default2', 'Business', 'default2', NULL, 'Human Development AND Family Studies', 'default1'), ('default2', 'Business', 2, 'default2', 'default1', NULL, 'Medium', 'Large', 'default2'), ('default1', 'Business', 2, 'default2', 'Large', 'default2', 'default1', 'Medium', 'Human Development AND Family Studies'), ('Large', 'Business', NULL, 'Business', NULL, 'Human Development AND Family Studies', 'Large', NULL, 'Business'), ('Human Development AND Family Studies', 'Business', 2, 'Business', 'Business', 'Business', NULL, 'default1', 'default1'), ('Business', NULL, 0, NULL, 'Large', 'default2', 'default2', NULL, 'Large'), ('unique_6', NULL, 4, 'default2', 'Medium', NULL, NULL, 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.member_id) FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T2.major_name = 'Human Development AND Family Studies' AND T1.t_shirt_size = 'Large';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) AS medium_t_shirt_count FROM major AS T1 INNER JOIN member AS T2 ON T1.major_id = T2.link_to_major WHERE T1.major_name = 'Business' AND T2.t_shirt_size = 'Medium';

/*
Prediction Result:
(0,)
*/
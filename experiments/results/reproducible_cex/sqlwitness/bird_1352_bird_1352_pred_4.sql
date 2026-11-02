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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1, 'Human Development AND Family Studies', 'default1', 'default1', NULL, 'Large'), (0, 'Medium', NULL, 'Business', 'Medium', 'Business');
INSERT INTO major (major_id, major_name, department, college) VALUES ('default2', 'Business', 'default1', 'Large'), ('Large', 'Large', 'default1', 'Business'), ('Medium', 'Large', 'Large', 'default1'), ('Human Development AND Family Studies', 'Medium', 'default1', 'default1'), ('Business', 'Business', 'default1', 'Large'), ('default1', 'Human Development AND Family Studies', 'Medium', 'default1'), ('unique_6', 'Large', NULL, 'Business'), ('unique_7', 'Human Development AND Family Studies', 'Medium', 'default2'), ('unique_8', NULL, 'Large', 'Human Development AND Family Studies');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('Medium', 'default1', NULL, NULL, NULL, 'Medium', 'Medium', 'Medium', 'default2'), ('default1', 'unique_6', NULL, 'default1', 'Business', 'default2', 'default2', 'Human Development AND Family Studies', 'Medium'), ('Human Development AND Family Studies', 'unique_7', NULL, 'Large', 'Human Development AND Family Studies', 'Large', 'default2', 'Large', 'default2'), ('Business', 'unique_6', 0, 'Business', 'Medium', 'default1', 'Large', 'Large', 'default1'), ('Large', 'Human Development AND Family Studies', NULL, NULL, 'Human Development AND Family Studies', 'Human Development AND Family Studies', 'Medium', 'default2', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.member_id) FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T2.major_name = 'Human Development AND Family Studies' AND T1.t_shirt_size = 'Large';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM member JOIN major ON member.link_to_major = major.major_id WHERE major.major_name = 'Business' AND member.t_shirt_size = 'Medium';

/*
Prediction Result:
(0,)
*/
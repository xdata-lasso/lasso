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
INSERT INTO zip_code (zip_code, type, city, county, state, short_state) VALUES (1, 'default1', 'Large', 'Medium', NULL, 'default2'), (0, 'Large', NULL, 'Large', 'default2', 'default1'), (2, 'Business', 'default2', 'Medium', 'Business', 'default1'), (3, 'Medium', 'Business', 'Medium', 'Large', 'Large'), (4, 'Large', 'default2', 'default2', NULL, 'Large'), (5, 'Business', 'Human Development AND Family Studies', 'default1', 'default1', 'Large'), (6, 'Large', 'Large', 'Human Development AND Family Studies', 'Human Development AND Family Studies', 'default2'), (7, 'Large', 'default2', 'Medium', 'default2', 'default2'), (8, 'default1', 'default1', 'Medium', 'default1', NULL), (9, 'Medium', 'Medium', 'Business', 'Business', 'Human Development AND Family Studies'), (10, 'default2', 'Medium', 'Human Development AND Family Studies', 'Human Development AND Family Studies', 'Business');
INSERT INTO major (major_id, major_name, department, college) VALUES ('Business', 'Human Development AND Family Studies', NULL, NULL), ('default1', NULL, 'default2', NULL), ('Medium', 'Large', 'default1', 'default2'), ('Human Development AND Family Studies', 'default2', 'Human Development AND Family Studies', NULL), ('Large', 'default2', 'Human Development AND Family Studies', 'Medium'), ('default2', 'Human Development AND Family Studies', 'Business', 'Business'), ('unique_6', 'Medium', 'Large', 'Human Development AND Family Studies'), ('unique_7', 'Large', 'Business', 'Business'), ('unique_8', 'default2', 'Medium', NULL), ('unique_9', 'Medium', 'default1', 'Large'), ('unique_10', 'default2', 'Business', 'default2'), ('unique_11', 'default2', NULL, NULL), ('unique_12', 'Human Development AND Family Studies', 'Medium', 'Medium');
INSERT INTO member (member_id, link_to_major, zip, first_name, last_name, email, position, t_shirt_size, phone) VALUES ('Large', 'unique_12', 4, 'Human Development AND Family Studies', 'Medium', 'Business', 'Large', 'Large', 'default1'), ('default1', 'Business', 0, 'Human Development AND Family Studies', NULL, 'Large', 'Large', 'Business', NULL), ('default2', 'unique_11', 7, 'default1', 'Large', 'Human Development AND Family Studies', 'Business', 'default1', 'Medium'), ('Human Development AND Family Studies', 'unique_12', 7, 'Medium', 'Human Development AND Family Studies', 'Large', NULL, 'Human Development AND Family Studies', 'Human Development AND Family Studies'), ('Medium', 'Human Development AND Family Studies', 9, 'Large', 'Business', NULL, 'default1', 'Large', 'Large'), ('Business', 'default2', 0, 'Human Development AND Family Studies', 'default1', 'default2', 'Large', 'Human Development AND Family Studies', 'default2'), ('unique_6', 'unique_11', 3, 'Business', NULL, 'Business', 'Business', 'default1', 'default1'), ('unique_7', 'unique_9', 2, 'default1', 'default1', 'Human Development AND Family Studies', 'Large', 'Human Development AND Family Studies', 'Medium'), ('unique_8', 'unique_7', 9, 'Medium', 'default2', 'Medium', 'default2', 'Large', 'Business'), ('unique_9', 'unique_11', 1, 'Large', 'Business', 'Medium', NULL, 'default1', 'Medium'), ('unique_10', 'unique_8', 5, 'Business', 'Human Development AND Family Studies', 'Business', 'Human Development AND Family Studies', 'Large', 'Large'), ('unique_11', 'unique_9', NULL, 'default1', 'default1', 'default2', 'Business', 'Large', 'default1'), ('unique_12', 'Medium', 8, 'Large', 'Business', 'Large', 'Business', 'Medium', 'Large'), ('unique_13', 'unique_7', 8, 'Business', 'Business', 'Medium', 'default2', 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.member_id) FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T2.major_name = 'Human Development AND Family Studies' AND T1.t_shirt_size = 'Large';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT("member"."member_id") FROM "member" INNER JOIN "major" ON "member"."link_to_major" = "major"."major_id" WHERE "major"."major_name" = 'Business' AND "member"."t_shirt_size" = 'Medium';

/*
Prediction Result:
(0,)
*/
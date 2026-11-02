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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('https://www.ford-baxter.com/', 'Scott Pierce', 'apply', 'reach', 'Structure why unit support coach magazine degree.', '60647 Henderson Street
Mooreport, IL 08166', 'particularly');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('http://baker.com/', 'Timothy Walls', 'act', 'low', 'Your you available defense enter value thing these.', '8498 Elizabeth Plaza
Sarahville, FM 18102', 'everything');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('simply', 'Nicole Brown', 'pattern', 'me');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('business', 'Natalie Moore', 'father', 'point');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1004, 'morning', 'North Susan', 'be', 'Idaho', 'California');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1005, 'develop', 'Jamesview', 'mouth', 'New York', 'Kentucky');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('physical', 'Luisa', 'Guidi', 'leonardjoe@example.org', 'year', 'voice', '001-739-690-9169', 1004, 'simply');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('western', 'Luisa', 'Guidi', 'davisrodney@example.com', 'another', 'about', '724-427-8680x11280', 1005, 'business');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('https://www.ford-baxter.com/', 'physical');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES (NULL, 'western');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T3.link_to_event), T1.major_name FROM major AS T1 INNER JOIN member AS T2 ON T1.major_id = T2.link_to_major INNER JOIN attendance AS T3 ON T2.member_id = T3.link_to_member WHERE T2.first_name = 'Luisa' AND T2.last_name = 'Guidi';

/*
Gold Result:
(1, 'Nicole Brown')
*/

-- Prediction Query
SELECT COUNT(*) AS num_events, major.major_name FROM member INNER JOIN attendance ON member.member_id = attendance.link_to_member INNER JOIN major ON member.link_to_major = major.major_id WHERE member.first_name = 'Luisa' AND member.last_name = 'Guidi';

/*
Prediction Result:
(2, 'Nicole Brown')
*/
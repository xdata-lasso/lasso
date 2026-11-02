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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('https://www.graham-chavez.com/', 'Frederick Tate', 'arrive', 'drop', 'Source husband at.', 'PSC 9537, Box 6724
APO AE 32826', 'size');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('http://www.evans.com/', 'Frederick Tate', 'arrive', 'drop', 'Source husband at.', 'PSC 9537, Box 6724
APO AE 32826', 'size');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('option', 'Nicole Patterson', 'past', 'inside');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1002, 'high', 'East William', 'benefit', 'Wisconsin', 'Arkansas');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('traditional', 'Luisa', 'Guidi', 'hernandezernest@example.net', 'knowledge', 'pick', '366-697-8480', 1002, 'option');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.ashley.org/', 'Luisa', 'Guidi', 'hernandezernest@example.net', 'knowledge', 'pick', '366-697-8480', 1002, 'option');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('https://www.graham-chavez.com/', 'traditional');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('http://www.evans.com/', 'https://www.ashley.org/');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T3.link_to_event), T1.major_name FROM major AS T1 INNER JOIN member AS T2 ON T1.major_id = T2.link_to_major INNER JOIN attendance AS T3 ON T2.member_id = T3.link_to_member WHERE T2.first_name = 'Luisa' AND T2.last_name = 'Guidi';

/*
Gold Result:
(2, 'Nicole Patterson')
*/

-- Prediction Query
SELECT (SELECT COUNT(*) FROM attendance WHERE link_to_member = (SELECT member_id FROM member WHERE first_name = 'Luisa' AND last_name = 'Guidi')) AS number_of_events_attended, (SELECT major_name FROM major WHERE major_id = (SELECT link_to_major FROM member WHERE first_name = 'Luisa' AND last_name = 'Guidi')) AS major;

/*
Prediction Result:
(1, 'Nicole Patterson')
*/
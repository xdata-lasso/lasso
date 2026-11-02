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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('http://www.koch-decker.com/', 'Carla Gray', '2020', 'Meeting', 'Detail food shoulder argue start source husband.', '76724 John Points Suite 969
Coxberg, NY 65187', 'benefit');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('http://www.humphrey.com/', 'Carla Gray', '2020', 'Meeting', 'Detail food shoulder argue start source husband.', '76724 John Points Suite 969
Coxberg, NY 65187', 'benefit');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('someone', 'Brian Burton', 'structure', 'response');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1002, 'knowledge', 'South Patrickmouth', 'newspaper', 'Kentucky', 'Oklahoma');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('http://www.dyer.com/', 'Daniel', 'Graham', 'usmith@example.net', 'everyone', 'month', '001-728-914-8932x52880', 1002, 'someone');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('https://www.cannon.net/', 'Daniel', 'Graham', 'usmith@example.net', 'everyone', 'month', '001-728-914-8932x52880', 1002, 'someone');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('http://www.koch-decker.com/', 'http://www.dyer.com/');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('http://www.humphrey.com/', 'https://www.cannon.net/');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(T2.link_to_event) AS REAL) / COUNT(DISTINCT T2.link_to_event) FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event WHERE SUBSTRING(T1.event_date, 1, 4) = '2020' AND T1.type = 'Meeting';

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT CAST(COUNT(T1.event_id) AS REAL) / COUNT(DISTINCT T1.event_name) FROM event AS T1 INNER JOIN attendance AS T2 ON T1.event_id = T2.link_to_event WHERE T1.type = 'Meeting' AND SUBSTRING(T1.event_date, 1, 4) = '2020';

/*
Prediction Result:
(2.0,)
*/
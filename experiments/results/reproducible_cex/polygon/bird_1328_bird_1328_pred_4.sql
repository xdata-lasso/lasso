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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Law and Constitutional Studies18', 'Law and Constitutional Studies45', 'Law and Constitutional Studies45', 'Law and Constitutional Studies45', 'Law and Constitutional Studies45', 'Law and Constitutional Studies45', 'Law and Constitutional Studies45');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Law and Constitutional Studies17', 'Law and Constitutional Studies45', 'Law and Constitutional Studies45', 'Law and Constitutional Studies45', 'Law and Constitutional Studies45', 'Law and Constitutional Studies45', 'Law and Constitutional Studies45');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Law and Constitutional Studies45', 'Law and Constitutional Studies', 'Law and Constitutional Studies46', 'Law and Constitutional Studies47');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Law and Constitutional Studies19', 'Law and Constitutional Studies45', 'Law and Constitutional Studies45', 'Law and Constitutional Studies45');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (32, 'Law and Constitutional Studies45', 'Law and Constitutional Studies45', 'Law and Constitutional Studies45', 'Law and Constitutional Studies45', 'Law and Constitutional Studies45');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (39, 'Law and Constitutional Studies45', 'Law and Constitutional Studies45', 'Law and Constitutional Studies45', 'Law and Constitutional Studies45', 'Law and Constitutional Studies45');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Law and Constitutional Studies18', 'Law and Constitutional Studies38');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Law and Constitutional Studies22', 'Law and Constitutional Studies17', 'Law and Constitutional Studies45', 45, 45, 45, 'Law and Constitutional Studies45');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Law and Constitutional Studies21', NULL, 'Law and Constitutional Studies45', 45, 45, 45, 'Law and Constitutional Studies45');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Law and Constitutional Studies23', 'Law and Constitutional Studies21', 'Law and Constitutional Studies38', 'Law and Constitutional Studies45', 'Law and Constitutional Studies45', 45, 'Law and Constitutional Studies45');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Law and Constitutional Studies26', NULL, 'Law and Constitutional Studies45', 45, 'Law and Constitutional Studies45', 'Law and Constitutional Studies45');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Law and Constitutional Studies25', 'Law and Constitutional Studies38', 'Law and Constitutional Studies45', 45, 'Law and Constitutional Studies45', 'Law and Constitutional Studies45');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Law and Constitutional Studies31', 'Law and Constitutional Studies45', 32, 'Law and Constitutional Studies33', NULL, 'Law and Constitutional Studies34', NULL, 'Law and Constitutional Studies36', 'Law and Constitutional Studies37');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Law and Constitutional Studies38', 'Law and Constitutional Studies45', 39, 'Law and Constitutional Studies40', NULL, 'Law and Constitutional Studies41', 'Law and Constitutional Studies42', 'Law and Constitutional Studies43', 'Law and Constitutional Studies44');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.last_name FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T2.major_name = 'Law and Constitutional Studies';

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT DISTINCT member.last_name FROM member INNER JOIN major ON member.link_to_major = major.major_id WHERE major.major_name = 'Law and Constitutional Studies';

/*
Prediction Result:
(None,)
*/
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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Medium17', 'Business18', 'Business18', 'Business18', 'Business18', 'Business18', 'Business18');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Business16', 'Business18', 'Business18', 'Business18', 'Business18', 'Business18', 'Business18');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Business18', 'Business', 'Medium45', 'Business46');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (19, 'Business18', 'Business18', 'Business18', 'Business18', 'Business18');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (28, 'Business18', 'Business18', 'Business18', 'Business18', 'Business18');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Business16', 'Business20');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Medium17', 'Medium21');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Medium23', 'Business16', 'Business18', 18, 18, 18, 'Business18');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Business22', NULL, 'Business18', 18, 18, 18, 'Business18');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Medium25', 'Medium23', 'Medium21', 'Business18', 'Business18', 18, 'Business18');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Business24', 'Business22', 'Medium21', 'Business18', 'Business18', 18, 'Business18');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Medium27', 'Medium21', 'Business18', 18, 'Business18', 'Business18');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Business26', 'Medium21', 'Business18', 18, 'Business18', 'Business18');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Business20', 'Business18', 28, 'Business34', 'Medium35', 'Business36', 'Medium37', 'Medium', 'Business38');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Medium21', 'Business18', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.member_id) FROM major AS T1 INNER JOIN member AS T2 ON T1.major_id = T2.link_to_major WHERE T1.major_name = 'Business' AND T2.t_shirt_size = 'Medium';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM member JOIN major ON member.link_to_major = major.major_id WHERE major.major_name = 'Business' AND member.t_shirt_size = 'Medium';

/*
Prediction Result:
(1,)
*/
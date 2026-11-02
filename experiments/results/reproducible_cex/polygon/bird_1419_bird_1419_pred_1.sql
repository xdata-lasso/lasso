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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('2020-03-24T12:00:0016', '2020-03-24T12:00:0030', '2020-03-24T12:00:00', '2020-03-24T12:00:0041', '2020-03-24T12:00:0031', '2020-03-24T12:00:0032', '2020-03-24T12:00:0033');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('2020-03-24T12:00:0015', '2020-03-24T12:00:0016', '2020-03-24T12:00:0039', '2020-03-24T12:00:0016', '2020-03-24T12:00:0016', '2020-03-24T12:00:0016', '2020-03-24T12:00:0016');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('2020-03-24T12:00:0017', '2020-03-24T12:00:0016', '2020-03-24T12:00:0016', '2020-03-24T12:00:0016');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (18, '2020-03-24T12:00:0016', '2020-03-24T12:00:0016', '2020-03-24T12:00:0016', '2020-03-24T12:00:0016', '2020-03-24T12:00:0016');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('2020-03-24T12:00:0016', '2020-03-24T12:00:0019');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('2020-03-24T12:00:0015', '2020-03-24T12:00:0020');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('2020-03-24T12:00:0034', '2020-03-24T12:00:0016', '2020-03-24T12:00:0040', 35, 36, 37, '2020-03-24T12:00:0038');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('2020-03-24T12:00:0021', NULL, '2020-03-24T12:00:0016', 16, 16, 16, '2020-03-24T12:00:0016');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('2020-03-24T12:00:0023', '2020-03-24T12:00:0021', '2020-03-24T12:00:0020', '2020-03-24T12:00:0016', '2020-03-24T12:00:0016', 16, '2020-03-24T12:00:0016');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('2020-03-24T12:00:0022', '2020-03-24T12:00:0021', '2020-03-24T12:00:0020', '2020-03-24T12:00:0016', '2020-03-24T12:00:0016', 16, '2020-03-24T12:00:0016');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('2020-03-24T12:00:0025', '2020-03-24T12:00:0020', '2020-03-24T12:00:0016', 16, '2020-03-24T12:00:0016', '2020-03-24T12:00:0016');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('2020-03-24T12:00:0024', '2020-03-24T12:00:0020', '2020-03-24T12:00:0016', 16, '2020-03-24T12:00:0016', '2020-03-24T12:00:0016');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('2020-03-24T12:00:0019', '2020-03-24T12:00:0017', 18, '2020-03-24T12:00:0016', '2020-03-24T12:00:0016', '2020-03-24T12:00:0016', '2020-03-24T12:00:0016', '2020-03-24T12:00:0016', '2020-03-24T12:00:0016');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('2020-03-24T12:00:0020', '2020-03-24T12:00:0017', 18, '2020-03-24T12:00:0016', '2020-03-24T12:00:0016', '2020-03-24T12:00:0016', '2020-03-24T12:00:0016', '2020-03-24T12:00:0016', '2020-03-24T12:00:0016');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.category FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event WHERE T1.event_date = '2020-03-24T12:00:00';

/*
Gold Result:
('2020-03-24T12:00:0040',)
*/

-- Prediction Query
SELECT type FROM event WHERE event_date = '2020-03-24T12:00:00';

/*
Prediction Result:
('2020-03-24T12:00:0041',)
*/
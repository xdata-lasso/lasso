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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('17', '51', '51', '51', '51', '51', '51');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('16', '51', '51', '51', '51', '51', '51');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('18', '51', '51', '51');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('29', '51', '51', '51');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (31, '51', '51', '51', '51', '51');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (19, '51', '51', '51', '51', '51');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('17', '26');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('17', '27');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('21', '16', '51', 51, 51, 51, '51');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('20', '17', '51', 51, 51, 51, '51');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('23', '20', '27', '51', '51', 51, '51');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('25', '26', NULL, NULL, '52', NULL);
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('24', '27', '43', 44, '52', '45');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('26', NULL, NULL, NULL, '51', NULL, NULL, NULL, NULL);
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('27', '29', 31, NULL, '51', '46', '47', '48', '49');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name, T2.source FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member GROUP BY T1.first_name, T1.last_name, T2.source ORDER BY SUM(T2.amount) DESC, T1.first_name NULLS LAST, T1.last_name NULLS LAST, T2.source NULLS LAST LIMIT 1;

/*
Gold Result:
(None, '51', '52')
*/

-- Prediction Query
SELECT T1.first_name, T1.last_name, T2.source FROM member AS T1 INNER JOIN income AS T2 ON T1.member_id = T2.link_to_member ORDER BY T2.amount DESC, T1.member_id NULLS LAST, T2.income_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None, '51', '52')
*/
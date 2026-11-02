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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Physics Teaching19', 'Physics Teaching36', 'Physics Teaching36', 'Physics Teaching36', 'Physics Teaching36', 'Physics Teaching36', 'Physics Teaching36');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Physics Teaching18', 'Physics Teaching36', 'Physics Teaching36', 'Physics Teaching36', 'Physics Teaching36', 'Physics Teaching36', 'Physics Teaching36');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Physics Teaching36', 'Physics Teaching', 'Physics Teaching33', 'Physics Teaching34');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Physics Teaching20', 'Physics Teaching50', NULL, NULL);
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (21, 'Physics Teaching36', 'Physics Teaching36', 'Physics Teaching36', 'Physics Teaching36', 'Physics Teaching36');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (37, 'Physics Teaching36', 'Physics Teaching36', 'Physics Teaching36', 'Physics Teaching36', 'Physics Teaching36');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Physics Teaching19', 'Physics Teaching35');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Physics Teaching25', 'Physics Teaching19', 'Physics Teaching36', 36, 36, 36, 'Physics Teaching36');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Physics Teaching24', 'Physics Teaching18', 'Physics Teaching36', 36, 36, 36, 'Physics Teaching36');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Physics Teaching36', 'Physics Teaching24', 'Physics Teaching23', 'Physics Teaching36', 'Physics Teaching36', 36, 'Physics Teaching36');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Physics Teaching27', 'Physics Teaching23', 'Physics Teaching36', 36, 'Physics Teaching36', 'Physics Teaching36');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Physics Teaching26', 'Physics Teaching23', 'Physics Teaching36', 36, 'Physics Teaching36', 'Physics Teaching36');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Physics Teaching35', 'Physics Teaching36', 37, 'Physics Teaching38', 'Physics Teaching39', 'Physics Teaching40', 'Physics Teaching41', 'Physics Teaching42', 'Physics Teaching43');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Physics Teaching23', 'Physics Teaching20', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.member_id) FROM major AS T1 INNER JOIN member AS T2 ON T1.major_id = T2.link_to_major WHERE T1.major_name = 'Physics Teaching';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T2.major_name = 'Physics Teaching';

/*
Prediction Result:
(1,)
*/
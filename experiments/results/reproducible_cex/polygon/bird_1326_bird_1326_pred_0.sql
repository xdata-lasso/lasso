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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Environmental Engineering17', 'Environmental Engineering38', 'Environmental Engineering38', 'Environmental Engineering38', 'Environmental Engineering38', 'Environmental Engineering38', 'Environmental Engineering38');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Environmental Engineering16', 'Environmental Engineering38', 'Environmental Engineering38', 'Environmental Engineering38', 'Environmental Engineering38', 'Environmental Engineering38', 'Environmental Engineering38');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Environmental Engineering38', 'Environmental Engineering', 'Environmental Engineering39', 'Environmental Engineering40');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Environmental Engineering18', NULL, NULL, NULL);
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (19, 'Environmental Engineering38', 'Environmental Engineering38', 'Environmental Engineering38', 'Environmental Engineering38', 'Environmental Engineering38');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (31, 'Environmental Engineering38', 'Environmental Engineering38', 'Environmental Engineering38', 'Environmental Engineering38', 'Environmental Engineering38');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Environmental Engineering16', 'Environmental Engineering20');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Environmental Engineering17', 'Environmental Engineering30');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Environmental Engineering22', 'Environmental Engineering17', 'Environmental Engineering38', 38, 38, 38, 'Environmental Engineering38');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Environmental Engineering21', 'Environmental Engineering17', 'Environmental Engineering38', 38, 38, 38, 'Environmental Engineering38');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Environmental Engineering24', 'Environmental Engineering22', 'Environmental Engineering20', 'Environmental Engineering38', 'Environmental Engineering38', 38, 'Environmental Engineering38');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Environmental Engineering23', 'Environmental Engineering21', 'Environmental Engineering20', 'Environmental Engineering38', 'Environmental Engineering38', 38, 'Environmental Engineering38');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Environmental Engineering38', 'Environmental Engineering30', 'Environmental Engineering38', 38, 'Environmental Engineering38', 'Environmental Engineering38');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Environmental Engineering30', 'Environmental Engineering38', 31, 'Environmental Engineering32', 'Environmental Engineering33', 'Environmental Engineering34', 'Environmental Engineering35', 'Environmental Engineering36', 'Environmental Engineering37');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Environmental Engineering20', 'Environmental Engineering18', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.member_id) FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T2.major_name = 'Environmental Engineering';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM member JOIN major ON member.link_to_major = major.major_id WHERE major.major_name = 'Environmental Engineering';

/*
Prediction Result:
(1,)
*/
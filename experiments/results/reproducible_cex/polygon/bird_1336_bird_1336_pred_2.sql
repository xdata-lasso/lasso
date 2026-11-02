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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Guidi17', 'Guidi27', 'Guidi27', 'Guidi27', 'Guidi27', 'Guidi27', 'Guidi27');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Pierce16', 'Guidi27', 'Guidi27', 'Guidi27', 'Guidi27', 'Guidi27', 'Guidi27');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Guidi27', NULL, 'Guidi47', NULL);
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Pierce18', 'Guidi27', 'Guidi27', 'Guidi27');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (41, 'Guidi27', 'Guidi27', 'Guidi27', 'Guidi27', 'Guidi27');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (19, 'Guidi27', 'Guidi27', 'Guidi27', 'Guidi27', 'Guidi27');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Guidi17', 'Pierce20');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Pierce16', 'Pierce40');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Pierce22', 'Pierce16', 'Guidi27', 27, 27, 27, 'Guidi27');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Guidi21', 'Pierce16', 'Guidi27', 27, 27, 27, 'Guidi27');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Pierce24', 'Guidi21', 'Pierce40', 'Guidi27', 'Guidi27', 27, 'Guidi27');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Guidi23', 'Pierce22', 'Pierce20', 'Guidi27', 'Guidi27', 27, 'Guidi27');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Pierce26', 'Pierce40', 'Guidi27', 27, 'Guidi27', 'Guidi27');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Guidi25', 'Pierce20', 'Guidi27', 27, 'Guidi27', 'Guidi27');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Pierce40', 'Guidi27', 41, 'Pierce42', 'Guidi', 'Guidi43', 'Pierce44', 'Guidi45', 'Pierce46');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Pierce20', 'Guidi27', NULL, 'Guidi35', 'Pierce', NULL, NULL, 'Pierce38', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.department FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T1.last_name = 'Pierce' OR T1.last_name = 'Guidi';

/*
Gold Result:
('Guidi47',)
('Guidi47',)
*/

-- Prediction Query
SELECT major.department FROM major INNER JOIN member ON major.major_id = member.link_to_major WHERE member.first_name = 'Pierce' OR member.last_name = 'Guidi';

/*
Prediction Result:
('Guidi47',)
*/
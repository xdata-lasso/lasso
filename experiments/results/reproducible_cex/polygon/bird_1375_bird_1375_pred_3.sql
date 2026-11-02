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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('School of Applied Sciences, Technology and Education20', 'School of Applied Sciences, Technology and Education44', 'School of Applied Sciences, Technology and Education44', 'School of Applied Sciences, Technology and Education44', 'School of Applied Sciences, Technology and Education44', 'School of Applied Sciences, Technology and Education44', 'School of Applied Sciences, Technology and Education44');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('School of Applied Sciences, Technology and Education19', 'School of Applied Sciences, Technology and Education44', 'School of Applied Sciences, Technology and Education44', 'School of Applied Sciences, Technology and Education44', 'School of Applied Sciences, Technology and Education44', 'School of Applied Sciences, Technology and Education44', 'School of Applied Sciences, Technology and Education44');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('School of Applied Sciences, Technology and Education21', 'School of Applied Sciences, Technology and Education44', 'School of Applied Sciences, Technology and Education44', 'School of Applied Sciences, Technology and Education44');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('School of Applied Sciences, Technology and Education44', 'School of Applied Sciences, Technology and Education45', 'School of Applied Sciences, Technology and Education', 'School of Applied Sciences, Technology and Education46');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (22, 'School of Applied Sciences, Technology and Education44', 'School of Applied Sciences, Technology and Education44', 'School of Applied Sciences, Technology and Education44', 'School of Applied Sciences, Technology and Education44', 'School of Applied Sciences, Technology and Education44');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (39, 'School of Applied Sciences, Technology and Education44', 'School of Applied Sciences, Technology and Education44', 'School of Applied Sciences, Technology and Education44', 'School of Applied Sciences, Technology and Education44', 'School of Applied Sciences, Technology and Education44');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('School of Applied Sciences, Technology and Education20', 'School of Applied Sciences, Technology and Education38');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('School of Applied Sciences, Technology and Education19', 'School of Applied Sciences, Technology and Education33');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('School of Applied Sciences, Technology and Education24', 'School of Applied Sciences, Technology and Education20', 'School of Applied Sciences, Technology and Education44', 44, 44, 44, 'School of Applied Sciences, Technology and Education44');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('School of Applied Sciences, Technology and Education23', 'School of Applied Sciences, Technology and Education19', 'School of Applied Sciences, Technology and Education44', 44, 44, 44, 'School of Applied Sciences, Technology and Education44');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('School of Applied Sciences, Technology and Education26', 'School of Applied Sciences, Technology and Education24', 'School of Applied Sciences, Technology and Education38', 'School of Applied Sciences, Technology and Education44', 'School of Applied Sciences, Technology and Education44', 44, 'School of Applied Sciences, Technology and Education44');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('School of Applied Sciences, Technology and Education25', 'School of Applied Sciences, Technology and Education23', 'School of Applied Sciences, Technology and Education38', 'School of Applied Sciences, Technology and Education44', 'School of Applied Sciences, Technology and Education44', 44, 'School of Applied Sciences, Technology and Education44');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('School of Applied Sciences, Technology and Education28', 'School of Applied Sciences, Technology and Education38', 'School of Applied Sciences, Technology and Education44', 44, 'School of Applied Sciences, Technology and Education44', 'School of Applied Sciences, Technology and Education44');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('School of Applied Sciences, Technology and Education33', 'School of Applied Sciences, Technology and Education44', 39, NULL, 'School of Applied Sciences, Technology and Education49', 'School of Applied Sciences, Technology and Education34', 'School of Applied Sciences, Technology and Education35', 'School of Applied Sciences, Technology and Education36', 'School of Applied Sciences, Technology and Education37');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('School of Applied Sciences, Technology and Education38', 'School of Applied Sciences, Technology and Education44', 39, NULL, 'School of Applied Sciences, Technology and Education49', 'School of Applied Sciences, Technology and Education40', 'School of Applied Sciences, Technology and Education41', 'School of Applied Sciences, Technology and Education42', 'School of Applied Sciences, Technology and Education43');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.first_name, T1.last_name FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T2.department = 'School of Applied Sciences, Technology and Education';

/*
Gold Result:
(None, 'School of Applied Sciences, Technology and Education49')
(None, 'School of Applied Sciences, Technology and Education49')
*/

-- Prediction Query
SELECT DISTINCT t1.first_name, t1.last_name FROM member AS t1 INNER JOIN major AS t2 ON t1.link_to_major = t2.major_id WHERE t2.department = 'School of Applied Sciences, Technology and Education';

/*
Prediction Result:
(None, 'School of Applied Sciences, Technology and Education49')
*/
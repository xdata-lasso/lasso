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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Post Cards, Posters28', 'Post Cards, Posters50', 'Post Cards, Posters51', 'Post Cards, Posters52', 'Post Cards, Posters53', 'Post Cards, Posters54', 'Post Cards, Posters55');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Post Cards, Posters21', 'Post Cards, Posters30', 'Post Cards, Posters30', 'Post Cards, Posters30', 'Post Cards, Posters30', 'Post Cards, Posters30', 'Post Cards, Posters30');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Post Cards, Posters23', 'Post Cards, Posters30', 'Post Cards, Posters30', 'Post Cards, Posters30');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Post Cards, Posters22', 'Post Cards, Posters30', 'Post Cards, Posters30', 'Post Cards, Posters30');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (25, 'Post Cards, Posters30', 'Post Cards, Posters30', 'Post Cards, Posters30', 'Post Cards, Posters30', 'Post Cards, Posters30');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (24, 'Post Cards, Posters30', 'Post Cards, Posters30', 'Post Cards, Posters30', 'Post Cards, Posters30', 'Post Cards, Posters30');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Post Cards, Posters28', 'Post Cards, Posters43');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Post Cards, Posters30', 'Post Cards, Posters28', 'Post Cards, Posters38', 39, 40, 41, NULL);
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Post Cards, Posters27', NULL, 'Post Cards, Posters30', 30, 30, 30, 'Post Cards, Posters30');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Post Cards, Posters42', 'Post Cards, Posters30', 'Post Cards, Posters43', 'Post Cards, Posters', 'Post Cards, Posters372413', 44, 'Post Cards, Posters45');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Post Cards, Posters29', 'Post Cards, Posters30', 'Post Cards, Posters31', 'Post Cards, Posters', 'Post Cards, Posters46', 47, 'Post Cards, Posters48');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Post Cards, Posters33', 'Post Cards, Posters43', 'Post Cards, Posters30', 30, 'Post Cards, Posters30', 'Post Cards, Posters30');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Post Cards, Posters32', 'Post Cards, Posters31', 'Post Cards, Posters30', 30, 'Post Cards, Posters30', 'Post Cards, Posters30');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Post Cards, Posters43', 'Post Cards, Posters23', NULL, 'Post Cards, Posters30', 'Post Cards, Posters30', 'Post Cards, Posters30', 'Post Cards, Posters30', 'Post Cards, Posters30', 'Post Cards, Posters30');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Post Cards, Posters31', 'Post Cards, Posters22', 25, 'Post Cards, Posters30', 'Post Cards, Posters30', 'Post Cards, Posters30', 'Post Cards, Posters30', 'Post Cards, Posters30', 'Post Cards, Posters30');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_status FROM budget AS T1 INNER JOIN expense AS T2 ON T1.budget_id = T2.link_to_budget WHERE T2.expense_description = 'Post Cards, Posters' AND T2.expense_date = '2019-08-20';

/*
Gold Result:
*/

-- Prediction Query
SELECT event.status FROM expense INNER JOIN budget ON expense.link_to_budget = budget.budget_id INNER JOIN event ON budget.link_to_event = event.event_id WHERE expense.expense_description = 'Post Cards, Posters' AND expense.expense_date = '2019-08-20';

/*
Prediction Result:
*/
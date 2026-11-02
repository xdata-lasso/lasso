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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Posters27', 'Posters34', 'Posters34', 'Posters34', 'Posters34', 'Posters34', 'Posters34');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Posters38', 'Posters34', 'Posters34', 'Posters34', 'Posters34', 'Posters34', 'Posters34');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Posters18', 'Posters34', 'Posters34', 'Posters34');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Posters17', 'Posters34', 'Posters34', 'Posters34');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (19, 'Posters34', 'Posters34', 'Posters34', 'Posters34', 'Posters34');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Posters27', 'Posters34');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Posters38', 'Posters34');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Posters33', 'Posters27', NULL, 28, 29, 30, 'Posters31');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Posters44', 'Posters38', NULL, 39, 40, 41, 'Posters42');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Posters43', 'Posters44', 'Posters34', 'Posters', 'Posters45', 46, 'Posters47');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Posters32', 'Posters33', 'Posters34', 'Posters', 'Posters35', 36, 'Posters37');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Posters22', 'Posters34', 'Posters34', 34, 'Posters34', 'Posters34');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Posters21', 'Posters34', 'Posters34', 34, 'Posters34', 'Posters34');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Posters34', 'Posters18', 19, 'Posters34', 'Posters34', 'Posters34', 'Posters34', 'Posters34', 'Posters34');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.category FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id WHERE T1.expense_description = 'Posters';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT budget.category FROM budget INNER JOIN expense ON budget.budget_id = expense.link_to_budget WHERE expense.expense_description = 'Posters';

/*
Prediction Result:
(None,)
(None,)
*/
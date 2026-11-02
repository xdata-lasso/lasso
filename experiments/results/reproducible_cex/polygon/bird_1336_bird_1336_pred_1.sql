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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Pierce20', 'Guidi51', 'Guidi51', 'Guidi51', 'Guidi51', 'Guidi51', 'Guidi51');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Guidi19', 'Guidi51', 'Guidi51', 'Guidi51', 'Guidi51', 'Guidi51', 'Guidi51');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Guidi35', 'Pierce32', 'Guidi51', 'Guidi33');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Guidi45', 'Pierce42', 'Guidi51', 'Guidi43');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (21, 'Guidi51', 'Guidi51', 'Guidi51', 'Guidi51', 'Guidi51');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (36, 'Guidi51', 'Guidi51', 'Guidi51', 'Guidi51', 'Guidi51');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Pierce20', 'Pierce34');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Guidi19', 'Pierce44');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Guidi23', 'Guidi19', 'Guidi51', 51, 51, 51, 'Guidi51');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Pierce22', 'Guidi19', 'Guidi51', 51, 51, 51, 'Guidi51');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Guidi25', 'Pierce22', 'Pierce44', 'Guidi51', 'Guidi51', 51, 'Guidi51');
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Pierce24', 'Pierce22', 'Pierce44', 'Guidi51', 'Guidi51', 51, 'Guidi51');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Guidi27', 'Pierce44', 'Guidi51', 51, 'Guidi51', 'Guidi51');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Pierce26', 'Pierce44', 'Guidi51', 51, 'Guidi51', 'Guidi51');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Pierce34', 'Guidi35', 36, 'Guidi37', 'Guidi', 'Pierce38', 'Guidi39', 'Pierce40', 'Guidi41');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Pierce44', 'Guidi45', 36, 'Pierce46', 'Guidi', 'Guidi47', 'Pierce48', 'Guidi49', 'Pierce50');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.department FROM member AS T1 INNER JOIN major AS T2 ON T1.link_to_major = T2.major_id WHERE T1.last_name = 'Pierce' OR T1.last_name = 'Guidi';

/*
Gold Result:
('Guidi51',)
('Guidi51',)
*/

-- Prediction Query
SELECT DISTINCT m1.department FROM major AS m1 JOIN member AS mem1 ON m1.major_id = mem1.link_to_major WHERE mem1.last_name IN ('Pierce', 'Guidi');

/*
Prediction Result:
('Guidi51',)
*/
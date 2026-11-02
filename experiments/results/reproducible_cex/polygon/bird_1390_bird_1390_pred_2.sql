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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Yearly Kickoff43', 'Yearly Kickoff37', 'Yearly Kickoff38', 'Yearly Kickoff39', 'Yearly Kickoff40', 'Yearly Kickoff41', 'Yearly Kickoff42');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('Yearly Kickoff21', 'Yearly Kickoff43', 'Yearly Kickoff43', 'Yearly Kickoff43', 'Yearly Kickoff43', 'Yearly Kickoff43', 'Yearly Kickoff43');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('Yearly Kickoff22', 'Yearly Kickoff43', 'Yearly Kickoff43', 'Yearly Kickoff43');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (24, 'Yearly Kickoff43', 'Yearly Kickoff43', 'Yearly Kickoff43', 'Yearly Kickoff43', 'Yearly Kickoff43');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (23, 'Yearly Kickoff43', 'Yearly Kickoff43', 'Yearly Kickoff43', 'Yearly Kickoff43', 'Yearly Kickoff43');
INSERT INTO "attendance" ("link_to_event", "link_to_member") VALUES ('Yearly Kickoff21', 'Yearly Kickoff25');
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Yearly Kickoff29', 'Yearly Kickoff43', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "budget" ("budget_id", "link_to_event", "category", "spent", "remaining", "amount", "event_status") VALUES ('Yearly Kickoff27', 'Yearly Kickoff43', 'Yearly Kickoff49', NULL, NULL, NULL, NULL);
INSERT INTO "expense" ("expense_id", "link_to_budget", "link_to_member", "expense_description", "expense_date", "cost", "approved") VALUES ('Yearly Kickoff28', 'Yearly Kickoff29', NULL, NULL, 'Yearly Kickoff57', 1, NULL);
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Yearly Kickoff32', 'Yearly Kickoff25', 'Yearly Kickoff43', 43, 'Yearly Kickoff43', 'Yearly Kickoff43');
INSERT INTO "income" ("income_id", "link_to_member", "date_received", "amount", "source", "notes") VALUES ('Yearly Kickoff31', 'Yearly Kickoff26', 'Yearly Kickoff43', 43, 'Yearly Kickoff43', 'Yearly Kickoff43');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Yearly Kickoff25', 'Yearly Kickoff22', 24, 'Yearly Kickoff43', 'Yearly Kickoff43', 'Yearly Kickoff43', 'Yearly Kickoff43', 'Yearly Kickoff43', 'Yearly Kickoff43');
INSERT INTO "member" ("member_id", "link_to_major", "zip", "first_name", "last_name", "email", "position", "t_shirt_size", "phone") VALUES ('Yearly Kickoff26', 'Yearly Kickoff22', 23, 'Yearly Kickoff43', 'Yearly Kickoff43', 'Yearly Kickoff43', 'Yearly Kickoff43', 'Yearly Kickoff43', 'Yearly Kickoff43');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T1.event_name = 'Yearly Kickoff' THEN T3.cost ELSE 0 END) AS REAL) * 100 / SUM(T3.cost) FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT (SUM(CASE WHEN e.event_name = 'Yearly Kickoff' THEN b.spent ELSE 0 END)) * 100.0 / (SELECT SUM(spent) FROM budget) AS yearly_kickoff_percentage FROM event AS e JOIN budget AS b ON e.event_id = b.link_to_event;

/*
Prediction Result:
(None,)
*/
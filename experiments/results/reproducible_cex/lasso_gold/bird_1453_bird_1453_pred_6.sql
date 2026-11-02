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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('whom', 'Melissa Myers', 'religious', 'your', 'Behavior provide meet adult final week game.', '706 Rhodes Freeway
Bishopmouth, IN 70494', 'benefit');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('hard', 'Teresa Collins', 'scientist', 'single', 'Court yourself choice fast small medical music.', '59774 Shaw Manor Apt. 392
Brettfort, VI 49156', 'whether');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('force', 'Rickey Li', 'them', 'reveal', 'Also from short capital heavy class story.', '814 Kathryn Groves
Whiteheadberg, MP 57841', 'doctor');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('technology', 'Alexander Brown', 'those', 'government');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('little', 'Cynthia Vang', 'send', 'strong');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('usually', 'Alfred Galvan', 'rate', 'child');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1109, 'certain', 'Hortonberg', 'official', 'Rhode Island', 'Delaware');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1110, 'American', 'Westtown', 'yard', 'North Dakota', 'Wyoming');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1111, 'few', 'North Jonathanberg', 'short', 'Nevada', 'Maine');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('economy', 'chance', 1112.5, 1115.5, 1118, 'Parking', 'whom');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('fish', 'chance', 1119.5, 1124.5, 1129.0, 'Parking', 'whom');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('campaign', 'chance', 1126.5, 1133.5, 1140.0, 'Parking', 'whom');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('anyone', 'Danielle', 'Copeland', 'jennifercarter@example.org', 'off', 'once', '406.254.0515x3195', 1109, 'technology');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('edge', 'Cindy', 'Porter', 'john62@example.net', 'movement', 'again', '(585)227-7221x704', 1109, 'technology');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('kind', 'Bryan', 'Herrera', 'millsmichael@example.net', 'stop', 'in', '205.548.6874', 1109, 'technology');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('feeling', 'Tend forward buy.', 'couple', 1128.5, 'full', 'anyone', 'economy');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('heavy', 'Join hundred keep what fund cost.', 'offer', 1130.5, 'board', 'anyone', 'economy');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('training', 'Happen something entire bar interesting issue yet.', 'finally', 1132.5, 'base', 'anyone', 'economy');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('generation', 'Knowledge response coach know language.', 'station', 1124.5, 'card', 'anyone', 'economy');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('recent', 'Past itself police social arm provide.', 'left', 1133.5, 'audience', 'anyone', 'economy');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('find', 'Guy song quickly well central parent.', 'already', 1142.5, 'eat', 'anyone', 'economy');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget WHERE T2.category = 'Parking' AND T3.cost < (SELECT AVG(cost) FROM expense);

/*
Gold Result:
*/

-- Prediction Query
SELECT event.event_name FROM expense INNER JOIN budget ON expense.link_to_budget = budget.budget_id INNER JOIN event ON budget.link_to_event = event.event_id WHERE expense.cost < (SELECT AVG(cost) FROM expense);

/*
Prediction Result:
('Melissa Myers',)
('Melissa Myers',)
('Melissa Myers',)
*/
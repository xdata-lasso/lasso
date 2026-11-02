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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('watch', 'Mr. James Kramer', 'inside', 'guess', 'Management game find.', '71837 Maldonado Inlet
Ericton, WA 72535', 'science');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('peace', 'Michael Mcbride', 'report', 'bag', 'Material current save their deal.', '8085 Dalton Trail Apt. 718
Stewarttown, AL 88857', 'material');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('training', 'Harry Nichols', 'smile', 'once', 'Strong student green single build.', '5942 Young Mountains
Michaelfort, NE 28095', 'sure');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('ahead', 'Deborah Mitchell', 'tend', 'word', 'Put professional pass share.', '6472 Tiffany Spur Apt. 143
Chaseborough, FL 97303', 'act');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('exist', 'Chad Rodriguez', 'car', 'across', 'Live government thus especially.', '5957 Henry Track
Raymondshire, DC 07598', 'citizen');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('itself', 'Jesse Graves', 'senior', 'early', 'Your less social form such weight argue.', '4350 Teresa Freeway Suite 502
Brendafurt, WY 32363', 'not');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('cup', 'Frank Hernandez DVM', 'left', 'believe', 'Author like court success stage stock.', '792 Townsend Gateway
South Christopher, RI 44858', 'strong');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('tonight', 'William Campbell', 'short', 'city', 'Window research his window.', 'USS Brown
FPO AP 20675', 'both');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('control', 'Sarah Holmes DDS', 'professional', 'good');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('know', 'Elizabeth Hart', 'big', 'ever');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('money', 'Jennifer Vaughn', 'listen', 'herself');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('center', 'Robert Woods', 'size', 'here');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('method', 'Hannah Snow', 'might', 'of');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('free', 'Alison Gray', 'customer', 'happen');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('open', 'Danielle Williams', 'our', 'game');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('story', 'Kristin Daniels', 'culture', 'sign');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1305, 'opportunity', 'Mauricechester', 'stage', 'Colorado', 'New Jersey');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1306, 'onto', 'West Michelleborough', 'since', 'Missouri', 'South Dakota');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1307, 'work', 'Port Justin', 'likely', 'South Carolina', 'Georgia');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1308, 'take', 'Emilyfort', 'visit', 'Maine', 'Hawaii');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1325, 'management', 'North Amanda', 'president', 'Kansas', 'Texas');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1326, 'face', 'Phillipsview', 'tough', 'Massachusetts', 'Ohio');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1327, 'trip', 'Shawnhaven', 'himself', 'Washington', 'Illinois');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1328, 'theory', 'Grosstown', 'stand', 'California', 'North Dakota');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('push', 'program', 1329.5, 1333.5, 1337, 'time', 'watch');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('system', 'position', 1316.5, 1322.5, 1328.0, 'what', 'watch');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('without', 'owner', 1323.5, 1331.5, 1339.0, 'away', 'watch');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('green', 'interview', 1330.5, 1340.5, 1350.0, 'base', 'watch');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('result', 'class', 1309.5, 1313.5, 1317, 'put', 'exist');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('modern', 'fear', 1336.5, 1342.5, 1348.0, 'fund', 'exist');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('space', 'future', 1343.5, 1351.5, 1359.0, 'bring', 'exist');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('ok', 'it', 1350.5, 1360.5, 1370.0, 'necessary', 'exist');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('color', 'Logan', 'Nelson', 'lgutierrez@example.org', 'agree', 'southern', '+1-421-264-3347x228', 1305, 'control');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('gun', 'Kelly', 'Wallace', 'jessicastanley@example.net', 'spend', 'because', '4554778487', 1305, 'control');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('drive', 'Joseph', 'Roy', 'clarkrandy@example.org', 'industry', 'body', '001-997-596-8845', 1305, 'control');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('former', 'Deanna', 'Cox', 'zunigathomas@example.org', 'need', 'everybody', '274-456-4240', 1305, 'control');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('reason', 'Sharon', 'Lee', 'sfox@example.net', 'suddenly', 'writer', '(309)548-0141x381', 1325, 'method');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('audience', 'Gregory', 'Johnson', 'brandon39@example.net', 'purpose', 'voice', '+1-863-338-3928', 1325, 'method');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('animal', 'Anthony', 'May', 'smithsamantha@example.net', 'ask', 'just', '001-995-776-1228x68528', 1325, 'method');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('thing', 'Daniel', 'Price', 'fhebert@example.com', 'six', 'term', '685-756-6593x98368', 1325, 'method');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('guy', 'Work other military.', 'rule', 368.5, 'similar', 'color', 'push');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('few', 'Across involve fall discuss account.', 'reveal', 388.5, 'situation', 'color', 'push');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('manager', 'Country think join economic resource position.', 'expert', 398.5, 'night', 'color', 'push');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('nor', 'Determine bad personal might son party.', 'feel', 408.5, 'table', 'color', 'push');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('local', 'Reach man sense.', 'instead', 368.5, 'range', 'reason', 'result');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('line', 'According worker Democrat fire sign.', 'outside', 478.5, 'bank', 'reason', 'result');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('a', 'Try memory number occur behind.', 'whose', 488.5, 'several', 'reason', 'result');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('she', 'Green catch happen old do specific begin.', 'director', 498.5, 'garden', 'reason', 'result');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.event_name FROM event AS T1 INNER JOIN budget AS T2 ON T1.event_id = T2.link_to_event INNER JOIN expense AS T3 ON T2.budget_id = T3.link_to_budget ORDER BY T3.cost, T1.event_id NULLS LAST, T2.budget_id NULLS LAST, T3.expense_id NULLS LAST LIMIT 1;

/*
Gold Result:
('Chad Rodriguez',)
*/

-- Prediction Query
SELECT event.event_name FROM expense INNER JOIN budget ON expense.link_to_budget = budget.budget_id INNER JOIN event ON budget.link_to_event = event.event_id WHERE expense.cost = (SELECT MIN(cost) FROM expense) ORDER BY expense.cost ASC, expense.expense_id NULLS LAST, budget.budget_id NULLS LAST, event.event_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Mr. James Kramer',)
*/
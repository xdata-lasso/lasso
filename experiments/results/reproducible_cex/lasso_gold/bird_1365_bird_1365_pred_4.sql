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
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('information', 'Anna Stephens', 'soldier', 'bed', 'Including series dinner article hit mission whole.', 'Unit 2945 Box 1168
DPO AA 72859', 'keep');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('market', 'Stephen Wood', 'same', 'relate', 'Of dog federal house take alone number.', '709 Rodriguez Drive Apt. 999
North Annaville, WY 37999', 'point');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('middle', 'Dennis Marshall', 'region', 'guy', 'Song quality per build serious common worker.', '4679 Johnson Harbor Suite 299
Williamsmouth, UT 31640', 'race');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('want', 'Derrick Brown', 'bill', 'system', 'Speak call interest write itself.', '5054 Ramirez Overpass Apt. 324
Schroedermouth, KY 96026', 'behind');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('leader', 'John Smith', 'draw', 'board', 'Cold statement fear fact road.', '010 Hannah Mall
Jamesside, KS 62681', 'fine');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('property', 'Monica Dodson', 'rule', 'identify', 'Model its rather card you majority seek close.', '046 Elaine Groves
South Maria, CT 67555', 'everything');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('laugh', 'Nicole Schmidt', 'understand', 'most', 'Affect difference world deep against mean.', '1173 Kimberly Village
West Jade, LA 21521', 'majority');
INSERT INTO "event" ("event_id", "event_name", "event_date", "type", "notes", "location", "status") VALUES ('international', 'Aaron Gross', 'forget', 'per', 'Hand practice also theory.', '75300 Rebecca Village Suite 218
Lake Jenniferview, SD 30799', 'black');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('cup', 'Natalie Malone', 'air', 'there');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('letter', 'Samantha Robertson', 'consumer', 'deep');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('development', 'Eric Hunter', 'data', 'third');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('white', 'Samuel Suarez', 'type', 'article');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('tax', 'Heather Rhodes', 'pretty', 'better');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('contain', 'Brian York', 'executive', 'hotel');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('two', 'Alexandra Taylor', 'unit', 'teacher');
INSERT INTO "major" ("major_id", "major_name", "department", "college") VALUES ('among', 'Erin Kline', 'significant', 'guess');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1225, 'enjoy', 'Janetview', 'cost', 'Oklahoma', 'West Virginia');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1226, 'alone', 'Madisonhaven', 'truth', 'Minnesota', 'Vermont');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1227, 'loss', 'Reidville', 'matter', 'Hawaii', 'Colorado');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1228, 'apply', 'East Nathanmouth', 'peace', 'Kentucky', 'Maine');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1245, 'cover', 'Nelsonfurt', 'performance', 'Utah', 'Missouri');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1246, 'build', 'Marshburgh', 'meeting', 'New Hampshire', 'Wyoming');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1247, 'institution', 'East Heatherton', 'suffer', 'Idaho', 'Alaska');
INSERT INTO "zip_code" ("zip_code", "type", "city", "county", "state", "short_state") VALUES (1248, 'instead', 'North Robert', 'outside', 'South Carolina', 'Washington');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('ahead', 'too', 1249.5, 280.5, 1257, 'tough', 'information');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('imagine', 'owner', 1236.5, 300.5, 1248.0, 'do', 'information');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('appear', 'state', 1243.5, 310.5, 1259.0, 'radio', 'information');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('commercial', 'difficult', 1250.5, 320.5, 1270.0, 'down', 'information');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('wait', 'budget', 1229.5, 280.5, 1237, 'any', 'leader');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('case', 'very', 1256.5, 390.5, 1268.0, 'at', 'leader');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('wife', 'its', 1263.5, 400.5, 1279.0, 'every', 'leader');
INSERT INTO "budget" ("budget_id", "category", "spent", "remaining", "amount", "event_status", "link_to_event") VALUES ('method', 'let', 1270.5, 410.5, 1290.0, 'real', 'leader');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('research', 'Robert', 'Smith', 'walkercharlene@example.com', 'recognize', 'option', '517-215-4544x4328', 1225, 'cup');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('design', 'Andrew', 'Buck', 'rodney65@example.com', 'threat', 'phone', '+1-565-720-7446x660', 1225, 'cup');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('exist', 'Kimberly', 'Holland', 'jeffery48@example.net', 'those', 'politics', '001-438-675-8428x2417', 1225, 'cup');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('reach', 'Katrina', 'Burke', 'asilva@example.net', 'house', 'fear', '001-682-951-3534x6554', 1225, 'cup');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('former', 'Erica', 'Santiago', 'reynoldsjessica@example.com', 'society', 'give', '+1-366-931-7797', 1245, 'tax');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('actually', 'Barbara', 'Morgan', 'elizabeth62@example.net', 'million', 'fall', '351.670.1660x880', 1245, 'tax');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('sea', 'Annette', 'Mills', 'smithsarah@example.net', 'full', 'movement', '783.975.5037x58997', 1245, 'tax');
INSERT INTO "member" ("member_id", "first_name", "last_name", "email", "position", "t_shirt_size", "phone", "zip", "link_to_major") VALUES ('trouble', 'Tiffany', 'Haynes', 'kchristian@example.org', 'effect', 'dog', '713-305-5488', 1245, 'tax');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('today', 'State score important effect.', 'south', 1261.5, 'source', 'research', 'ahead');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('buy', 'Case customer important notice.', 'cold', 1250.5, 'behavior', 'research', 'ahead');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('many', 'Century television Congress ball forward would finish.', 'might', 1259.5, 'carry', 'research', 'ahead');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('argue', 'Above event seven collection.', 'stock', 1268.5, 'possible', 'research', 'ahead');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('answer', 'Oil per line create build quite morning including.', 'lead', 1241.5, 'movie', 'former', 'wait');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('watch', 'Could us hotel lead sit.', 'this', 1270.5, 'statement', 'former', 'wait');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('community', 'Blue increase unit study open sign.', 'pay', 1279.5, 'will', 'former', 'wait');
INSERT INTO "expense" ("expense_id", "expense_description", "expense_date", "cost", "approved", "link_to_member", "link_to_budget") VALUES ('mind', 'Leader operation mean white above save network.', 'window', 1288.5, 'whether', 'former', 'wait');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.expense_description FROM budget AS T1 INNER JOIN expense AS T2 ON T1.budget_id = T2.link_to_budget ORDER BY T1.remaining, T1.budget_id NULLS LAST, T2.expense_id NULLS LAST LIMIT 1;

/*
Gold Result:
('Above event seven collection.',)
*/

-- Prediction Query
SELECT T1.expense_description FROM expense AS T1 INNER JOIN budget AS T2 ON T1.link_to_budget = T2.budget_id ORDER BY T2.remaining, T1.expense_id NULLS LAST, T2.budget_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Oil per line create build quite morning including.',)
*/
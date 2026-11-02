-- Schema DDL
CREATE TABLE badges (Id INTEGER NOT NULL PRIMARY KEY, UserId INTEGER NULL, Name TEXT NULL, Date DATETIME NULL, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE comments (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, Score INTEGER NULL, Text TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postHistory (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostHistoryTypeId INTEGER NULL, PostId INTEGER NULL, RevisionGUID TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, Text TEXT NULL, Comment TEXT NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postLinks (Id INTEGER NOT NULL PRIMARY KEY, CreationDate DATETIME NULL, PostId INTEGER NULL, RelatedPostId INTEGER NULL, LinkTypeId INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (RelatedPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE posts (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostTypeId INTEGER NULL, AcceptedAnswerId INTEGER NULL, CreaionDate DATETIME NULL, Score INTEGER NULL, ViewCount INTEGER NULL, Body TEXT NULL, OwnerUserId INTEGER NULL, LasActivityDate DATETIME NULL, Title TEXT NULL, Tags TEXT NULL, AnswerCount INTEGER NULL, CommentCount INTEGER NULL, FavoriteCount INTEGER NULL, LastEditorUserId INTEGER NULL, LastEditDate DATETIME NULL, CommunityOwnedDate DATETIME NULL, ParentId INTEGER NULL, ClosedDate DATETIME NULL, OwnerDisplayName TEXT NULL, LastEditorDisplayName TEXT NULL, FOREIGN KEY (LastEditorUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (OwnerUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE tags (Id INTEGER NOT NULL PRIMARY KEY, TagName TEXT NULL, Count INTEGER NULL, ExcerptPostId INTEGER NULL, WikiPostId INTEGER NULL, FOREIGN KEY (ExcerptPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE users (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, Reputation INTEGER NULL, CreationDate DATETIME NULL, DisplayName TEXT NULL, LastAccessDate DATETIME NULL, WebsiteUrl TEXT NULL, Location TEXT NULL, AboutMe TEXT NULL, Views INTEGER NULL, UpVotes INTEGER NULL, DownVotes INTEGER NULL, AccountId INTEGER NULL, Age INTEGER NULL, ProfileImageUrl TEXT NULL);

CREATE TABLE votes (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, VoteTypeId INTEGER NULL, CreationDate DATE NULL, UserId INTEGER NULL, BountyAmount INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1001, 1007, '1970-01-01', 'Allison Hill', '1976-07-07', 'http://www.henderson.com/', '327 Nelson Route
Lake Mark, WI 07832', 'evidence', 1013, 1019, 1025, 1031, 1037, 'http://carney-santos.info/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1002, 1012.0, '1970-01-02', 'Noah Rhodes', '1976-07-08', 'http://www.davis-abbott.org/', '6413 Lewis Parks
Wilkersonmouth, FL 35219', 'news', 1032.0, 1040.0, 1048.0, 1056.0, 1064.0, 'https://www.walker.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1003, 1017.0, '1970-01-03', 'Angie Henderson', '1976-07-09', 'https://www.stevens.com/', '969 Cox Dam Suite 101
Lake Ernest, TX 55834', 'turn', 1051.0, 1061.0, 1071.0, 1081.0, 1091.0, 'http://www.jones.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1004, 1022.0, '1970-01-04', 'Daniel Wagner', '1976-07-10', 'https://lee.com/', '9784 Erin Crescent Suite 514
Mooretown, VA 94830', 'policy', 1070.0, 1082.0, 1094.0, 1106.0, 1118.0, 'http://www.heath.net/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1005, 1027.0, '1970-01-05', 'Cristian Santos', '1976-07-11', 'http://www.james.com/', '148 Eric Track
New Stephanie, NC 00575', 'land', 1089.0, 1103.0, 1117.0, 1131.0, 1145.0, 'http://washington.org/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1006, 1032.0, '1970-01-06', 'Connie Lawrence', '1976-07-12', 'http://clark-adams.com/', '15430 Natalie Common Apt. 718
East Donna, OH 22144', 'development', 1108.0, 1124.0, 1140.0, 1156.0, 1172.0, 'https://www.aguirre-lee.com/');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1043, 1001, 'Heather Jenkins', '1982-02-13');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1044, 1001, 'Amy Valdez', '1982-02-14');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1045, 1001, 'Amy Chandler', '1982-02-15');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1046, 1001, 'Ashley Lee', '1982-02-16');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1047, 1001, 'Brenda White', '1982-02-17');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1048, 1001, 'Shannon Jones', '1982-02-18');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT UserId FROM (SELECT UserId, COUNT(Name) AS num FROM badges GROUP BY UserId) AS T WHERE T.num > 5;

/*
Gold Result:
(1001,)
*/

-- Prediction Query
SELECT COUNT(*) AS user_count FROM (SELECT UserId FROM badges GROUP BY UserId HAVING COUNT(*) > 5) AS subquery;

/*
Prediction Result:
(1,)
*/
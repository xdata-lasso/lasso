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
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1001, 1005, '1970-01-01', 'Allison Hill', '1974-05-05', 'http://www.santos.org/', 'Unit 6184 Box 9593
DPO AP 09617', 'chair', 1009, 1013, 1017, 1021, 1025, 'https://ross.net/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1002, 1010.0, '1970-01-02', 'Noah Rhodes', '1974-05-06', 'https://www.wolfe.com/', '1316 Chavez Village
Franciscostad, IL 88342', 'employee', 1028.0, 1034.0, 1040.0, 1046.0, 1052.0, 'https://www.callahan.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1003, 1015.0, '1970-01-03', 'Angie Henderson', '1974-05-07', 'http://www.garcia-james.com/', '283 Steven Groves
Lake Mark, WI 07832', 'size', 1047.0, 1055.0, 1063.0, 1071.0, 1079.0, 'https://www.james-ferrell.net/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1004, 1020.0, '1970-01-04', 'Daniel Wagner', '1974-05-08', 'https://blair.com/', '6413 Lewis Parks
Wilkersonmouth, FL 35219', 'option', 1066.0, 1076.0, 1086.0, 1096.0, 1106.0, 'https://www.le.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1048, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (0, 1032, 1036, '1978-09-09', 1040, 1044, 'specific', 1048, '1982-02-13', 'Hospital doctor', 'about', 1052, 1056, 1060, 1001, '1986-06-17', '1990-10-21', 1064, '1994-03-02', 'Jonathan White', 'April Nguyen');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1029, 1037.0, 1043.0, '1978-09-10', 1051.0, 1057.0, 'put', 1048, '1982-02-14', 'Presenter, broadcasting', 'seven', 1077.0, 1083.0, 1089.0, 1001, '1986-06-18', '1990-10-22', 1101.0, '1994-03-03', 'Sheila Evans', 'Timothy Koch');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1030, 1042.0, 1050.0, '1978-09-11', 1062.0, 1070.0, 'grow', 1048, '1982-02-15', 'Designer, industrial/product', 'type', 1102.0, 1110.0, 1118.0, 1001, '1986-06-19', '1990-10-23', 1138.0, '1994-03-04', 'Lisa Hernandez', 'Elizabeth Brown');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1031, 1047.0, 1057.0, '1978-09-12', 1073.0, 1083.0, 'brother', 1048, '1982-02-16', 'Professor Emeritus', 'serve', 1127.0, 1137.0, 1147.0, 1001, '1986-06-20', '1990-10-24', 1175.0, '1994-03-05', 'Kimberly Osborne', 'Theresa Miller');
INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (1068, 'Mr. Philip Cannon', 1072, 0, 1076);
INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (1069, 'John Pierce', 1079.0, 0, 1087.0);
INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (1070, 'Shane Henderson', 1086.0, 0, 1098.0);
INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (1071, 'Joshua Blair', 1093.0, 0, 1109.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Score FROM posts WHERE Id = (SELECT ExcerptPostId FROM tags ORDER BY Count DESC, tags.id NULLS LAST LIMIT 1);

/*
Gold Result:
(1040,)
*/

-- Prediction Query
SELECT SUM(Score) AS TotalScore FROM posts WHERE DATE(LasActivityDate) = '2010-07-19';

/*
Prediction Result:
(None,)
*/
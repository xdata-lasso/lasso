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
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (26, 30, NULL, 38);
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (25, 30, '47', 48);
INSERT INTO "comments" ("id", "postid", "userid", "score", "text", "creationdate", "userdisplayname") VALUES (28, 29, 30, 39, '40', 41, '42');
INSERT INTO "comments" ("id", "postid", "userid", "score", "text", "creationdate", "userdisplayname") VALUES (27, 29, 30, 43, '44', 45, '46');
INSERT INTO "postLinks" ("id", "postid", "relatedpostid", "creationdate", "linktypeid") VALUES (30, 23, 23, 30, 30);
INSERT INTO "posts" ("id", "lasteditoruserid", "owneruserid", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (23, NULL, NULL, 30, 30, 30, 30, 30, '30', 30, '30', '30', 30, 30, 30, 30, 30, 30, 30, '30', '30');
INSERT INTO "posts" ("id", "lasteditoruserid", "owneruserid", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (29, NULL, 30, 30, 30, 30, 30, 30, '30', 30, '30', '30', 30, 30, 30, 30, 30, 30, 30, '30', '30');
INSERT INTO "tags" ("id", "excerptpostid", "tagname", "count", "wikipostid") VALUES (32, 29, '30', 30, 30);
INSERT INTO "tags" ("id", "excerptpostid", "tagname", "count", "wikipostid") VALUES (31, 29, '30', 30, 30);
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (30, 30, 30, '30', 30, '30', '30', '30', 30, 30, 30, 30, 30, '30');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (24, 30, 30, '30', 30, '30', '30', '30', 30, 30, 30, 30, 30, '30');
INSERT INTO "votes" ("id", "postid", "userid", "votetypeid", "creationdate", "bountyamount") VALUES (30, 29, 30, 30, '1000-01-31', 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Name FROM badges AS T1 INNER JOIN comments AS T2 ON T1.UserId = t2.UserId GROUP BY T2.UserId ORDER BY COUNT(T2.UserId) DESC, Name NULLS LAST LIMIT 1;

/*
Gold Result:
('47',)
*/

-- Prediction Query
SELECT b.Name FROM comments AS c INNER JOIN badges AS b ON c.UserId = b.UserId WHERE c.UserId = (SELECT UserId FROM comments GROUP BY UserId ORDER BY COUNT(Id) DESC, UserId NULLS LAST LIMIT 1);

/*
Prediction Result:
(None,)
('47',)
(None,)
('47',)
*/
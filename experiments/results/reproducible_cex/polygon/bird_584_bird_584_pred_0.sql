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
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (41, 91, 'Why square the difference instead of taking the absolute value in standard deviation?42', 42);
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (40, 91, 'Why square the difference instead of taking the absolute value in standard deviation?42', 42);
INSERT INTO "comments" ("id", "postid", "userid", "score", "text", "creationdate", "userdisplayname") VALUES (67, 42, 43, 68, 'Why square the difference instead of taking the absolute value in standard deviation?69', 70, NULL);
INSERT INTO "comments" ("id", "postid", "userid", "score", "text", "creationdate", "userdisplayname") VALUES (90, 42, 91, NULL, NULL, NULL, NULL);
INSERT INTO "postHistory" ("id", "postid", "userid", "posthistorytypeid", "revisionguid", "creationdate", "text", "comment", "userdisplayname") VALUES (38, 42, 43, NULL, NULL, 56, 'Why square the difference instead of taking the absolute value in standard deviation?57', 'Why square the difference instead of taking the absolute value in standard deviation?63', NULL);
INSERT INTO "postHistory" ("id", "postid", "userid", "posthistorytypeid", "revisionguid", "creationdate", "text", "comment", "userdisplayname") VALUES (37, 42, 43, NULL, NULL, NULL, NULL, 'Why square the difference instead of taking the absolute value in standard deviation?63', NULL);
INSERT INTO "postLinks" ("id", "postid", "relatedpostid", "creationdate", "linktypeid") VALUES (45, 42, 39, 42, 42);
INSERT INTO "postLinks" ("id", "postid", "relatedpostid", "creationdate", "linktypeid") VALUES (44, 42, 39, 42, 42);
INSERT INTO "posts" ("id", "lasteditoruserid", "owneruserid", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (42, 43, NULL, 73, 74, NULL, NULL, NULL, 'Why square the difference instead of taking the absolute value in standard deviation?78', 79, 'Why square the difference instead of taking the absolute value in standard deviation?', 'Why square the difference instead of taking the absolute value in standard deviation?80', NULL, NULL, NULL, NULL, NULL, NULL, 87, 'Why square the difference instead of taking the absolute value in standard deviation?88', 'Why square the difference instead of taking the absolute value in standard deviation?89');
INSERT INTO "posts" ("id", "lasteditoruserid", "owneruserid", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (39, 91, NULL, 42, 42, 42, 42, 42, 'Why square the difference instead of taking the absolute value in standard deviation?42', 42, 'Why square the difference instead of taking the absolute value in standard deviation?42', 'Why square the difference instead of taking the absolute value in standard deviation?42', 42, 42, 42, 42, 42, 42, 42, 'Why square the difference instead of taking the absolute value in standard deviation?42', 'Why square the difference instead of taking the absolute value in standard deviation?42');
INSERT INTO "tags" ("id", "excerptpostid", "tagname", "count", "wikipostid") VALUES (47, 39, 'Why square the difference instead of taking the absolute value in standard deviation?42', 42, 42);
INSERT INTO "tags" ("id", "excerptpostid", "tagname", "count", "wikipostid") VALUES (46, 39, 'Why square the difference instead of taking the absolute value in standard deviation?42', 42, 42);
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (43, 42, 42, 'Why square the difference instead of taking the absolute value in standard deviation?42', 42, 'Why square the difference instead of taking the absolute value in standard deviation?42', 'Why square the difference instead of taking the absolute value in standard deviation?42', 'Why square the difference instead of taking the absolute value in standard deviation?42', 42, 42, 42, 42, 42, 'Why square the difference instead of taking the absolute value in standard deviation?42');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (91, 42, 42, 'Why square the difference instead of taking the absolute value in standard deviation?42', 42, 'Why square the difference instead of taking the absolute value in standard deviation?42', 'Why square the difference instead of taking the absolute value in standard deviation?42', 'Why square the difference instead of taking the absolute value in standard deviation?42', 42, 42, 42, 42, 42, 'Why square the difference instead of taking the absolute value in standard deviation?42');
INSERT INTO "votes" ("id", "postid", "userid", "votetypeid", "creationdate", "bountyamount") VALUES (49, 39, 91, 42, '1000-02-12', 42);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Comment FROM posts AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.PostId WHERE T1.Title = 'Why square the difference instead of taking the absolute value in standard deviation?';

/*
Gold Result:
('Why square the difference instead of taking the absolute value in standard deviation?63',)
('Why square the difference instead of taking the absolute value in standard deviation?63',)
*/

-- Prediction Query
SELECT T2.Text FROM posts AS T1 INNER JOIN comments AS T2 ON T1.Id = T2.PostId INNER JOIN postHistory AS T3 ON T1.Id = T3.PostId WHERE T1.Title = 'Why square the difference instead of taking the absolute value in standard deviation?' AND T3.UserId = T2.UserId;

/*
Prediction Result:
('Why square the difference instead of taking the absolute value in standard deviation?69',)
('Why square the difference instead of taking the absolute value in standard deviation?69',)
*/
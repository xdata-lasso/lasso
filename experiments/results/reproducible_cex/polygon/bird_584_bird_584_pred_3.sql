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
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (39, 62, 'Why square the difference instead of taking the absolute value in standard deviation?42', 42);
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (38, 62, 'Why square the difference instead of taking the absolute value in standard deviation?42', 42);
INSERT INTO "comments" ("id", "postid", "userid", "score", "text", "creationdate", "userdisplayname") VALUES (41, 42, 76, 85, 'Why square the difference instead of taking the absolute value in standard deviation?81', 86, 'Why square the difference instead of taking the absolute value in standard deviation?87');
INSERT INTO "comments" ("id", "postid", "userid", "score", "text", "creationdate", "userdisplayname") VALUES (40, 42, 62, 88, 'Why square the difference instead of taking the absolute value in standard deviation?81', 89, 'Why square the difference instead of taking the absolute value in standard deviation?90');
INSERT INTO "postHistory" ("id", "postid", "userid", "posthistorytypeid", "revisionguid", "creationdate", "text", "comment", "userdisplayname") VALUES (51, 42, 62, 52, 'Why square the difference instead of taking the absolute value in standard deviation?53', 54, 'Why square the difference instead of taking the absolute value in standard deviation?55', 'Why square the difference instead of taking the absolute value in standard deviation?81', 'Why square the difference instead of taking the absolute value in standard deviation?56');
INSERT INTO "postHistory" ("id", "postid", "userid", "posthistorytypeid", "revisionguid", "creationdate", "text", "comment", "userdisplayname") VALUES (75, 42, 76, 77, 'Why square the difference instead of taking the absolute value in standard deviation?78', 79, 'Why square the difference instead of taking the absolute value in standard deviation?80', 'Why square the difference instead of taking the absolute value in standard deviation?81', NULL);
INSERT INTO "postLinks" ("id", "postid", "relatedpostid", "creationdate", "linktypeid") VALUES (42, 42, 42, 42, 42);
INSERT INTO "posts" ("id", "lasteditoruserid", "owneruserid", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (37, 76, 76, 42, 42, 42, 42, 42, 'Why square the difference instead of taking the absolute value in standard deviation?42', 42, 'Why square the difference instead of taking the absolute value in standard deviation?42', 'Why square the difference instead of taking the absolute value in standard deviation?42', 42, 42, 42, 42, 42, 42, 42, 'Why square the difference instead of taking the absolute value in standard deviation?42', 'Why square the difference instead of taking the absolute value in standard deviation?42');
INSERT INTO "posts" ("id", "lasteditoruserid", "owneruserid", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (42, 76, 62, 61, 60, 59, 58, 57, 'Why square the difference instead of taking the absolute value in standard deviation?63', 64, 'Why square the difference instead of taking the absolute value in standard deviation?', 'Why square the difference instead of taking the absolute value in standard deviation?65', 66, 67, 68, 69, 70, 71, 72, 'Why square the difference instead of taking the absolute value in standard deviation?73', 'Why square the difference instead of taking the absolute value in standard deviation?74');
INSERT INTO "tags" ("id", "excerptpostid", "tagname", "count", "wikipostid") VALUES (44, 42, 'Why square the difference instead of taking the absolute value in standard deviation?42', 42, 42);
INSERT INTO "tags" ("id", "excerptpostid", "tagname", "count", "wikipostid") VALUES (43, 37, 'Why square the difference instead of taking the absolute value in standard deviation?42', 42, 42);
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (62, 42, 42, 'Why square the difference instead of taking the absolute value in standard deviation?42', 42, 'Why square the difference instead of taking the absolute value in standard deviation?42', 'Why square the difference instead of taking the absolute value in standard deviation?42', 'Why square the difference instead of taking the absolute value in standard deviation?42', 42, 42, 42, 42, 42, 'Why square the difference instead of taking the absolute value in standard deviation?42');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (76, 42, 42, 'Why square the difference instead of taking the absolute value in standard deviation?42', 42, 'Why square the difference instead of taking the absolute value in standard deviation?42', 'Why square the difference instead of taking the absolute value in standard deviation?42', 'Why square the difference instead of taking the absolute value in standard deviation?42', 42, 42, 42, 42, 42, 'Why square the difference instead of taking the absolute value in standard deviation?42');
INSERT INTO "votes" ("id", "postid", "userid", "votetypeid", "creationdate", "bountyamount") VALUES (46, 42, 76, 42, '1000-02-12', 42);
INSERT INTO "votes" ("id", "postid", "userid", "votetypeid", "creationdate", "bountyamount") VALUES (45, 42, 76, 42, '1000-02-12', 42);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Comment FROM posts AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.PostId WHERE T1.Title = 'Why square the difference instead of taking the absolute value in standard deviation?';

/*
Gold Result:
('Why square the difference instead of taking the absolute value in standard deviation?81',)
('Why square the difference instead of taking the absolute value in standard deviation?81',)
*/

-- Prediction Query
SELECT c.Text FROM posts AS p INNER JOIN postHistory AS ph ON p.Id = ph.PostId INNER JOIN comments AS c ON ph.PostId = c.PostId WHERE p.Title = 'Why square the difference instead of taking the absolute value in standard deviation?';

/*
Prediction Result:
('Why square the difference instead of taking the absolute value in standard deviation?81',)
('Why square the difference instead of taking the absolute value in standard deviation?81',)
('Why square the difference instead of taking the absolute value in standard deviation?81',)
('Why square the difference instead of taking the absolute value in standard deviation?81',)
*/
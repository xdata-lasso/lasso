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
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (40, 69, 'Why square the difference instead of taking the absolute value in standard deviation?38', 38);
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (39, NULL, 'Why square the difference instead of taking the absolute value in standard deviation?38', 38);
INSERT INTO "comments" ("id", "postid", "userid", "score", "text", "creationdate", "userdisplayname") VALUES (64, 38, 80, 65, 'Why square the difference instead of taking the absolute value in standard deviation?85', 66, 'Why square the difference instead of taking the absolute value in standard deviation?67');
INSERT INTO "comments" ("id", "postid", "userid", "score", "text", "creationdate", "userdisplayname") VALUES (75, 38, 69, 76, 'Why square the difference instead of taking the absolute value in standard deviation?85', 77, 'Why square the difference instead of taking the absolute value in standard deviation?78');
INSERT INTO "postHistory" ("id", "postid", "userid", "posthistorytypeid", "revisionguid", "creationdate", "text", "comment", "userdisplayname") VALUES (68, 38, 69, 70, 'Why square the difference instead of taking the absolute value in standard deviation?71', 72, 'Why square the difference instead of taking the absolute value in standard deviation?73', 'Why square the difference instead of taking the absolute value in standard deviation?85', NULL);
INSERT INTO "postHistory" ("id", "postid", "userid", "posthistorytypeid", "revisionguid", "creationdate", "text", "comment", "userdisplayname") VALUES (79, 38, 80, 81, 'Why square the difference instead of taking the absolute value in standard deviation?82', 83, 'Why square the difference instead of taking the absolute value in standard deviation?84', 'Why square the difference instead of taking the absolute value in standard deviation?85', 'Why square the difference instead of taking the absolute value in standard deviation?86');
INSERT INTO "postLinks" ("id", "postid", "relatedpostid", "creationdate", "linktypeid") VALUES (38, NULL, 37, 38, 38);
INSERT INTO "posts" ("id", "lasteditoruserid", "owneruserid", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (38, 80, 80, 47, 48, 49, 50, 51, 'Why square the difference instead of taking the absolute value in standard deviation?52', 53, 'Why square the difference instead of taking the absolute value in standard deviation?', NULL, 55, NULL, NULL, 58, 59, 60, 61, 'Why square the difference instead of taking the absolute value in standard deviation?62', 'Why square the difference instead of taking the absolute value in standard deviation?63');
INSERT INTO "posts" ("id", "lasteditoruserid", "owneruserid", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (37, NULL, NULL, 38, 38, 38, 38, 38, 'Why square the difference instead of taking the absolute value in standard deviation?38', 38, 'Why square the difference instead of taking the absolute value in standard deviation?38', 'Why square the difference instead of taking the absolute value in standard deviation?38', 38, 38, 38, 38, 38, 38, 38, 'Why square the difference instead of taking the absolute value in standard deviation?38', 'Why square the difference instead of taking the absolute value in standard deviation?38');
INSERT INTO "tags" ("id", "excerptpostid", "tagname", "count", "wikipostid") VALUES (42, 38, 'Why square the difference instead of taking the absolute value in standard deviation?38', 38, 38);
INSERT INTO "tags" ("id", "excerptpostid", "tagname", "count", "wikipostid") VALUES (41, 38, 'Why square the difference instead of taking the absolute value in standard deviation?38', 38, 38);
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (69, 38, 38, 'Why square the difference instead of taking the absolute value in standard deviation?38', 38, 'Why square the difference instead of taking the absolute value in standard deviation?38', 'Why square the difference instead of taking the absolute value in standard deviation?38', 'Why square the difference instead of taking the absolute value in standard deviation?38', 38, 38, 38, 38, 38, 'Why square the difference instead of taking the absolute value in standard deviation?38');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (80, 38, 38, 'Why square the difference instead of taking the absolute value in standard deviation?38', 38, 'Why square the difference instead of taking the absolute value in standard deviation?38', 'Why square the difference instead of taking the absolute value in standard deviation?38', 'Why square the difference instead of taking the absolute value in standard deviation?38', 38, 38, 38, 38, 38, 'Why square the difference instead of taking the absolute value in standard deviation?38');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Comment FROM posts AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.PostId WHERE T1.Title = 'Why square the difference instead of taking the absolute value in standard deviation?';

/*
Gold Result:
('Why square the difference instead of taking the absolute value in standard deviation?85',)
('Why square the difference instead of taking the absolute value in standard deviation?85',)
*/

-- Prediction Query
SELECT "comments"."text" FROM "comments" INNER JOIN "posthistory" ON "comments"."postid" = "posthistory"."postid" INNER JOIN "posts" ON "posthistory"."postid" = "posts"."id" WHERE "posts"."title" = 'Why square the difference instead of taking the absolute value in standard deviation?';

/*
Prediction Result:
('Why square the difference instead of taking the absolute value in standard deviation?85',)
('Why square the difference instead of taking the absolute value in standard deviation?85',)
('Why square the difference instead of taking the absolute value in standard deviation?85',)
('Why square the difference instead of taking the absolute value in standard deviation?85',)
*/
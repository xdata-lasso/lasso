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
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (31, 84, 'What is the best introductory Bayesian statistics textbook?42', 42);
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (30, 42, 'What is the best introductory Bayesian statistics textbook?42', 42);
INSERT INTO "comments" ("id", "postid", "userid", "score", "text", "creationdate", "userdisplayname") VALUES (33, 60, 42, 42, 'What is the best introductory Bayesian statistics textbook?42', 42, 'What is the best introductory Bayesian statistics textbook?42');
INSERT INTO "comments" ("id", "postid", "userid", "score", "text", "creationdate", "userdisplayname") VALUES (32, 60, 42, 42, 'What is the best introductory Bayesian statistics textbook?42', 42, 'What is the best introductory Bayesian statistics textbook?42');
INSERT INTO "postHistory" ("id", "postid", "userid", "posthistorytypeid", "revisionguid", "creationdate", "text", "comment", "userdisplayname") VALUES (59, 60, 42, 61, 'What is the best introductory Bayesian statistics textbook?62', 63, 'What is the best introductory Bayesian statistics textbook?64', 'What is the best introductory Bayesian statistics textbook?65', 'What is the best introductory Bayesian statistics textbook?66');
INSERT INTO "postHistory" ("id", "postid", "userid", "posthistorytypeid", "revisionguid", "creationdate", "text", "comment", "userdisplayname") VALUES (1, 83, 84, 85, 'What is the best introductory Bayesian statistics textbook?86', 87, 'What is the best introductory Bayesian statistics textbook?88', 'What is the best introductory Bayesian statistics textbook?89', 'What is the best introductory Bayesian statistics textbook?90');
INSERT INTO "postLinks" ("id", "postid", "relatedpostid", "creationdate", "linktypeid") VALUES (35, 60, 83, 42, 42);
INSERT INTO "postLinks" ("id", "postid", "relatedpostid", "creationdate", "linktypeid") VALUES (34, 83, 83, 42, 42);
INSERT INTO "posts" ("id", "lasteditoruserid", "owneruserid", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (60, 42, 84, 43, 44, 45, 46, 47, 'What is the best introductory Bayesian statistics textbook?48', 49, 'What is the best introductory Bayesian statistics textbook?', 'What is the best introductory Bayesian statistics textbook?50', 51, 52, 53, 1, 54, 55, 56, 'What is the best introductory Bayesian statistics textbook?57', 'What is the best introductory Bayesian statistics textbook?58');
INSERT INTO "posts" ("id", "lasteditoruserid", "owneruserid", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (83, 42, 42, 71, 70, 69, 68, 67, 'What is the best introductory Bayesian statistics textbook?72', 73, 'What is the best introductory Bayesian statistics textbook?', 'What is the best introductory Bayesian statistics textbook?74', 75, 76, 77, 1, 78, 79, 80, 'What is the best introductory Bayesian statistics textbook?81', 'What is the best introductory Bayesian statistics textbook?82');
INSERT INTO "tags" ("id", "excerptpostid", "tagname", "count", "wikipostid") VALUES (37, 83, 'What is the best introductory Bayesian statistics textbook?42', 42, 42);
INSERT INTO "tags" ("id", "excerptpostid", "tagname", "count", "wikipostid") VALUES (36, 83, 'What is the best introductory Bayesian statistics textbook?42', 42, 42);
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (84, 42, 42, 'What is the best introductory Bayesian statistics textbook?42', 42, 'What is the best introductory Bayesian statistics textbook?42', 'What is the best introductory Bayesian statistics textbook?42', 'What is the best introductory Bayesian statistics textbook?42', 42, 42, 42, 42, 42, 'What is the best introductory Bayesian statistics textbook?42');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (42, 42, 42, 'What is the best introductory Bayesian statistics textbook?42', 42, 'What is the best introductory Bayesian statistics textbook?42', 'What is the best introductory Bayesian statistics textbook?42', 'What is the best introductory Bayesian statistics textbook?42', 42, 42, 42, 42, 42, 'What is the best introductory Bayesian statistics textbook?42');
INSERT INTO "votes" ("id", "postid", "userid", "votetypeid", "creationdate", "bountyamount") VALUES (42, 83, 42, 42, '1000-02-12', 42);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Id, T2.LastEditDate FROM postHistory AS T1 INNER JOIN posts AS T2 ON T1.PostId = T2.Id WHERE T2.Title = 'What is the best introductory Bayesian statistics textbook?';

/*
Gold Result:
(1, 1)
(59, 1)
*/

-- Prediction Query
SELECT "posts"."lasteditdate", COUNT("posthistory"."id") AS "history_count" FROM "posts" INNER JOIN "posthistory" ON "posts"."id" = "posthistory"."postid" WHERE "posts"."title" = 'What is the best introductory Bayesian statistics textbook?' GROUP BY "posts"."id";

/*
Prediction Result:
(1, 1)
(1, 1)
*/
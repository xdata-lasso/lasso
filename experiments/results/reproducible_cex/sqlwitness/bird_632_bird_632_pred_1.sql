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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (1, 1, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 01:00:00.000000', NULL, NULL, 'Harlan', NULL, NULL, 1, NULL, NULL, 'Harlan'), (0, NULL, NULL, 'default2', NULL, NULL, 'default2', NULL, 1, NULL, 1, 0, NULL, 'default2'), (2, NULL, NULL, 'default1', '2023-01-01 00:00:00.000000', 'default1', 'default2', 'default1', 1, 0, 0, 0, 0, NULL), (3, 1, '2023-01-01 01:00:00.000000', 'Harlan', '2023-01-01 00:00:00.000000', 'default2', 'default1', 'default1', 1, 1, NULL, 0, 1, 'default2'), (4, 0, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 01:00:00.000000', NULL, 'default1', NULL, NULL, 0, 0, 1, 1, NULL), (5, 0, '2023-01-01 01:00:00.000000', 'Harlan', '2023-01-01 00:00:00.000000', 'Harlan', 'default1', 'Harlan', NULL, 0, 0, 0, 0, 'default2'), (6, NULL, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 00:00:00.000000', 'default1', NULL, 'default1', 0, 0, NULL, 0, 1, 'default2'), (7, 0, '2023-01-01 01:00:00.000000', 'Harlan', '2023-01-01 00:00:00.000000', 'Harlan', NULL, 'default1', 0, NULL, NULL, 0, NULL, 'Harlan'), (8, 0, '2023-01-01 01:00:00.000000', 'Harlan', NULL, 'default2', NULL, 'Harlan', 1, 1, 1, NULL, 1, 'default2');
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (0, NULL, 0, 0, 0, NULL, NULL, 1, 'default2', NULL, 'default1', NULL, NULL, 1, NULL, '2023-01-01 00:00:00.000000', '2023-01-01 01:00:00.000000', NULL, '2023-01-01 01:00:00.000000', 'default1', NULL), (1, 8, 0, 0, 0, '2023-01-01 01:00:00.000000', NULL, NULL, 'Harlan', '2023-01-01 00:00:00.000000', 'default1', 'Harlan', NULL, 1, 0, '2023-01-01 01:00:00.000000', '2023-01-01 01:00:00.000000', 1, NULL, 'default2', NULL), (2, 8, NULL, NULL, NULL, '2023-01-01 00:00:00.000000', 0, 0, NULL, '2023-01-01 01:00:00.000000', NULL, NULL, 1, 0, 0, '2023-01-01 00:00:00.000000', NULL, NULL, NULL, 'default2', 'Harlan'), (3, 4, 3, 1, NULL, '2023-01-01 00:00:00.000000', 1, 0, 'default1', '2023-01-01 01:00:00.000000', NULL, 'Harlan', 0, 0, 1, NULL, NULL, 1, '2023-01-01 00:00:00.000000', 'Harlan', 'Harlan'), (4, 0, NULL, 0, 1, NULL, NULL, 1, 'default1', NULL, 'default1', 'default2', 0, 0, 0, '2023-01-01 01:00:00.000000', '2023-01-01 00:00:00.000000', 0, NULL, 'Harlan', 'default1'), (5, 8, 1, NULL, 0, '2023-01-01 00:00:00.000000', 1, 1, 'Harlan', '2023-01-01 01:00:00.000000', 'default1', 'Harlan', 0, 0, NULL, '2023-01-01 01:00:00.000000', '2023-01-01 00:00:00.000000', 0, '2023-01-01 00:00:00.000000', NULL, 'Harlan');
INSERT INTO votes (id, postid, userid, votetypeid, creationdate, bountyamount) VALUES (1, 2, 0, NULL, NULL, 1), (0, 3, 1, 0, '2023-01-01', 1), (2, 3, 7, 0, NULL, NULL), (3, 5, NULL, NULL, NULL, 0), (4, 1, 8, NULL, '2023-01-02', 1), (5, NULL, 4, NULL, '2023-01-02', NULL), (6, 0, 0, 0, NULL, NULL), (7, NULL, 6, NULL, '2023-01-01', 0), (8, 3, 0, 1, '2023-01-01', 1), (9, 2, 1, NULL, '2023-01-01', NULL);
INSERT INTO posthistory (id, postid, userid, posthistorytypeid, revisionguid, creationdate, text, comment, userdisplayname) VALUES (0, 1, 7, NULL, NULL, '2023-01-01 00:00:00.000000', 'default2', 'default1', 'Harlan'), (1, 1, 3, 1, 'Harlan', '2023-01-01 00:00:00.000000', NULL, 'default1', 'default1'), (2, 4, 0, 0, NULL, '2023-01-01 01:00:00.000000', 'default2', 'default1', 'default2'), (3, NULL, 0, 0, 'default1', '2023-01-01 01:00:00.000000', 'default2', 'Harlan', 'Harlan'), (4, 3, NULL, 0, 'default2', '2023-01-01 01:00:00.000000', 'default2', 'Harlan', 'default2'), (5, NULL, 0, NULL, 'Harlan', NULL, 'default2', NULL, NULL), (6, 3, 5, 1, 'Harlan', '2023-01-01 00:00:00.000000', 'Harlan', NULL, 'default1'), (7, 1, 8, 1, 'default2', NULL, 'default2', 'Harlan', 'default1'), (8, 0, 0, NULL, 'default2', '2023-01-01 01:00:00.000000', 'Harlan', 'default2', 'default2'), (9, 4, 0, 1, 'default1', NULL, 'default1', 'default1', NULL), (10, 3, NULL, 0, NULL, '2023-01-01 01:00:00.000000', 'Harlan', 'default2', 'Harlan');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.Id) FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId INNER JOIN votes AS T3 ON T3.PostId = T2.PostId WHERE T1.DisplayName = 'Harlan';

/*
Gold Result:
(6,)
*/

-- Prediction Query
SELECT COUNT(votes.Id) AS VoteCount FROM votes INNER JOIN users ON votes.UserId = users.Id WHERE users.DisplayName = 'Harlan';

/*
Prediction Result:
(2,)
*/
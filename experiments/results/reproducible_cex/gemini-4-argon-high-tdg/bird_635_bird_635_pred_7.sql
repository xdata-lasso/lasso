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
-- DATASET 1
INSERT INTO users (Id, DisplayName, Reputation) VALUES (10, 'Matt Parker', 500);
INSERT INTO users (Id, DisplayName, Reputation) VALUES (20, 'Other User', 100);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, OwnerDisplayName, LastEditorDisplayName, Title) VALUES (100, 20, 20, 'Other User', 'Other User', 'Post with 5 edits');
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, OwnerDisplayName, LastEditorDisplayName, Title) VALUES (200, 20, 20, 'Other User', 'Other User', 'Post with 4 edits');
INSERT INTO postHistory (Id, PostId, UserId, UserDisplayName) VALUES (1, 100, 10, 'Other User');
INSERT INTO postHistory (Id, PostId, UserId, UserDisplayName) VALUES (2, 100, 10, 'Other User');
INSERT INTO postHistory (Id, PostId, UserId, UserDisplayName) VALUES (3, 100, 10, 'Other User');
INSERT INTO postHistory (Id, PostId, UserId, UserDisplayName) VALUES (4, 100, 10, 'Other User');
INSERT INTO postHistory (Id, PostId, UserId, UserDisplayName) VALUES (5, 100, 10, 'Other User');
INSERT INTO postHistory (Id, PostId, UserId, UserDisplayName) VALUES (6, 200, 10, 'Other User');
INSERT INTO postHistory (Id, PostId, UserId, UserDisplayName) VALUES (7, 200, 10, 'Other User');
INSERT INTO postHistory (Id, PostId, UserId, UserDisplayName) VALUES (8, 200, 10, 'Other User');
INSERT INTO postHistory (Id, PostId, UserId, UserDisplayName) VALUES (9, 200, 10, 'Other User');
INSERT INTO votes (Id, PostId, UserId, VoteTypeId) VALUES (1000, 100, 20, 2);
INSERT INTO votes (Id, PostId, UserId, VoteTypeId) VALUES (2000, 200, 20, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.Id) FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId INNER JOIN posts AS T3 ON T2.PostId = T3.Id INNER JOIN votes AS T4 ON T4.PostId = T3.Id WHERE T1.DisplayName = 'Matt Parker' GROUP BY T2.PostId, T4.Id HAVING COUNT(T4.Id) > 4;

/*
Gold Result:
(5,)
*/

-- Prediction Query
SELECT COUNT(*) FROM (SELECT votes.postid FROM votes INNER JOIN posts ON votes.postid = posts.id INNER JOIN users ON posts.owneruserid = users.id WHERE users.displayname = 'Matt Parker' GROUP BY votes.postid HAVING COUNT(votes.id) > 4) AS valid_posts;

/*
Prediction Result:
(0,)
*/
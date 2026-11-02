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
INSERT INTO users (Id, Reputation, Views, UpVotes, DownVotes, AccountId, Age) VALUES (1, 100, 10, 5, 1, 101, 25);
INSERT INTO users (Id, Reputation, Views, UpVotes, DownVotes, AccountId, Age) VALUES (2, 200, 20, 10, 2, 102, 40);
INSERT INTO users (Id, Reputation, Views, UpVotes, DownVotes, AccountId, Age) VALUES (3, 300, 30, 15, 3, 103, 60);
INSERT INTO posts (Id, PostTypeId, Score, ViewCount, OwnerUserId) VALUES (100, 1, 10, 100, 1);
INSERT INTO posts (Id, PostTypeId, Score, ViewCount, OwnerUserId) VALUES (200, 1, 20, 200, 2);
INSERT INTO posts (Id, PostTypeId, Score, ViewCount, OwnerUserId) VALUES (300, 2, 30, 300, 3);
INSERT INTO votes (Id, PostId, VoteTypeId, UserId, BountyAmount) VALUES (1, 100, 2, 3, 50);
INSERT INTO votes (Id, PostId, VoteTypeId, UserId, BountyAmount) VALUES (2, 200, 3, 3, 100);
INSERT INTO votes (Id, PostId, VoteTypeId, UserId, BountyAmount) VALUES (3, 300, 2, 1, 0);
INSERT INTO votes (Id, PostId, VoteTypeId, UserId, BountyAmount) VALUES (4, 300, 2, 2, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(PostId) FROM votes WHERE UserId IN (SELECT Id FROM users WHERE Age = (SELECT MAX(Age) FROM users));

/*
Gold Result:
(150.0,)
*/

-- Prediction Query
SELECT AVG(vote_count) FROM (SELECT COUNT(t2.postid) AS vote_count FROM users AS t1 INNER JOIN votes AS t2 ON t1.id = t2.userid WHERE t1.age = (SELECT MAX(age) FROM users) GROUP BY t1.id) AS vote_counts;

/*
Prediction Result:
(2.0,)
*/
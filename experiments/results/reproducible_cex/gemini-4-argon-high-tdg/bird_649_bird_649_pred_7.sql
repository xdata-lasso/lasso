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
INSERT INTO users (Id, DisplayName, Reputation) VALUES (1, 'Alice', 1500);
INSERT INTO users (Id, DisplayName, Reputation) VALUES (2, 'Bob', 800);
INSERT INTO posts (Id, PostTypeId, CreaionDate, LasActivityDate, LastEditDate, ClosedDate, CommunityOwnedDate, Title, Body, OwnerUserId, LastEditorUserId, Score) VALUES (10, 1, '2020-01-01 08:00:00', '2020-06-01 12:00:00', '2020-05-15 10:30:00', '2020-07-01 00:00:00', '2020-08-01 00:00:00', 'What is the best introductory Bayesian statistics textbook?', 'Looking for book recommendations.', 1, 2, 25);
INSERT INTO posts (Id, PostTypeId, CreaionDate, LasActivityDate, LastEditDate, Title, Body, OwnerUserId, LastEditorUserId, Score) VALUES (20, 1, '2021-01-01 09:00:00', '2021-04-01 15:00:00', '2021-03-10 14:00:00', 'Another statistics question', 'Some other body text.', 2, 1, 10);
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, CreationDate, UserId, Text, Comment) VALUES (101, 1, 10, '2020-01-01 08:00:00', 1, 'What is the best introductory Bayesian statistics textbook?', 'Initial title');
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, CreationDate, UserId, Text, Comment) VALUES (102, 5, 10, '2020-05-15 10:30:00', 2, 'Updated body content', 'Clarified question');
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, CreationDate, UserId, Text, Comment) VALUES (103, 1, 20, '2021-01-01 09:00:00', 2, 'Another statistics question', 'Initial title');
INSERT INTO comments (Id, PostId, Score, Text, CreationDate, UserId) VALUES (501, 10, 3, 'Have you checked Gelman?', '2020-01-02 10:00:00', 2);
INSERT INTO votes (Id, PostId, VoteTypeId, CreationDate, UserId) VALUES (601, 10, 2, '2020-01-02', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Id, T2.LastEditDate FROM postHistory AS T1 INNER JOIN posts AS T2 ON T1.PostId = T2.Id WHERE T2.Title = 'What is the best introductory Bayesian statistics textbook?';

/*
Gold Result:
(101, '2020-05-15 10:30:00')
(102, '2020-05-15 10:30:00')
*/

-- Prediction Query
SELECT COUNT(posthistory.id) AS post_history_counts, MAX(posthistory.creationdate) AS last_edit_date FROM posts INNER JOIN posthistory ON posts.id = posthistory.postid WHERE posts.title = 'What is the best introductory Bayesian statistics textbook?';

/*
Prediction Result:
(2, '2020-05-15 10:30:00')
*/
underpants-sh README
====================
"underpants" is a leaderboard to supplement the Brown CS consultant hours
leaderboard known as "[pants](https://github.com/mcomella/slacks)". While pants
handles hours exclusively, underpants handles any other statistics that can be
found on a leaderboard such as food and printer warnings given out.

This is a reimplementation (in zsh) of the [underpants originally written in
python](https://github.com/mcomella/underpants).

Usage
-----
To display a leaderboard for other consultant statistics, run
`./underpants.sh`.

Motivation
----------
I was researching how to push to all of git remotes simultaneously and
discovered a 100 line python script that did the trick. One commenter was
baffled! Why not `git remote | xargs -L 1 git push`?

[underpants]: https://github.com/mcomella/underpants

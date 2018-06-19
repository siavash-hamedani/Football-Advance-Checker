# Football-Advance-Checker
A Prolog program to check the possible ways a football team can advance from its group.

Does your team's possibility of advancing to the next round depend on other teams screwing up? Then this program is for you :D.

# Example Usage
to check the possible ways Iran can advance from its group consisting of [Iran,Spain,Morocco,Portugal] given that Iran won morocco and Spain and Portugal had a draw.

```prolog
?- teamAdvances(
      iran,                                     % the team you want to check advance conditon for
      [spain,morocco,iran,portugal],            % list of all teams in the group
      [win(iran,morocco),draw(spain,portugal)], % the outcomes that have been determined so far
      How,                                      % outputs the outcomes that will advance your team
      Score).                                   % the group score in the end

% breakdown of output -> spain wins morocco, spain wins iran, spain and portugal draw, iran wins morocco,
% morocco wins portugal, iran wins portugal (yeah right...). 
% iran can advance to next round with 6 score and as second team

How = [win(spain, morocco), win(spain, iran), draw(spain, portugal), win(iran, morocco), win(morocco, portugal), win(iran, portugal)],
Score = scores{iran:6, morocco:3, portugal:1, spain:7} ;

How = [draw(spain, morocco), win(spain, iran), draw(spain, portugal), win(iran, morocco), win(morocco, portugal), win(iran, portugal)],
Score = scores{iran:6, morocco:4, portugal:1, spain:5} ;

How = [win(morocco, spain), win(spain, iran), draw(spain, portugal), win(iran, morocco), win(morocco, portugal), win(iran, portugal)],
Score = scores{iran:6, morocco:6, portugal:1, spain:4} ;

How = [win(spain, morocco), draw(spain, iran), draw(spain, portugal), win(iran, morocco), win(morocco, portugal), win(iran, portugal)],
Score = scores{iran:7, morocco:3, portugal:1, spain:5} ;

How = [draw(spain, morocco), draw(spain, iran), draw(spain, portugal), win(iran, morocco), win(morocco, portugal), win(iran, portugal)],
Score = scores{iran:7, morocco:4, portugal:1, spain:3} ;

How = [win(morocco, spain), draw(spain, iran), draw(spain, portugal), win(iran, morocco), win(morocco, portugal), win(iran, portugal)],
Score = scores{iran:7, morocco:6, portugal:1, spain:2} ;

How = [win(spain, morocco), win(iran, spain), draw(spain, portugal), win(iran, morocco), win(morocco, portugal), win(iran, portugal)],
Score = scores{iran:9, morocco:3, portugal:1, spain:4} ;

How = [draw(spain, morocco), win(iran, spain), draw(spain, portugal), win(iran, morocco), win(morocco, portugal), win(iran, portugal)],
Score = scores{iran:9, morocco:4, portugal:1, spain:2} ;

How = [win(morocco, spain), win(iran, spain), draw(spain, portugal), win(iran, morocco), win(morocco, portugal), win(iran, portugal)],
Score = scores{iran:9, morocco:6, portugal:1, spain:1}
```

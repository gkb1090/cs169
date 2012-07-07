#!/usr/local/bin/ruby

class WrongNumberOfPlayersError < StandardError ; end
class NoSuchStrategyError < StandardError ; end

def rps_get_winner (game)
  raise WrongNumberOfPlayersError unless game.length == 2

  play1 = game[0][1].downcase
  play2 = game[1][1].downcase
  raise NoSuchStrategyError unless play1 =~ /^[prs]$/ and play2 =~ /^[prs]$/

  return game[0] unless (play2=="p" and play1=="r") or
    (play2=="r" and play1=="s") or (play2=="s" and play1=="p")
  return game[1]
end

print rps_get_winner([ ["Armando", "P"], ["Dave", "P"] ]); print "\n"
print rps_get_winner([ ["Armando", "P"], ["Dave", "R"] ]); print "\n"
print rps_get_winner([ ["Armando", "P"], ["Dave", "S"] ]); print "\n"
print rps_get_winner([ ["Armando", "S"], ["Dave", "P"] ]); print "\n"
print rps_get_winner([ ["Armando", "S"], ["Dave", "R"] ]); print "\n"
print rps_get_winner([ ["Armando", "S"], ["Dave", "S"] ]); print "\n"
print rps_get_winner([ ["Armando", "R"], ["Dave", "P"] ]); print "\n"
print rps_get_winner([ ["Armando", "R"], ["Dave", "R"] ]); print "\n"
print rps_get_winner([ ["Armando", "r"], ["Dave", "s"] ]); print "\n"

def rps_tournament_winner (trmnt)
  return rps_get_winner trmnt if is_game? trmnt
  return rps_tournament_winner [ rps_tournament_winner(trmnt[0]) ,
                                 rps_tournament_winner(trmnt[1]) ]
end

def is_game? (trmnt)
  return false unless trmnt.length == 2
  trmnt.map do |elt|
    return false unless elt[0].kind_of?(String) and elt[1].kind_of?(String)
  end
  return true
end

tmnt = [ [
          [ ["Armando", "P"], ["Dave", "S"] ],
          [ ["Richard", "R"], ["Michael", "S"] ]
          ],
         [
          [ ["Allen", "S"], ["Omer", "P"] ],
          [ ["David E.", "R"], ["Richard X.", "P"] ]
          ]
        ]
print rps_tournament_winner (tmnt); print "\n";

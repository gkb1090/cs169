#!/usr/local/bin/ruby

=begin
(a) Takes two element list and plays rock-paper-scissors
=end

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


=begin
(b) Uses rps_game_winner recursively to play a full tournament
=end

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


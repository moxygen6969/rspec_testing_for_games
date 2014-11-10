#!/usr/bin/env ruby
class TicTacToe
  attr_accessor :whowins, :player_moves, :player2_moves, :turns, :winpos, :total_grid, :board, :legality
  def initialize
    @legality = legality
    @whowins = whowins
    @player_moves = player_moves
    @turns = turns
    @winpos = winpos
    @total_grid = total_grid
    @board=board
    @whowins=nil
    @legality = 1
    @player_moves=[]
    @player2_moves=[]
    @turns=21
    @winpos=[[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
    @total_grid=[1,2,3,4,5,6,7,8,9]
  end
 
def end_of_turn(turns)  
     @turns-=1
     return "Turn #{((21 % @turns)/2)+1}"
end


def showBoard(player1_pos=nil,player2_pos=nil)
    player1_pos=@player_moves
    player2_pos=@player2_moves
    @board=[]
    1.upto(9) do |x|
    @board << "#{x}"
  end
   0.upto(8) do |x|
      0.upto(player1_pos.length-1) do |y|
        if player1_pos[y].to_i==@board[x].to_i
           @board[x]='X'
        end
      end
    end
    0.upto(8) do |x|
      0.upto(player2_pos.length-1) do |y|
        if player2_pos[y].to_i==@board[x].to_i
           @board[x]='O'
        end
      end
    end
    #puts "-------------"
    #puts "| #{@board[0]} | #{@board[1]} | #{@board[2]} |"
    #puts "----+---+----"
    #puts "| #{@board[3]} | #{@board[4]} | #{@board[5]} |"
    #puts "----+---+----"
    #puts "| #{@board[6]} | #{@board[7]} | #{@board[8]} |"
    #puts "-------------"
end





#
def legal_moves(player1_moves,player2_moves)
  current_player=[]
  other_player=[]
  @turns % 2 == 0 ? current_player =player1_moves : current_player = @player2_moves
  @turns % 2 == 0 ? other_player = @player2_moves : other_player = player1_moves
  @legality=1

 # while legality==1
     if current_player[-1].between?(1,9)==false
          @legality=1 
          puts "Outside of grid range"
     elsif other_player.any?{|value| value==current_player[-1]}
          @legality=1
          puts "Cannot enter the same position as opponent"
     elsif current_player.uniq! != nil
          @legality=1
          puts "Cannot enter the same location twice"
     else
          @legality=0
     end
       
     if @legality==1
         showBoard(@player_moves,@player2_moves)
         puts "Enter a legal position" 
         current_player << gets.to_i
     end    
  #end
  
end

def player1_select
  puts "Enter a position Player 1"
  @player_moves << gets.to_i
end

def computer_select(player2_moves,winpos,player_moves=nil,total_grid) 
  @total_grid-=@player2_moves
  @total_grid-=@player_moves
  thought_and_entry=0
  puts "The computer enters."
    0.upto(@winpos.length-1) do |x|
      in_a_row=0
      0.upto(@player_moves.length-1) do |z|
        0.upto(@winpos[x].length-1) do |y| 
          if @player_moves[z]==@winpos[x][y]
            in_a_row+=1
          end
          if in_a_row==2 && thought_and_entry==0
            thought_and_entry=1
            in_a_row=0
            @winpos[x]-=@player_moves
            @winpos[x]-=@player2_moves   
            if @winpos[x].join().to_i!=0 
              @player2_moves << (@winpos[x]-@player_moves).join().to_i  
              puts @player2_moves[-1]
              puts "computer successfully blocks at "+ @player2_moves[-1].to_s   
            else 
              thought_and_entry=0
            end
          end
        end
      end
    end

  
  
  if thought_and_entry==0 
   @player2_moves << @total_grid[1+(rand(@total_grid.length-1))]
   puts @player2_moves[-1]
  end
  @player2_moves
end
 
 def check_winning_condition(player_moves,player2_moves,winpos,total_grid,whowins)
  @turns % 2==0 ? player_wins = @player_moves : player_wins =@player2_moves
   0.upto(@winpos.length-1) do |x|
    in_a_row=0
    0.upto(player_wins.length-1) do |z|
      0.upto(@winpos[x].length-1) do |y|
         if player_wins[z]==@winpos[x][y]
           in_a_row+=1
         end
         if in_a_row==3
          @turns % 2 == 0 ? @whowins = "Player 1 as X WINS" : @whowins = "Player 2 as O WINS"
         end
       end
     end
   end 
    @total_grid-=@player_moves
    @total_grid-=@player2_moves
    @whowins = "Draw" if @total_grid.empty? 
    return @whowins
 end

def play_tic_tac_toe 
 while @whowins==nil 
   end_of_turn(@turns)
   showBoard(@player_moves,@player2_moves) 
   player1_select
   legal_moves(@player_moves,@player2_moves)
   check_winning_condition(@player_moves,@player2_moves,@winpos,@total_grid,@whowins)
   break if @whowins!=nil 
   end_of_turn(@turns)
   computer_select(@player2_moves,@winpos,@player_moves,@total_grid,@whowins)
   legal_moves(@player_moves,@player2_moves)
   check_winning_condition(@player_moves,@player2_moves,@winpos,@total_grid,@whowins)
   break if @whowins!=nil
 end
    showBoard(@player_moves,@player2_moves)
    puts @whowins
end
end
# t = TicTacToe.new
# t.play_tic_tac_toe
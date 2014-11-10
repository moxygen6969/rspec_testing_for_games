#!/usr/bin/env ruby
require 'rspec'
require_relative 'tic_tac_toe'

describe 'TicTacToe Class' do
 before  do
  @t=TicTacToe.new
 end
  
  describe '#new' do
   it 'should create a new instance of TicTacToe' do
     @t.should be_an_instance_of TicTacToe
   end
   
  describe '#end_of_turn' do
     it 'should return the value of 21 for the variable @turns' do
       @t.turns.should == 21
     end
     
     it 'should subtract the value of the variable turns by 1 ' do
       @t.end_of_turn(@t.turns)
       @t.turns.should == 20
     end
     
     it 'should display the proper turns when playing the game' do
       #player 1 gets five turns and player 2 gets 4 turns.
       @t.end_of_turn(@t.turns).should == "Turn 1" #player 1
       @t.end_of_turn(@t.turns).should == "Turn 2" #player 2
       @t.end_of_turn(@t.turns).should == "Turn 2" #player 1
       @t.end_of_turn(@t.turns).should == "Turn 3" #player 2
       @t.end_of_turn(@t.turns).should == "Turn 3" #player 1
       @t.end_of_turn(@t.turns).should == "Turn 4" #player 2
       @t.end_of_turn(@t.turns).should == "Turn 4" #player 1
       @t.end_of_turn(@t.turns).should == "Turn 5" #player 2
       @t.end_of_turn(@t.turns).should == "Turn 5" #player 1
     end
  
  describe '#showBoard' do   
     context 'when no arguments are passed to #showBoard' do
       it 'should display the numbers 1-9 indicating a position to be entered on an empty board' do
         @t.showBoard
         @t.board.should == ["1","2","3","4","5","6","7","8","9"]
       end
     end
     
     context "when only one arguement is passed to #showBoard's as it's  first parameter" do
         it 'should display an X for position 1 on the grid when player 1 selects 1' do
           @t.player_moves=[1]
           @t.showBoard(@t.player_moves)
           @t.board.should == ["X","2","3","4","5","6","7","8","9"]   
         end
     
         it 'should display an X for position 1 on the grid when player 1 selects 2' do
           @t.player_moves=[2]
           @t.showBoard(@t.player_moves)
           @t.board.should == ["1","X","3","4","5","6","7","8","9"]   
         end
     
         it 'should display an X for position 1 on the grid when player 1 selects 6' do
           @t.player_moves=[6]
           @t.showBoard(@t.player_moves)
           @t.board.should == ["1","2","3","4","5","X","7","8","9"]   
         end
         
         context "when only one arguement is passed to #showBoard's as it's second parameter" do
         it 'should display an O for position 1 on the grid when player 1 selects 1' do
           @t.player2_moves=[1]
           @t.showBoard(@t.player2_moves)
           @t.board.should == ["O","2","3","4","5","6","7","8","9"]   
         end
     
         it 'should display an O for position 1 on the grid when player 1 selects 2' do
           @t.player2_moves=[2]
           @t.showBoard(@t.player2_moves)
           @t.board.should == ["1","O","3","4","5","6","7","8","9"]   
         end
     
         it 'should display an O for position 1 on the grid when player 1 selects 6' do
           @t.player2_moves=[6]
           @t.showBoard(@t.player2_moves)
           @t.board.should == ["1","2","3","4","5","O","7","8","9"]   
         end
       end
         
         context 'when both arguments are given' do
           it "should display both player's inputs" do
             @t.player_moves = [1,2,4]
             @t.player2_moves = [5,3,7]
             @t.showBoard(@t.player_moves,@t.player2_moves)
             @t.board.should == ["X","X","O","X","O","6","O","8","9"]
           end
         end
     end
     
     describe '#legal_moves' do
      context 'when a player enters a number outside of the range 1-9' do 
       it "should set the value of legality to equal to 1 if player1's most recent move(0) is outside of 1-9 indicating an illegal move" do
         @t.turns = 20 #even turns indicate player 1's turn
         @t.player_moves = [0]
         @t.player2_moves = []
         @t.legal_moves(@t.player_moves,@t.player2_moves)
         @t.legality.should == 1
       end
       
       it "should set the value of legality to equal to 1 if player1's most recent move(10) is outside of 1-9 indicating an illegal move" do
         @t.turns = 20 #even turns indicate player 1's turn
         @t.player_moves = [10]
         @t.player2_moves = []
         @t.legal_moves(@t.player_moves,@t.player2_moves)
         @t.legality.should == 1
       end
       
       it "should set the value of legality to equal to 1 if player2's most recent move(10) is outside of 1-9 indicating an illegal move" do
         @t.turns = 19 #odd turns indicate player 2's turn
         @t.player_moves = []
         @t.player2_moves = [10]
         @t.legal_moves(@t.player_moves,@t.player2_moves)
         @t.legality.should == 1
       end
       
       it "should set the value of legality to equal to 1 if player2's most recent move(10) is outside of 1-9 indicating an illegal move" do
         @t.turns = 19 #odd turns indicate player 2's turn
         @t.player_moves = []
         @t.player2_moves = [0]
         @t.legal_moves(@t.player_moves,@t.player2_moves)
         @t.legality.should == 1
       end
      end
      
      context 'when a player enter the same position another player recently entered' do
       it "should set the value of legality to 1 if the player's most recent move is equal to one of the other player's moves indicating an illegal move" do
         @t.turns = 20 #even turns indicate player 1's turn
         @t.player_moves = [1,2,3]
         @t.player2_moves = [5,3]
         @t.legal_moves(@t.player_moves,@t.player2_moves)
         @t.legality.should == 1
       end
       
       it "should set the value of legality to 1 if the player2's most recent move is equal to one of the other player's moves indicating an illegal move" do
         @t.turns = 19 #odd turns indicate player 2's turn
         @t.player_moves = [1,2,4]
         @t.player2_moves = [5,3,4]
         @t.legal_moves(@t.player_moves,@t.player2_moves)
         @t.legality.should == 1
       end
      
      end
      
      it "should set the value of legality to 1 if the player1's most recent move is equal to moves previously entered" do
         @t.turns = 20 #even turns indicate player 1's turn
         @t.player_moves = [1,1]
         @t.player2_moves = [2]
         @t.legal_moves(@t.player_moves,@t.player2_moves)
         @t.legality.should == 1
       end
      
      it "should set the value of legality to 1 if the player2's most recent move is equal to moves previously entered" do
         @t.turns = 19 #odd turns indicate player 2's turn
         @t.player_moves = [1,3]
         @t.player2_moves = [2,2]
         @t.legal_moves(@t.player_moves,@t.player2_moves)
         @t.legality.should == 1
       end
      
     end
     
     context 'when both players have entered positions not previously entered that are in the range 1-9 and are not similar to each other, indicating a legal move' do
       it "should set the value of legality to 0 if player1's most recent move is not equal to any of the moves player2 has entered" do
        @t.turns = 20 #even turns indicate player1's move
        @t.player_moves = [1]
        @t.player2_moves = []
        @t.legal_moves(@t.player_moves, @t.player2_moves)
        @t.legality.should == 0
       end
       
       it "should set the value of legality to 0 if player1's most recent move is not equal to any of the moves player2 has entered" do
        @t.turns = 20 #even turns indicate player1's move
        @t.player_moves = [1,2]
        @t.player2_moves = [5]
        @t.legal_moves(@t.player_moves, @t.player2_moves)
        @t.legality.should == 0
       end
       
        it "should set the value of legality to 0 if player2's most recent move is not equal to any of the moves player1 has entered" do
          @t.turns = 19 #odd turns indicate player2's move
          @t.player_moves = [1,2]
          @t.player2_moves = [5,3]
          @t.legal_moves(@t.player_moves, @t.player2_moves)
          @t.legality.should == 0
       end
       
     end
     
     
  end
  
   describe '#computer_select' do
     context 'when player1 selects a position the computer should select any position that is not equal to any of the positions player 1 selects' do
       it "should enter a position not equal to any of player1's position if player 1 enters in a random position" do
         @t.player_moves = []
         @t.player2_moves = []
         @t.player_moves << (1+(rand(9)))
         @t.computer_select(@t.player2_moves,@t.winpos,@t.player_moves,@t.total_grid)
         @t.player2_moves[-1].should_not == @t.player_moves[-1]
         
       end
       
       it "should enter a position not equal to any of player1's position if player 1 enters in a random position" do
         @t.player_moves = [1]
         @t.player2_moves = []
         @t.computer_select(@t.player2_moves,@t.winpos,@t.player_moves,@t.total_grid)
         @t.player2_moves[-1].should_not == @t.player_moves[-1]
         
       end
       
       it "should enter a position not equal to any of player1's position if player 1 enters in a random position" do
         @t.player_moves = [1,2,7,9]
         @t.player2_moves = [5,3,8]
         @t.computer_select(@t.player2_moves,@t.winpos,@t.player_moves,@t.total_grid)
         @t.player2_moves[-1].should_not == @t.player_moves[-1]
       end
     
   end
   
      context 'when player 1 has entered in positions that are 1 position away from satisfying win conditions' do
        it 'should set the value of player2_moves[-1] to 3 indicating a block in order to make win conditions false' do
          @t.player_moves = [1,2]
          @t.player2_moves = [5]
          @t.computer_select(@t.player2_moves,@t.winpos,@t.player_moves,@t.total_grid)
          @t.player2_moves[-1].should == 3
        end
        
        it 'should set the value of player2_moves[-1] to 2 indicating a block in order to make win conditions false' do
          @t.player_moves = [1,3]
          @t.player2_moves = [5]
          @t.computer_select(@t.player2_moves,@t.winpos,@t.player_moves,@t.total_grid)
          @t.player2_moves[-1].should == 2
        end
        
        it 'should set the value of player2_moves[-1] to 4 indicating a block in order to make win conditions false' do
          @t.player_moves = [1,7]
          @t.player2_moves = [5]
          @t.computer_select(@t.player2_moves,@t.winpos,@t.player_moves,@t.total_grid)
          @t.player2_moves[-1].should == 4
        end
        
        it 'should set the value of player2_moves[-1] to 7 indicating a block in order to make win conditions false' do
          @t.player_moves = [1,4]
          @t.player2_moves = [5]
          @t.computer_select(@t.player2_moves,@t.winpos,@t.player_moves,@t.total_grid)
          @t.player2_moves[-1].should == 7
        end
      end
      
      describe '#check_winning_condition' do
        context 'when winning conditions for any player are satisfied' do
          it "should set the value of @whowins equal to 'Player 1 as X WINS' as a string if player 1's winning condition is met" do
           @t.turns = 20
           @t.player_moves = [1,2,3]
           @t.player2_moves = [4,5]
           @t.check_winning_condition(@t.player_moves,@t.player2_moves,@t.winpos,@t.total_grid,@t.whowins)
           @t.whowins.should == 'Player 1 as X WINS'
          end
          
          it "should set the value of @whowins equal to 'Player 1 as X WINS' as a string if player 1's winning condition is met" do
           @t.turns = 20
           @t.player_moves = [3,6,9]
           @t.player2_moves = [4,5]
           @t.check_winning_condition(@t.player_moves,@t.player2_moves,@t.winpos,@t.total_grid,@t.whowins)
           @t.whowins.should == 'Player 1 as X WINS'
          end
          
          it "should set the value of @whowins equal to 'Player 2 as O WINS' as a string if player 2's winning condition is met" do
           @t.turns = 19
           @t.player_moves = [1,2,7]
           @t.player2_moves = [4,5,6]
           @t.check_winning_condition(@t.player_moves,@t.player2_moves,@t.winpos,@t.total_grid,@t.whowins)
           @t.whowins.should == 'Player 2 as O WINS'
          end
          
          it "should set the value of @whowins equal to 'Player 2 as O WINS' as a string if player 2's winning condition is met" do
           @t.turns = 19
           @t.player_moves = [1,2,4]
           @t.player2_moves = [7,8,9]
           @t.check_winning_condition(@t.player_moves,@t.player2_moves,@t.winpos,@t.total_grid,@t.whowins)
           @t.whowins.should == 'Player 2 as O WINS'
          end
        end
      
        context 'when winning conditions are not satisfied' do
          it 'should set the value of @whowins equal to nil if a winning condition on both sides are not met the variable in_a_row would be less that 3' do
            @t.turns = 19
            @t.player_moves = [1,2]
            @t.player2_moves = [5,3]
            @t.check_winning_condition(@t.player_moves,@t.player_moves,@t.winpos,@t.total_grid,@t.whowins)
            @t.whowins.should == nil
          end
          
          it 'should set the value of @whowins equal to draw if a winning condition on both sides are not met and total_grid is empty' do
            @t.turns = 19
            @t.player_moves = [1,2,4,8,6]
            @t.player2_moves = [5,3,7,9]
            @t.check_winning_condition(@t.player_moves,@t.player_moves,@t.winpos,@t.total_grid,@t.whowins)
            @t.whowins.should == "Draw"
          end
        end
          
          
      end
     
   end
   
   end
   
   
   
   
  
  end
end

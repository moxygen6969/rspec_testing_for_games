#!/usr/bin/env ruby
require_relative 'ceasar_cipher'
require 'rspec'

describe '.encrypt' do
  context 'when passed the incorrect amount of parameters' do
    it 'should throw an error when given one parameter' do
      lambda {caesar_cipherOneWord("happy")}.should raise_exception ArgumentError
    end
  
    it 'should throw an error when given three parameters' do
      lambda {caesar_cipherOneWord("happy", 5, "joy Joy")}.should raise_exception ArgumentError
    end
  end
  
  context 'when the shifted position is inside of the 26 letter range' do
    it "should shift 'a' to the letter 'z' when the second parameter is 25" do
      encrypt("a",25).should == 'z'
    end
    
    it "should shift 'b' to the letter 'q' when the second parameter is 15" do
      encrypt("b",15).should =='q'
    end
  end
  
  context 'when the shifted position is outside of the 26 letter range' do
    it "should shift 'a' to the letter 'a' when the second parameter is 26" do
      encrypt("a",26).should == 'a'
    end
    
    it "should shift 'a' to the letter 'a' when the second parameter is 26" do
      encrypt("f",25).should == 'e'
    end
    
    it "should shift 'y' to the letter 'y' when the second parameter is 26" do
      encrypt("y",26).should == 'y'
    end
  end
  
  context 'when the shifted position is a negative value' do
    it "should shift the value 'z' to 'a' when the second parameter is -25" do
      encrypt('z',-25).should == 'a'
    end
    
    it "should shift the value 'a' to 'z' when the second parameter is -1" do
      encrypt('a',-1 ).should == 'z'
    end
    
    it "should shift the value 'y' to 'y' when the second parameter is -26" do
      encrypt('y',-26).should == 'y'
    end
    
    it "should shift the value 'a' to 'a' when the second parameter is -26" do
      encrypt('a',-26 ).should == 'a'
    end
    
    it "should shift the value 'z' to 'a' when the second parameter is -51" do
      encrypt('z',-51 ).should == 'a'
    end
    
    it "should shift the value 'a' to 'a' when the second parameter is -99" do
      encrypt('a',-78 ).should == 'a'
    end
  end
  
  context 'when one word is shifted' do
    it "should shift the word 'catharsis' to 'hfymfwxnx' when the second parameter is 5" do
      encrypt('catharsis',5).should == 'hfymfwxnx'
    end
    
    it "should shift the word 'catharsis' to 'catharsis' when the second parameter is -26" do
      encrypt('catharsis',-26).should == 'catharsis'
    end
    
    it "should shift the word 'catharsis' to 'catharsis' when the second parameter is 26" do
      encrypt('catharsis',26).should == 'catharsis'
    end
  end
  
  context 'when multiple words are shifted' do
    it "should shift the string 'what a string' to 'bmfy f xywnsl' when the second parameter is 5" do
      encrypt('what a string',5).should == 'bmfy f xywnsl'
    end
  end
  
  context 'when capital letters are included' do
    it "should shift the string 'What A String' to 'Bmfy F Xywnsl' when the second parameter is 5" do
      encrypt('What A String',5).should == 'Bmfy F Xywnsl'
    end
    
    it "should shift the name 'XXyyXX' to 'XXyyXX' when the second parameter is 26" do
      encrypt('XXyyXX',26).should == 'XXyyXX'
    end
  end
  
  context 'when non-letters are included' do
    it "should shift the string 'What a string!' to 'Bmfy f xywnsl!" do
      encrypt('What a string!',5).should == 'Bmfy f xywnsl!'
    end
    
    it "should shift the string 'You're Kevin's girlfriend.' to 'You're Kevin's girlfriend." do
      encrypt("You're Kevin's girlfriend.",26).should == "You're Kevin's girlfriend."
    end
  end
end


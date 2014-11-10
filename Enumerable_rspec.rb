#!/usr/bin/env ruby
require_relative 'Recreating the Ruby methods from Enumerable'
require 'rspec'

describe 'Module_enumerable' do
  
  before do
    @test_array = [1,2,3,4,5,6,7,8]
    @test_array2 = ['a','b','c','d']
  end
  
  describe 'my_eachs method' do
  context 'when the my_eachs method is passed an array and code a block as parameters' do
    it "should square each element in the array and push each element into another array" do
      new_array=[]
      Enumerable.my_eachs(@test_array) {|element| new_array << element**2}
      new_array.should == [1,4,9,16,25,36,49,64]
    end
  end
  
  context 'when the my_each method is not passed a code block as a parameter' do
    it "should return the array" do
      Enumerable.my_eachs(@test_array).should == [1,2,3,4,5,6,7,8]
    end
  end
end
  
  describe 'my_each_with_index' do
  context 'when the my_each_with_index method is passed an array and a code block as parameters' do
    it "should return the indexes in ascending numerical order" do
      new_array=[]
      new_array2=[]
      Enumerable.my_each_with_index(@test_array2) {|element, index| new_array << index}
      Enumerable.my_each_with_index(@test_array2) {|element, index| new_array2 << element}
      new_array.should == [0,1,2,3]
      new_array2.should == ['a','b','c','d']
    end
  end
  
  context ' when the my_each_with index method is not given a code but is passed an array as a parameter' do
    it "should return an array" do
      Enumerable.my_each_with_index(@test_array2).should == ['a','b','c','d']
     end
  end
end
  
  describe 'my_select method' do
  context 'when my_select is passed an array and a code block' do
    it 'should return an array of numbers that are divisible by 3' do
      Enumerable.my_select(@test_array){|element| element%3==0 }.should == [3,6]
    end
    
    it 'should return an array of numbers that are less than five' do
      Enumerable.my_select(@test_array){|element| element < 5}.should == [1,2,3,4]
    end
    
    it 'should return an array of numbers that are greater than five' do
      Enumerable.my_select(@test_array){|element| element > 5}.should == [6,7,8]
    end
    
    it 'should return an array of numbers that contain 1 and 8' do
      Enumerable.my_select(@test_array){|element| element == 1 || element == 8}.should == [1,8]
    end
  end
  
  describe 'my_all? method' do
    context 'when an array and a code block are passed as parameters' do
      it'should return true if the code block contains no false or nil values'do
        Enumerable.my_all?(@test_array) {|element| element > 0 }.should == true 
      end
      it 'should return false if the code block contains at least one false value' do
        Enumerable.my_all?(@test_array) {|element| element != 0 }.should == true 
      end
      it 'should return false if the code block contains at least one false value' do
        Enumerable.my_all?(@test_array) {|element| element < 0 }.should == false 
      end
      
      it 'should return false if the code block contains at least one false value' do
        Enumerable.my_all?(@test_array) {|element| element == 0 }.should == false 
      end
      
       it 'should return false if the code block contains at least one false value' do
        Enumerable.my_all?(@test_array) {|element| element == 0 }.should_not == true 
      end      
    end
    
    context 'when a code block is not given as a parameter' do
      it 'should return a true value if the array contains no nil or false values ' do
       new_array=["nil","void","nothingness","empty_space"," "]
       Enumerable.my_all?(new_array).should == true
      end
      
      it 'should return false if the array contains at least one nil or false value' do
       new_array=[nil,'a','b','c','d']
       Enumerable.my_all?(new_array).should == false
      end
    end
    
    describe 'my_any? method' do
      context 'when an array and a code block is given as parameters' do
        it 'should return a true value if the code block returns at least one true value' do
         Enumerable.my_any?(@test_array) {|element| element > 0}.should == true
        end
        
        it 'should return a true value if the code block returns at least one true value' do
         Enumerable.my_any?(@test_array) {|element| element != 0}.should == true
        end
        
        it 'should return a false value if the code block returns no true values' do
         Enumerable.my_any?(@test_array) {|element| element < 0}.should == false
        end
        
        it 'should return a false value if the code block returns no true values' do
         new_array =[nil,nil,false,nil]
         Enumerable.my_any?(new_array) {|element| element == 10}.should == false
        end
        
        
        context 'When a code block is not given as a parameter' do
          it 'should return a false value if the array contains no true values' do
            new_array =[nil,nil,false,nil]
            Enumerable.my_any?(new_array).should == false
          end
          
          it 'should return a true value if the array contains at least one true value' do
            new_array=["nil","void","nothingness","empty_space"," ",nil]
            Enumerable.my_any?(new_array).should==true
          end
        end
    end
    
    describe '.my_count method' do
      context 'when an array and a code block are passed as parameters' do
        it 'should return 4 when given the logic array element <  5' do     
          Enumerable.my_count(@test_array) {|element| element <5}.should==4
        end
         
        it 'should return 4 when given the logic array element > 4' do
          Enumerable.my_count(@test_array) {|element| element >4}.should==4
        end
        
        it 'should return 2 when given the logic array element ==1 || element ==6' do
          Enumerable.my_count(@test_array) {|element| element == 1 || element == 6}.should==2
        end
        
        it 'should return 3 when given the logic array element == 1 || element == 6 || element == 3' do
          Enumerable.my_count(@test_array) {|element| element == 1 || element == 6 || element == 3}.should==3
        end
        
        it 'should return 4 when given the logic array element % 2 equals 0' do
          Enumerable.my_count(@test_array) {|element| element % 2 == 0}.should==4
        end
        
        it 'should return 0 when given the logic array element equals true' do     
          new_array =[nil,nil,false,nil]
          Enumerable.my_count(new_array) {|element| element == true}.should==0
        end
        
        it 'should return 4 when given the logic array element equals any value except true' do     
          new_array =[nil,nil,false,nil]
          Enumerable.my_count(new_array) {|element| element != true}.should==4
        end
        
        it 'should return 4 when given the logic array element equals false' do     
          new_array =[nil,nil,false,nil]
          Enumerable.my_count(new_array) {|element| element == false}.should==1
        end
      end
      
      context 'when an array and an argument is given as parameters' do
        it 'should return 1 when the given argument is 2' do
           Enumerable.my_count(@test_array,2).should == 1
        end
        
         it 'should return 1 when the given argument is -12' do
           Enumerable.my_count(@test_array,-12).should == 0
        end
        
        it 'should return 5 when the given argument 4' do
          new_array=[1,2,3,4,5,6,7,8,9,0,1,2,3,4,1,2,3,4,4,4]
          Enumerable.my_count(new_array,4).should == 5
        end
      end
      
       context 'when no code block or argument is given' do
        it 'should count the array length of @test_array and return 8' do
          Enumerable.my_count(@test_array).should == 8
        end
        
        it 'should count the array length of the new_array and return 4' do
          new_array =[nil,nil,false,nil]
          Enumerable.my_count(new_array).should == 4
        end

      end
    end
    
    
    
    
    
    end
    
  end
  
  
end
  
  
end
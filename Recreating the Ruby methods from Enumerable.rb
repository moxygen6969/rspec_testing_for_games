#!/usr/bin/env ruby
#recreating the each method from scratch




module Enumerable
  def self.my_eachs(an_array)
   return an_array unless block_given?
    for i in an_array
      yield(i)
    end
 


#Enumerable.my_eachs(array1) {|num| print "#{num**2} "}


 



  def self.my_each_with_index(an_array)
   x=0
   return an_array unless block_given?
    for i in an_array
      yield(i,x)
      x+=1
    end
  end


#Enumerable.my_each_with_index(('A'..'Z')) do |num, x| 
#    print "#{num} " if x%2==0
#end


  def self.my_select(an_array,&code_block)
      new_array=[]
   return an_array unless block_given?
    for i in an_array
if code_block.call(i)==true
    new_array << i
end
    end
    return new_array
  end


#Enumerable.my_select(array1){|num| num%3==0}





  def self.my_all?(an_array,&code_block)
      new_array=[]
      falz=0
              if block_given?
                  for i in an_array do
                      if code_block.call(i)==true
                        new_array << i
                        elsif code_block.call(i)==false
                        falz+=1
                      end
                  end
              end
              
     0.upto(an_array.length-1) do|x|
          if an_array[x]==false || an_array[x]==nil
               falz+=1
          end
      end
      
       if falz<1
             return  true
         else
             return  false
       end
  end


#Enumerable.my_all?(test_array)




  def self.my_any?(an_array,&code_block)
      new_array=[]
      truez=[]
    if block_given?
       for i in an_array do
          if code_block.call(i)==false
                new_array << i
             elsif code_block.call(i)
                truez<< true
          end
       end
        
    end
    
    if !block_given?
      0.upto(an_array.length-1) do |x|
          if an_array[x]
              truez << true
          end
      end
    end
    
       0.upto(truez.length-1) do |x|
         if truez[x]== true
          return true
         end
       end
       return false
  end


#Enumerable.my_any?(test_array)




  def self.my_count(an_array, arg=nil, &code_block)
      truez=0
      counter=0
      arg_counter=0
    
     
       if block_given? && arg == nil
                  for i in an_array do
                      if code_block.call(i)==true
                        truez+=1
                      end
                  end
       end
        
     
    if !block_given? 
      0.upto(an_array.length-1) do |x|
          if an_array[x]==arg && arg!=nil
              arg_counter+=1
          end
          counter+=1
      end
    end
      return arg_counter  if arg!=nil && !block_given?
      return truez        if arg==nil &&  block_given?
      return counter      if arg==nil && !block_given?
  end

#ary=[1,2,4,2]
#Enumerable.my_count(ary,2)





  def self.my_inject(an_array,arg=nil,&code_block)
      x=an_array[0]
      acc=0
      memo=nil
      oper=0
      if arg==nil
          memo=0
      else
          memo=arg
      end 
      return "no block given" unless block_given? 
       for i in an_array do 
           puts "#{i},#{x}"
           x=x**i     
             if code_block.call(acc,i)==acc*i && arg!=nil
                 acc=1
                 memo*=code_block.call(acc,i)
                 oper==2
          elsif code_block.call(acc,i)==acc+i 
                 memo+=code_block.call(acc,i)
                 oper=0
          elsif code_block.call(acc,i)==acc-i 
                 memo+=code_block.call(acc,i)
                 oper=1
          elsif code_block.call(acc,i)==acc/i && arg!=nil
                 memo=0
          elsif code_block.call(acc,i)==acc**i 
                 memo=an_array[0] if arg==nil
                 acc=arg if arg!=nil
                 acc=an_array[0] if arg==nil
                 memo*=code_block.call(acc,i)
                 oper=4     
             end
       end
       return memo*arg if oper==2
       return memo+arg if oper==0
       return memo-arg if oper==1
       return memo if oper==4  
  end 
end
end

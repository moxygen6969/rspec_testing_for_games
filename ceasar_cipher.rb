#!/usr/bin/env ruby
def caesar_cipherOneWord(word,shift)
alphabetarray = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
x=0
position=""
arrsize=alphabetarray.length-1
       while x<word.length
            0.upto(arrsize) do |y|
                #finding the uppercase character in the array Sliding off of the array gives the next array value a nil
                 if alphabetarray[y].upcase==word[x]
    #If I slide off of the array reset it by modulo
                     if alphabetarray[y+shift]==nil
                         position+=alphabetarray[(y+shift)%26].upcase
                     else    
                     position+=alphabetarray[y+shift].upcase
                     end
            #finding the lowercase character in the array
                 elsif alphabetarray[y]==word[x]
    #If I slide off of the array reset it by modulo. Sliding off of the array gives the next array value a nil
                    if alphabetarray[y+shift]==nil
                      position+=alphabetarray[(y+shift)%26]
                     else    
                     position+=alphabetarray[y+shift]
                    end             
                 end
                 
            end
            position+=word[x] if !alphabetarray.include?("#{word[x].downcase}") && !alphabetarray.include?("#{word[x].upcase}") 
            x+=1
       end
  #checks the array of words to see if there are any non letter characters if there are append it to the position 
       return position
end




def encrypt(sentence,shiftfactor)
  result = []
  #sentence.split turns it into an array of words. which I can then use the .each loop method. I will function call(method call caesar_cipherOneWord on each word)
  # and append the returned value into the empy array result.
  sentence.split(' ').each { |w| result << caesar_cipherOneWord(w,shiftfactor) }
  result.join(" ")
end

#encrypt("a",25)

end_of_program=gets.chomp
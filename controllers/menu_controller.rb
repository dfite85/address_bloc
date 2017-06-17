
require_relative '../models/address_book'

class MenuController
    attr_reader :address_book
    
    def initialize 
        @address_book = AddressBook.new
    end
    
    def main_menu
        
        puts "Main Menu - #{address_book.entries.count} entries"
        puts "1 - View all entires"
        puts "2 - Create an entry"
        puts "3 - Search for an entry"
        puts "4 - Import entires from a CSV"
        puts "5 - View Entry n"                                                 #selector for assingment 5 
        puts "6 - Delete all entries"
        puts "7 - Exit"
        print "Enter your selection: "
        
        selection = gets.to_i                                                   #converts selection to intiger
        
        case selection                                                          #sets selection cast to specific when inputs 
        when 1
            system "clear"
            view_all_entries
            main_menu
        when 2
            system "clear"
            create_entry
            main_menu
        when 3
            system "clear"
            search_entries
            main_menu
        when 4 
            system "clear"
            read_csv
            main_menu
            
        when 5
            system "clear"                                                      #clears system
            entry_n_submenu                                                     #opens entry_n_submenu
            main_menu                                                           #returns to main menu
        when 6
            system "clear"
            @address_book.demolish
            puts "All ya shit gone now"
            main_menu
        when 7
            puts "Good-bye"
            
            exit
            
        else                                                                    #when an entry is invalid
            system "clear"
            puts "Sorry, that is not a valid input"                             #naw dawg
            main_menu                                                           #returns to main menu
        end
    end
    
    def entry_n_submenu                                                         #when entry_n_submenu is called from case/when statements above
        print "Entry number to view: "                                          #prints this sting for user to see
        selection = gets.chomp.to_i                                             #gets and chomps user selection and converts to intiger
        
        if selection < @address_book.entries.count                              #if selection is less than entry count
            puts @address_book.entries[selection]                               #puts user selection
            puts "Press enter to return to the main menu"                       #then gives user a way back to main menu
            gets.chomp                                                          #get chomp uses enter
            system "clear"                                                      #clears system
        else
            puts "#{selection} is not valid input"                              #invalid input
            entry_n_submenu                                                     #gives user a second chance
        end
    end
    
#So the only issue I have with this code is that putting the selection in and array offsets the number that the selection can be therefore being confusing when calling the entry    
    
    #stub outs



def create_array
end

    def search_entries
        print "Search by name: "
        name = gets.chomp
        
        match = address_book.binary_search(name)
        system "clear"
        
        if match
            puts match.to_s
            search_submenu(match)
        else
            puts "No match found for #{name}"
        end
    end

    def delete_entry(entry)                                                     #method delete entry
        address_book.entries.delete(entry)                                      #looks at address book for the entry then removes it
        puts "#{entry.name} had been deleted"                                   #then prints out 
    end
    
    def edit_entry(entry)                                                       #method to edit old entries
        print "Updated name: "                                                  #asks user for a name
        name = gets.chomp                                                       #gets name and sets it eql to var name
        print "Updated phone number: "                                          
        phone_number = gets.chomp
        print "Updated email: "
        email = gets.chomp
        
        entry.name = name if !name.empty?                                       #uses !attribute.empty? to check for a valid entry then stores it to entry.var
        entry.phone_number = phone_number if !phone_number.empty?
        entry.email = email if !email.empty?
        system "clear"
        
        puts "Updated entry: "
        puts entry                                                              #displays the modified entry
    end
    

    def read_csv
    
        print "Enter CSV file to import: "                                      #prompt for user
        file_name = gets.chomp                                                  #stores user entry to file_name
    
        if file_name.empty?                                                     #if file name is empty 
        system "clear"                                                          #clear sys
        puts "No CSV file read"                                                 #show this message
        main_menu                                                               #return to main menu
        end
    
    begin
        entry_count = address_book.import_from_csv(file_name).count             #imports a specified file and saves to var entry count
        system "clear"
        puts "#{entry_count} new entries added from #{file_name}"
    rescue
        puts"#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
        read_csv
    end
    end 

    def create_entry
    
        system "clear"
        puts "New AddressBloc Entry"
    
        print "Name: "
        name = gets.chomp
        print "Phone Number: "
        phone = gets.chomp
        print "Email: "
        email = gets.chomp
    
        address_book.add_entry(name, phone, email)
    
        system "clear"
        puts "New entry created"
    end

    def view_all_entries                                      #method to display all entries
        
        address_book.entries.each do |entry|                  #iterates thru all entries in address book
            system "clear"                                    #clears the screen
            puts entry.to_s                                   #displays the entry as a sting
        
            entry_submenu(entry)                              #call submenu to display a submenu for each entry
        end                                                   #what do you want to do with the entry
                                                            
        system "clear"                                        #clears the screen
        puts "End of entries"                                     
    end
    
 
    def entry_submenu(entry)                                  #method for a submenu in address book
        
        puts "n - next entry"                                 #commands for the entry submenu
        puts "d - delete entry"
        puts "e - edit this entry"
        puts "m - retrun to the main menu"
        
        selection = gets.chomp                                #recives user selection with gets to add to the string and chomp to strip your text of any whitespace
        
        case selection                                        #basically means selection === whatever when the user inputs
        
        when "n"                                              #when one of these is selected it prints a puts from above selection
        when "d"
            delete_entry(entry)
        when "e"
            edit_entry(entry)
            edit_submenu(entry)
        when "m"
            system "clear"                                    #clears the screen
            main_menu                                         #returns main menu
        else                                                  #if condition is not met    
            system "clear"                                    #clears the screen and says
            puts "#{selection} is not a valid input"          #you fucked up dog
            entry_submenu(entry)                              #returns the submenu so you can try again
        end
    end
    
    def search_submenu(entry)
        puts "\nd - delete entry"
        puts "e - edit this entry"
        puts " m - return to main menu"
        
        selection = gets.chomp
        
        case selection 
        when "d"
            system "clear"
            delete_entry(entry)
            main_menu
            
        when "e"
            edit_entry(entry)
            system "clear"
            main_menu
            
        when "m"
            system "clear"
            main_menu
            
        else 
            system "clear"
            puts "#{selection} is not a valid input"
            puts entry.to_s
            search_submenu(entry)
        end
    end
end
    

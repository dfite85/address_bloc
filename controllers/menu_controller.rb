
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
        puts "5 - Exit"
        print "Enter your selection: "
        
        selection = gets.to_i
        
        case selection 
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
            puts "Good-bye"
            
            exit
            
        else
            system "clear"
            puts "Sorry, that is not a valid input"
            main_menu
        end
    end

def view_all_entries
end

def create_array
end

def search_entries
end

def read_csv
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
                                                            
    system "clear"                                            #clears the screen
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
        when "e"
        when "m"
            system "clear"                                    #clears the screen
            main_menu                                         #returns main menu
        else                                                  #if condition is not met    
            system "clear"                                    #clears the screen and says
            puts "#{selection} is not a valid input"          #you fucked up dog
            entry_submenu(entry)                              #returns the submenu so you can try again
        end
    end
            
end
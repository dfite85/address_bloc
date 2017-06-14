require_relative 'entry'
require "csv"

class AddressBook
    attr_reader :entries
    
    def initialize 
        @entries = []
    end
    
    def remove_entry(name, phone_number, email)
       delete_entry = nil 
       
       @entries.each do |entry|
           if name == entry.name && phone_number == entry.phone_number && email == entry.email
               delete_entry = entry
           end
        end
       
       @entries.delete(delete_entry)
    end
    

    
    def add_entry(name, phone_number, email)
        
        index = 0
        @entries.each do |entry|
            
        if name < entry.name
            break
        end
        index+=1
    end
    
    entries.insert(index, Entry.new(name, phone_number, email))
    end
    
    def import_from_csv(file_name)
        
        csv_text = File.read(file_name)                                              #method starts by reading the file with file.read
        csv = CSV.parse(csv_text, headers: true, skip_blanks: true)                  #use CSV class to parse the file, the result is this is an object of type csv::table
                                                                                             
        csv.each do |row|                                                            #iterate over the tables object rows 
            row_hash = row.to_hash                                                   #creates a hash for each row
            add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"]) #converts each row_hash to an entry using add_entry 
        end
    end
end



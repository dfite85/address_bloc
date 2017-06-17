require_relative 'entry'
require "csv"

class AddressBook
    attr_reader :entries
    
    def initialize 
        @entries = []
    end
    
    def demolish
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
    
    
    def iterative_search(name)
        @entries.each do |entry|
            if entry.name == name
                return entry
            end
        end
        return nil
    end

    
    # Search AddressBook for a specific entry by name
    def binary_search(name)                                                     #stub for binary_search
    
        lower = 0                                                               #save index of leftmost item in array to var named lower
        upper = entries.length - 1                                              #save index of rightmost item in array to var upper
    
        while lower <= upper                                                    #while lower is less than or equal to upper preform task below
    
            mid = (lower + upper) / 2                                           #find middle index by taking sum of upper & lower devided by 2
            mid_name = entries[mid].name                                        #retrives the name of middle index and stores it to var mid_name
    
        if name == mid_name                                                     #compares the name of middle index to the name we are searching for
            return entries[mid]                                                 #if == retruns var mid_name which is mid at this point
                                                                                #impliment ends
        elsif name < mid_name                                                   #else not the name, if name is alpahbetically before mid_name and we continure to search the bottom half of the array
            upper = mid - 1                                                     #new upper is set to mid -1 since name will be before mid
        
        elsif name > mid_name                                                   #if name is alphabetically after mid_name we set lower to mid + 1 to search the top half of the array
            lower = mid + 1
        end                                                                     #loop iteration ends sucessfully returning name or
        end
    return nil                                                                  #if still no match return nil
    end
end
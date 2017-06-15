require_relative '../models/address_book'

RSpec.describe AddressBook do
    
    let(:book) {AddressBook.new}                                                #new instance and assigned to var book
                                                                                #let is a rspec helper method that allows us to remove dup code when test have a common used value
    
    def check_entry(entry, expected_name, expected_number, expected_email)      #helper method used to consildate redundant code
        expect(entry.name).to eq expected_name
        expect(entry.phone_number).to eq expected_number
        expect(entry.email).to eq expected_email
    end
    
    describe "attributes" do
        it "resoponds to entries" do
            #book = AddressBook.new                                             lets allows ust to use book in each it test removeing duplication
            expect(book).to respond_to(:entries)
        end
        
        it "initializes entries as an array" do
        
            expect(book.entries).to be_an(Array) 
        end
        
        it "initializes entries as empty" do
            
            expect(book.entries.size).to eq(0)
        end
        
    end
    
    describe "#add_entry" do
        it "adds only one entry to the address book" do
            
            book.add_entry('Ada LoveLace', '010.012.1815', 'augusta.king@lovelace.com')
            
            expect(book.entries.size).to eq(1)
        end
        
        it "adds the correct information to entries" do
            
            book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
            new_entry = book.entries[0]
            
            expect(new_entry.name).to eq('Ada Lovelace')
            expect(new_entry.phone_number).to eq('010.012.1815')
            expect(new_entry.email).to eq('augusta.king@lovelace.com')
        end
    end
    
    describe "#remove_entry" do
        it "removes an entry using the name, phone_number and email address" do
            
            book.add_entry('Dustin Fite', '504.939.1365', 'dfite85@gmail.com')
            
            name = 'Ada Lovelace'
            phone_number = '010.012.1815'
            email_address = 'augusta.king@lovelace.com'
            book.add_entry(name, phone_number, email_address)
            
            
            expect(book.entries.size).to eq 2 
            book.remove_entry(name, phone_number, email_address)
            expect(book.entries.size).to eq 1
            
            expect(book.entries.first.name).to eq('Dustin Fite')
            
        end
    end
    
    #Test that AddressBooks .import_from_csv() method is working as expected
    describe "#import_from_csv" do
        it "imports the correct number of entires" do
        
            book.import_from_csv("entries.csv")                                 #pass import with entries as a parm 
            book_size = book.entries.size                                       #ref to get its size in form of array then saves size to local book_size
        
            expect(book_size).to eq 5                                           #gives expectation                                            
        end
        
        it "imports the 1st entry" do
            book.import_from_csv("entries.csv")
            entry_one = book.entries[0]
            
            #expect(entry_one.name).to eq "Bill"                                redundant code made obsolete with def check_entry
            #expect(entry_one.phone_number).to eq "555-555-4854"
            #expect(entry_one.email).to eq "bill@blocmail.com"
            check_entry(entry_one, "Bill", "555-555-4854", "bill@blocmail.com") #def check_entry uses this code to fill entry
        end
        
        it"imports the 2nd entry" do
            book.import_from_csv("entries.csv")
            entry_two = book.entries[1]
            
            check_entry(entry_two, "Bob", "555-555-5415", "bob@blocmail.com")
        end
        
        it "imports the 3rd entry" do
            book.import_from_csv("entries.csv")
            entry_three = book.entries[2]
            

            check_entry(entry_three, "Joe", "555-555-3660", "joe@blocmail.com")
        end
        
        it "imports the 4th entry" do
            book.import_from_csv("entries.csv")
            entry_four = book.entries[3]
            

            check_entry(entry_four, "Sally", "555-555-4646", "sally@blocmail.com")
        end
        
        it" imports the 5th entry" do
            book.import_from_csv("entries.csv")
            entry_five = book.entries[4]
            

            check_entry(entry_five, "Sussie", "555-555-2036", "sussie@blocmail.com")
        end
    end
    
    describe "#Import_from_csv_2" do
        it "imports the correct number of entires" do
        
            book.import_from_csv("entries_2.csv")                               
            expect(book.entries.size).to eq 3                                                                                      
        end
        
        it "imports the 1st entry" do
            book.import_from_csv("entries_2.csv")
            entry_one = book.entries[0]
            

            check_entry(entry_one, "Bill", "555-555-4854", "bill@blocmail.com") 
        end
        
        it"imports the 2nd entry" do
            book.import_from_csv("entries_2.csv")
            entry_two = book.entries[1]
            
            check_entry(entry_two, "Bob", "555-555-5415", "bob@blocmail.com")
        end
        
        it "imports the 3rd entry" do
            book.import_from_csv("entries_2.csv")
            entry_three = book.entries[2]
            

            check_entry(entry_three, "Joe", "555-555-3660", "joe@blocmail.com")
        end
    
    end
    
    describe "#iterative_search" do                                             #test iterative search
        it "searches AddressBook for a non-existent entry" do                   
            book.import_from_csv("entries.csv")                                 #imports entries from csv
            entry = book.iterative_search("Dan")                                #sets search equal to entry
            expect(entry).to be_nil                                             #expects entry to be nil
        end
        
        it"searches AddressBook for Bill" do                                    #Looking for Bill
            book.import_from_csv("entries.csv")                                 #imports entries from csv file
            entry = book.iterative_search("Bill")                               #sets search to var entry
            expect(entry).to be_a Entry                                         #expects entry to be an object entry
            check_entry(entry, "Bill", "555-555-4854", "bill@blocmail.com")     #checks it against control
        end
        
        it "searches AddressBook for Bob" do                                    #repeated for all entries
            book.import_from_csv("entries.csv")
            entry = book.iterative_search("Bob")
            expect(entry).to be_a Entry
            check_entry(entry, "Bob", "555-555-5415", "bob@blocmail.com")
        end
        
        it "searches AddressBook for Joe" do
            book.import_from_csv("entries.csv")
            entry = book.iterative_search("Joe")
            expect(entry).to be_a Entry
            check_entry(entry, "Joe", "555-555-3660", "joe@blocmail.com")
        end
        
          it "searches AddressBook for Sally" do
            book.import_from_csv("entries.csv")
            entry = book.iterative_search("Sally")
            expect(entry).to be_a Entry
            check_entry(entry, "Sally", "555-555-4646", "sally@blocmail.com")
        end
        
          it "searches AddressBook for Sussie" do
            book.import_from_csv("entries.csv")
            entry = book.iterative_search("Sussie")
            expect(entry).to be_a Entry
            check_entry(entry, "Sussie", "555-555-2036", "sussie@blocmail.com")
        end
        
          it "searches AddressBook for Billy" do                                #a test thats looks for something that we know exists but isnt exactly the same
            book.import_from_csv("entries.csv")
            entry = book.iterative_search("Billy")
            expect(entry).to be_nil
        end
    end
    
    describe "#binary_search" do                                                #test binary search
        it "searches AddressBook for a non-existent entry" do                   
            book.import_from_csv("entries.csv")                                 #imports entries from csv
            entry = book.binary_search("Dan")                                   #sets search equal to entry
            expect(entry).to be_nil                                             #expects entry to be nil
        end
        
        it"searches AddressBook for Bill" do                                    #Looking for Bill
            book.import_from_csv("entries.csv")                                 #imports entries from csv file
            entry = book.binary_search("Bill")                                  #sets search to var entry
            expect(entry).to be_a Entry                                         #expects entry to be an object entry
            check_entry(entry, "Bill", "555-555-4854", "bill@blocmail.com")     #checks it against control
        end
        
        it "searches AddressBook for Bob" do                                    #repeated for all entries
            book.import_from_csv("entries.csv")
            entry = book.binary_search("Bob")
            expect(entry).to be_a Entry
            check_entry(entry, "Bob", "555-555-5415", "bob@blocmail.com")
        end
        
        it "searches AddressBook for Joe" do
            book.import_from_csv("entries.csv")
            entry = book.binary_search("Joe")
            expect(entry).to be_a Entry
            check_entry(entry, "Joe", "555-555-3660", "joe@blocmail.com")
        end
        
          it "searches AddressBook for Sally" do
            book.import_from_csv("entries.csv")
            entry = book.binary_search("Sally")
            expect(entry).to be_a Entry
            check_entry(entry, "Sally", "555-555-4646", "sally@blocmail.com")
        end
        
          it "searches AddressBook for Sussie" do
            book.import_from_csv("entries.csv")
            entry = book.binary_search("Sussie")
            expect(entry).to be_a Entry
            check_entry(entry, "Sussie", "555-555-2036", "sussie@blocmail.com")
        end
        
          it "searches AddressBook for Billy" do                                #a test thats looks for something that we know exists but isnt exactly the same
            book.import_from_csv("entries.csv")
            entry = book.binary_search("Billy")
            expect(entry).to be_nil
        end
        
    end
end
    
    


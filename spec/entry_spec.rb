require_relative '../models/entry'

Rspec.describe Entry do

context  "attributes" do
    
    it "responds to name" do
        entry = Entry.new
        expect(entry).to respond_to(:name)
    end
    
    it "responds to phone number" do
        entry = Entry.new
        expect(entry).to respond_to(:phone_number)
    end
    
    it "responds to email" do 
        entry = Entry.new
        expect(entry).to respond_to (:email)
    end
end
end


puts "find recently created people"

require 'nationbuilder'

client = NationBuilder::Client.new('harrysandboxdev', ENV['HARRY_SANDBOX'], retries: 8)

puts "find recently created people"

#sets the tag you want to pull out
create_recently_tag = {
  tag: "harrytest123"
  }
  
#pulls people from nationbuilder
create_recently_1 = client.call(:people_tags, :people, create_recently_tag)
create_recently_2 = NationBuilder::Paginator.new(client, create_recently_1)

#stores results
create_recently_3 = []
  create_recently_3 += create_recently_2.body['results']
while create_recently_2.next?
  create_recently_2 = create_recently_2.next
  create_recently_3 += create_recently_2.body['results']
end  

#gets email and id from the list of people to then add membersip
create_recently_3.each do |create_recently_4|
  
 
  
  email = create_recently_4['email']
  id = create_recently_4['id']
  tags = create_recently_4['tags'] 
  puts "#{email} id #{id} #{tags}" 
  
petition_count=tags.count{ |element| element.match('19 petition') }
email_count=tags.count{ |element| element.match('19 email') }

total_actions=petition_count+email_count
  
  puts "#{email} petitions: #{petition_count} emails: #{email_count} total_actions: #{total_actions}" 
  
  
  
    add_tag = {
 id: "#{id}",
  tagging: {
    tag: "PETITIONS SIGNED:  #{petition_count}"
  }
  
}

end  
  


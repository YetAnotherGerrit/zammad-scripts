# List all groups and the total count of tickets in them

# USE AT YOUR OWN RISK! NOT COVERED BY ZAMMAD SUPPORT!
# This script is originally from GitHub>YetAnotherGerrit>zammad-scripts
# Written for Zammad version 6.2

puts "Group name                  | Active |  Count | Closed | Merged |"
puts "----------------------------+--------+--------+--------+--------+"
Group.all.each do |g|
    puts "#{g.name.ljust(27)} | #{g.active.to_s.ljust(6)} | #{Ticket.where(group_id: g.id).count.to_s.rjust(6)} | #{Ticket.where(group_id: g.id, state_id: Ticket::State.find_by(name: 'closed')).count.to_s.rjust(6)} | #{Ticket.where(group_id: g.id, state_id: Ticket::State.find_by(name: 'merged')).count.to_s.rjust(6)} |"
end
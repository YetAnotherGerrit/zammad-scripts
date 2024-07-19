# List all groups and the total count of tickets in them

# USE AT YOUR OWN RISK! NOT COVERED BY ZAMMAD SUPPORT!
# This script is originally from GitHub>YetAnotherGerrit>zammad-scripts
# Written for Zammad version 6.3.1

COLUMN_WITH = [30, 6, 6, 6, 6]

def spacer_line
    puts "+#{"".ljust(COLUMN_WITH[0]+2, "-")}+#{"".ljust(COLUMN_WITH[1]+2, "-")}+#{"".ljust(COLUMN_WITH[2]+2, "-")}+#{"".ljust(COLUMN_WITH[3]+2, "-")}+#{"".ljust(COLUMN_WITH[4]+2, "-")}+"
end

# HEADER
spacer_line
puts "| #{"Group".ljust(COLUMN_WITH[0])} | #{"Active".ljust(COLUMN_WITH[1])} | #{"Count".rjust(COLUMN_WITH[2])} | #{"Closed".rjust(COLUMN_WITH[3])} | #{"Merged".rjust(COLUMN_WITH[4])} |"
spacer_line

# LIST OF GROUPS
Group.all.each do |g|
    print "| #{g.name.ljust(COLUMN_WITH[0])} | "
    print "#{g.active.to_s.ljust(COLUMN_WITH[1])} | "
    print "#{Ticket.where(group_id: g.id).count.to_s.rjust(COLUMN_WITH[2])} | "
    print "#{Ticket.where(group_id: g.id, state_id: Ticket::State.find_by(name: 'closed')).count.to_s.rjust(COLUMN_WITH[3])} | "
    puts  "#{Ticket.where(group_id: g.id, state_id: Ticket::State.find_by(name: 'merged')).count.to_s.rjust(COLUMN_WITH[4])} |"
end

# FOOTER
spacer_line
print "| #{"Total".ljust(COLUMN_WITH[0])} | "
print "#{"".ljust(COLUMN_WITH[1])} | "
print "#{Ticket.all.count.to_s.rjust(COLUMN_WITH[2])} | "
print "#{Ticket.where(state_id: Ticket::State.find_by(name: 'closed')).count.to_s.rjust(COLUMN_WITH[3])} | "
puts  "#{Ticket.where(state_id: Ticket::State.find_by(name: 'merged')).count.to_s.rjust(COLUMN_WITH[4])} |"
spacer_line

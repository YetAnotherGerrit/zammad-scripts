# Assign organizations to existing users using "domain based assignment"

# USE AT YOUR OWN RISK! NOT COVERED BY ZAMMAD SUPPORT!
# This script is originally from GitHub>YetAnotherGerrit>zammad-scripts
# Written for Zammad version 6.2

Organization.where(domain_assignment: true).each do |org|
	next if org.domain == nil
	User.where(organization_id: nil).where("email LIKE ?", "%@#{org.domain}").each do |u|
		puts "Organization '#{org.name}' will be assigned to User '#{u.fullname}':"
		u.update!(organization: org, updated_by_id: 1)
		puts ">> User updated."
	end
end

# Assign existing users to organizations using "domain based assignment"

Organization.where(domain_assignment: true).each do |org|
	next if org.domain == nil
	User.where(organization_id: nil).where("email LIKE '%@#{org.domain}'").each do |u|
		puts "Organization '#{org.name}' will be assigned to User '#{u.fullname}':"
		u.update!(organization: org, updated_by_id: 1)
		puts ">> User updated."
	end
end

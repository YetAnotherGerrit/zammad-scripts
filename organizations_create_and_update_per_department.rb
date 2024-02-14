# Create and assign Organizations based on User.department-attribute

User.where.not(department: "").each do |u|
    next if u.department == u.organization.name
    puts "Found User '#{u.fullname}' with department '#{u.department}' and Organization '#{u.organization.name}'. Going to update:"

    org = Organization.find_by(name: u.department)
    if org == nil
        puts ">> Organization '#{u.department}' not found. Going to create it:"
        org = Organization.create(name: u.department, created_by_id: 1, updated_by_id: 1)
    end
    u.update!(organization: org)
    puts ">> User updated."
end
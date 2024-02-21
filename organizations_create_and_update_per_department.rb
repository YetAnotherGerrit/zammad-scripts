# Create and assign Organizations based on User.department-attribute

# USE AT YOUR OWN RISK! NOT COVERED BY ZAMMAD SUPPORT!
# This script is originally from GitHub>YetAnotherGerrit>zammad-scripts
# Written for Zammad version 6.2

User.where.not(department: "").each do |u|
    next if u.department == u.organization.name
    puts "Found User '#{u.fullname}' with department '#{u.department}' and Organization '#{u.organization.name}'. Going to update:"

    org = Organization.find_by(name: u.department)
    if org == nil
        puts ">> Organization '#{u.department}' not found. Going to create it:"
        org = Organization.create(name: u.department, shared: false, created_by_id: 1, updated_by_id: 1)
    end
    u.update!(organization: org, updated_by_id: 1)
    puts ">> User updated."
end
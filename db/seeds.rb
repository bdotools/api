ActiveRecord::Base.connection.tables.reject { |x| x == "schema_migrations" }.each do |table|
  ActiveRecord::Base.connection.execute("TRUNCATE #{table} RESTART IDENTITY CASCADE")
end

Importer::Import.new(path: "db/latest.7z").call

# Make Amity targets available.
Target.joins(:category).where.not(categories: { id: nil }).update_all(workflow_state: :available)

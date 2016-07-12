ActiveRecord::Base.connection.tables.reject { |x| x == "schema_migrations" }.each do |table|
  ActiveRecord::Base.connection.execute("TRUNCATE #{table} RESTART IDENTITY CASCADE")
end
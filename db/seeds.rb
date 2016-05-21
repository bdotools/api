CONSTELLATIONS = [
  {
    name: "Goblin",
    slots: 6,
    slot_order: [0, 1, 2, 3, 4, 5]
  },
  {
    name: "Camel",
    slots: 4,
    slot_order: [0, 1, 2, 3, 0, 2]
  },
  {
    name: "Charioteer",
    slots: 5,
    slot_order: [0, 1, 2, 3, 4]
  },
  {
    name: "Hammer",
    slots: 6,
    slot_order: [0, 1, 2, 3, 4, 5]
  },
  {
    name: "Treant Owl",
    slots: 4,
    slot_order: [0, 1, 2, 3, 1, 2]
  },
  {
    name: "Key",
    slots: 4,
    slot_order: [0, 1, 2, 3, 2, 1]
  },
  {
    name: "Giant",
    slots: 8,
    slot_order: [0, 1, 2, 3, 4, 5, 6, 7]
  },
  {
    name: "Elephant",
    slots: 5,
    slot_order: [0, 1, 2, 3, 4]
  },
  {
    name: "Black Dragon",
    slots: 7,
    slot_order: [0, 1, 2, 3, 4, 5, 6]
  },
  {
    name: "Boat",
    slots: 4,
    slot_order: [0, 1, 2, 0, 2, 3]
  },
  {
    name: "Sealing Stone",
    slots: 5,
    slot_order: [0, 1, 2, 3, 4]
  },
  {
    name: "Shield",
    slots: 6,
    slot_order: [0, 1, 2, 3, 4, 5]
  },
  {
    name: "Goblin (Mevo Muranan)",
    slots: 6,
    slot_order: [3, 1, 2, 4, 5, 0]
  }
]

def constellations
  CONSTELLATIONS
end

ActiveRecord::Base.connection.tables.reject { |x| x == "schema_migrations" }.each do |table|
  ActiveRecord::Base.connection.execute("TRUNCATE #{table} RESTART IDENTITY CASCADE")
end

constellations.each { |x| Constellation.create(x) }

data = File.read("db/data.json")
Importer.new(data).call
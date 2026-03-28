extends Node;

export(String) String database_location = "user://database.sqlite";

void _ready() {
	Directory d = Directory.new();
	String bd = database_location.get_base_dir();
	String loc = d.get_filesystem_abspath_for(bd).append_path(database_location.get_file());
	
	File file = File.new();
	if !file.file_exists(loc) {
		PLogger.log_message("Database file doesn't exists, will run full migrations!");
		call_deferred("migrate", true);
	} else {
		PLogger.log_message("Database file exists, will run normal / update migrations!");
		call_deferred("migrate", false);
	}
	
	SQLite3Database db = SQLite3Database.new();
	db.connection_string = loc;
	DatabaseManager.add_database(db);
}

void migrate(bool full) {
	DatabaseManager.connect("migration", this, "_migration");
	
	if full {
		PLogger.log_message("Running full migrations!");
		DatabaseManager.migrate(true, false, 0);
		DatabaseManager.call_deferred("initialized");
	} else {
		PLogger.log_message("Running update migrations!");
		DatabaseManager.migrate(false, false, 0);
		db_initialized();
	}
}

void db_initialized() {
	DatabaseManager.initialized();
}

void _migration(bool clear, bool should_seed, int pseed) {
	#create admin account
}

extends Node

export(String) var database_location : String = "user://database.sqlite"

func _ready() -> void:
	print("This demo has to be run twice!")
	print("On the first run it will setup an out of date database structure and then quit.")
	print("This simulates what happens when tha database structure changes during development.")
	print("On the second run it will udpate it to how it should be.")
	print("To reset after the second run, in the editor go Project->Open User Data Folder, and then delete database.sqlite in that folder.")
	print("")
	print("Note that in web backend frameworks it is standard practice to run all")
	print("migrations one by one, even on newly created tables.")
	print("Based on previous experience I recommend not doing this,")
	print("it seems to be better to always create the proper up to date table structure")
	print("if the table doesn't exists, and provide update paths if it's just older.")
	print("")
	
	DatabaseManager.connect("initialized", self, "on_databases_initialized", [], CONNECT_ONESHOT)
	
	var d : Directory = Directory.new()
	var bd : String = database_location.get_base_dir()
	var loc : String = d.get_filesystem_abspath_for(bd).append_path(database_location.get_file())
	
	PLogger.log_message("Database file location: " + loc)
	PLogger.log_message("(Editor->Project->Open User Data Folder)")
	
	var file : File = File.new()
	if !file.file_exists(loc):
		PLogger.log_message("Database file doesn't exists, will run full migrations!")
		PLogger.log_message("(Editor->Project->Open User Data Folder)")
		call_deferred("migrate", true)
	else:
		PLogger.log_message("Database file exists, will run normal / update migrations!")
		call_deferred("migrate", false)

	var db : SQLite3Database = SQLite3Database.new()
	db.connection_string = loc
	DatabaseManager.add_database(db)

func migrate(full : bool) -> void:
	DatabaseManager.connect("migration", self, "_migration")
	
	if full:
		PLogger.log_message("Running full migrations!")
		DatabaseManager.migrate(true, false, 0)
		DatabaseManager.call_deferred("initialized")
	else:
		PLogger.log_message("Running update migrations!")
		DatabaseManager.migrate(false, false, 0)
		DatabaseManager.initialized()

func on_databases_initialized() -> void:
	# Load sessions after the databases are initialized
	# This happens on the Main node.
	# it needs data_double column, which is only present in table version 1
	call_deferred("load_data")

func _migration(clear: bool, should_seed: bool, pseed: int) -> void:
	if !clear:
		# See whether our table structure is okay
		
		var table_version : int = DatabaseManager.ddb.get_connection().get_table_version("data_table")
		
		PLogger.log_message("Table version is: %d" % table_version)
		
		if table_version <= 0:
			# Update our database table structure, because it is outdated
			PLogger.log_message("Updating table to version 1")
			
			var tb : TableBuilder = DatabaseManager.ddb.get_connection().get_table_builder();

			tb.alter_table("data_table")
			tb.add_column()
			tb.real_double("data_double").not_null()
			tb.end_command()

			tb.run_query()
			
			# Now fill data_double values
			var ids : PoolIntArray = PoolIntArray()
			
			var qb : QueryBuilder = DatabaseManager.ddb.get_connection().get_query_builder()
			
			qb.select("id")
			qb.from("data_table")
			qb.end_command()
			var qr : QueryResult = qb.run()
			
			while qr.next_row():
				ids.push_back(qr.get_next_cell_int())
			
			for id in ids:
				qb.reset()
				
				# should be batched
				qb.update("data_table");
				qb.sets();
				qb.setpd("data_double", randf() * 100000);
				qb.cset();
				qb.where().wpi("id", id);
				qb.end_command()

				qb.run_query();
		
		#if table_version <= 1:
		#	...
		
		#if table_version <= 2:
		#	...
		
		DatabaseManager.ddb.get_connection().set_table_version("data_table", 1)
			
		return
	
	randomize()
	
	# By default you should always create the latest table structure
	
	var tb : TableBuilder = DatabaseManager.ddb.get_connection().get_table_builder()
	
	tb.create_table("data_table");
	tb.integer("id").auto_increment().next_row();
	tb.varchar("data_varchar", 60).not_null().next_row();
	tb.text("data_text").not_null().next_row();
	tb.integer("data_int").not_null().next_row();

	tb.primary_key("id");
	tb.ccreate_table();
	tb.run_query();
	
	#print("Running:")
	#print(tb.result)
	
	var qb : QueryBuilder = DatabaseManager.ddb.get_connection().get_query_builder()
	
	for i in range(10):
		qb.reset()
		
		qb.insert("data_table", "data_varchar,data_text,data_int").values()
		qb.vals("vc" + str(randi()))
		qb.vals("text" + str(randi()))
		qb.vali(randi())
		qb.cvalues()
		qb.end_command()
		
		qb.run_query()
		
		#print("Running:")
		#print(qb.result)
	
	# You would set this to the current maximum (it starts at 0, so we won't set it)
	#DatabaseManager.ddb.get_connection().set_table_version("data_table", 0)
	
	PLogger.log_message("Initial (old) database setup complete. Quitting. Run the app again.")
	get_tree().quit()
	

func load_data() -> void:
	print("Querying data from table:")
	
	var qb : QueryBuilder = DatabaseManager.ddb.get_connection().get_query_builder()
	
	var qr : QueryResult = qb.select("id,data_varchar,data_text,data_int,data_double").from("data_table").run()
	
	while qr.next_row():
		print("ROW:")
		print("id: " + str(qr.get_cell_int(0)))
		print("data_varchar: " + str(qr.get_cell(1)))
		print("data_text: " + str(qr.get_cell(2)))
		print("data_int: " + str(qr.get_cell_int(3)))
		print("data_double: " + str(qr.get_cell_double(4)))

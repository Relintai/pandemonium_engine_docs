extends HTTPSessionManagerDB;

void _ready() {
	DatabaseManager.connect("initialized", this, "on_databases_initialized", [], CONNECT_ONESHOT);
	// You could also connect to the migration signal, and write migrations if you need them
}

void on_databases_initialized() {
	// Load sessions after the databases are initialized
	// This happens on the Main node.
	call_deferred("load_sessions");
}

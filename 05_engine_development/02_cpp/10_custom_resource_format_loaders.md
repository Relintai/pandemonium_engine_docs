
# Custom resource format loaders

## Introduction

ResourceFormatLoader is a factory interface for loading file assets.
Resources are primary containers. When load is called on the same file
path again, the previous loaded Resource will be referenced. Naturally,
loaded resources must be stateless.

This guide assumes the reader knows how to create C++ modules and Pandemonium
data types.

### References

- `ResourceLoader`
- [core/io/resource_loader.cpp](https://github.com/Relintai/pandemonium_engine/blob/master/core/io/resource_loader.cpp)

## What for?

- Adding new support for many file formats
- Audio formats
- Video formats
- Machine learning models

## What not?

- Raster images

ImageFormatLoader should be used to load images.

### References

- [core/io/image_loader.h](https://github.com/Relintai/pandemonium_engine/blob/master/core/io/image_loader.h)

## Creating a ResourceFormatLoader

Each file format consist of a data container and a `ResourceFormatLoader`.

ResourceFormatLoaders are usually simple classes which return all the
necessary metadata for supporting new extensions in Pandemonium. The
class must return the format name and the extension string.

In addition, ResourceFormatLoaders must convert file paths into
resources with the `load` function. To load a resource, `load` must
read and handle data serialization.


```
/* resource_loader_json.h */

#ifndef RESOURCE_LOADER_JSON_H
#define RESOURCE_LOADER_JSON_H

#include "core/io/resource_loader.h"

class ResourceFormatLoaderJson : public ResourceFormatLoader {
	GDCLASS(ResourceFormatLoaderJson, ResourceFormatLoader);
public:
	virtual RES load(const String &p_path, const String &p_original_path, Error *r_error = NULL);
	virtual void get_recognized_extensions(List<String> *r_extensions) const;
	virtual bool handles_type(const String &p_type) const;
	virtual String get_resource_type(const String &p_path) const;
};
#endif // RESOURCE_LOADER_JSON_H
```

```
/* resource_loader_json.cpp */

#include "resource_loader_json.h"

#include "resource_json.h"

RES ResourceFormatLoaderJson::load(const String &p_path, const String &p_original_path, Error *r_error) {
Ref<JsonResource> json = memnew(JsonResource);
	if (r_error) {
		*r_error = OK;
	}
	Error err = json->load_file(p_path);
	return json;
}

void ResourceFormatLoaderJson::get_recognized_extensions(List<String> *r_extensions) const {
	if (!r_extensions->find("json")) {
		r_extensions->push_back("json");
	}
}

String ResourceFormatLoaderJson::get_resource_type(const String &p_path) const {
	return "Resource";
}

bool ResourceFormatLoaderJson::handles_type(const String &p_type) const {
	return ClassDB::is_parent_class(p_type, "Resource");
}
```

## Creating a ResourceFormatSaver

If you'd like to be able to edit and save a resource, you can implement a
`ResourceFormatSaver`:

```
/* resource_saver_json.h */

#ifndef RESOURCE_SAVER_JSON_H
#define RESOURCE_SAVER_JSON_H

#include "core/io/resource_saver.h"

class ResourceFormatSaverJson : public ResourceFormatSaver {
	GDCLASS(ResourceFormatSaverJson, ResourceFormatSaver);
public:
	virtual Error save(const String &p_path, const RES &p_resource, uint32_t p_flags = 0);
	virtual bool recognize(const RES &p_resource) const;
	virtual void get_recognized_extensions(const RES &p_resource, List<String> *r_extensions) const;
};
#endif // RESOURCE_SAVER_JSON_H
```

```
/* resource_saver_json.cpp */

#include "resource_saver_json.h"

#include "resource_json.h"
#include "scene/resources/resource_format_text.h"

Error ResourceFormatSaverJson::save(const String &p_path, const RES &p_resource, uint32_t p_flags) {
	Ref<JsonResource> json = memnew(JsonResource);
	Error error = json->save_file(p_path, p_resource);
	return error;
}

bool ResourceFormatSaverJson::recognize(const RES &p_resource) const {
	return Object::cast_to<JsonResource>(*p_resource) != NULL;
}

void ResourceFormatSaverJson::get_recognized_extensions(const RES &p_resource, List<String> *r_extensions) const {
	if (Object::cast_to<JsonResource>(*p_resource)) {
		r_extensions->push_back("json");
	}
}
```

## Creating custom data types

Pandemonium may not have a proper substitute within its core types
or managed resources. Pandemonium needs a new registered data type to
understand additional binary formats such as machine learning models.

Here is an example of creating a custom datatype:

```
/* resource_json.h */

#ifndef RESOURCE_JSON_H
#define RESOURCE_JSON_H

#include "core/io/json.h"
#include "core/variant_parser.h"

class JsonResource : public Resource {
	GDCLASS(JsonResource, Resource);

protected:
	static void _bind_methods() {
		ClassDB::bind_method(D_METHOD("set_dict", "dict"), &JsonResource::set_dict);
		ClassDB::bind_method(D_METHOD("get_dict"), &JsonResource::get_dict);

		ADD_PROPERTY(PropertyInfo(Variant::DICTIONARY, "content"), "set_dict", "get_dict");
	}

private:
	Dictionary content;

public:
	Error load_file(const String &p_path);
	Error save_file(const String &p_path, const RES &p_resource);

	void set_dict(const Dictionary &p_dict);
	Dictionary get_dict();
};
#endif // RESOURCE_JSON_H
```

```
/* resource_json.cpp */

#include "resource_json.h"

Error JsonResource::load_file(const String &p_path) {
	Error error;
	FileAccess *file = FileAccess::open(p_path, FileAccess::READ, &error);
	if (error != OK) {
		if (file) {
			file->close();
		}
		return error;
	}

	String json_string = String("");
	while (!file->eof_reached()) {
		json_string += file->get_line();
	}
	file->close();

	String error_string;
	int error_line;
	JSON json;
	Variant result;
	error = json.parse(json_string, result, error_string, error_line);
	if (error != OK) {
		file->close();
		return error;
	}

	content = Dictionary(result);
	return OK;
}

Error JsonResource::save_file(const String &p_path, const RES &p_resource) {
	Error error;
	FileAccess *file = FileAccess::open(p_path, FileAccess::WRITE, &error);
	if (error != OK) {
		if (file) {
			file->close();
		}
		return error;
	}

	Ref<JsonResource> json_ref = p_resource.get_ref_ptr();
	JSON json;

	file->store_string(json.print(json_ref->get_dict(), "    "));
	file->close();
	return OK;
}

void JsonResource::set_dict(const Dictionary &p_dict) {
	content = p_dict;
}

Dictionary JsonResource::get_dict() {
	return content;
}
```

### Considerations

Some libraries may not define certain common routines such as IO handling.
Therefore, Pandemonium call translations are required.

For example, here is the code for translating `FileAccess`
calls into `std::istream`.

```
#include "core/os/file_access.h"

#include <istream>
#include <streambuf>

class PandemoniumFileInStreamBuf : public std::streambuf {

public:
	PandemoniumFileInStreamBuf(FileAccess *fa) {
		_file = fa;
	}
	int underflow() {
		if (_file->eof_reached()) {
			return EOF;
		} else {
			size_t pos = _file->get_position();
			uint8_t ret = _file->get_8();
			_file->seek(pos); // Required since get_8() advances the read head.
			return ret;
		}
	}
	int uflow() {
		return _file->eof_reached() ? EOF : _file->get_8();
	}

private:
	FileAccess *_file;
};
```

### References

- [istream](http://www.cplusplus.com/reference/istream/istream/)
- [streambuf](http://www.cplusplus.com/reference/streambuf/streambuf/?kw=streambuf)
- [core/io/fileaccess.h](https://github.com/Relintai/pandemonium_engine/blob/master/core/os/file_access.h)

## Registering the new file format

Pandemonium registers `ResourcesFormatLoader` with a `ResourceLoader`
handler. The handler selects the proper loader automatically
when `load` is called.

```
/* register_types.h */

void register_json_types();
void unregister_json_types();
```

```
/* register_types.cpp */

#include "register_types.h"

#include "core/class_db.h"
#include "resource_loader_json.h"
#include "resource_saver_json.h"
#include "resource_json.h"

static Ref<ResourceFormatLoaderJson> json_loader;
static Ref<ResourceFormatSaverJson> json_saver;

void register_json_types() {
	ClassDB::register_class<JsonResource>();

	json_loader.instance();
	ResourceLoader::add_resource_format_loader(json_loader);

	json_saver.instance();
	ResourceSaver::add_resource_format_saver(json_saver);
}

void unregister_json_types() {
	ResourceLoader::remove_resource_format_loader(json_loader);
	json_loader.unref();

	ResourceSaver::remove_resource_format_saver(json_saver);
	json_saver.unref();
}
```

### References

- [core/io/resource_loader.cpp](https://github.com/Relintai/pandemonium_engine/blob/master/core/io/resource_loader.cpp)

## Loading it on GDScript

Save a file called `demo.json` with the following contents and place it in the
project's root folder:

```
{
  "savefilename": "demo.json",
  "demo": [
    "welcome",
    "to",
    "pandemonium",
    "resource",
    "loaders"
  ]
}
```

Then attach the following script to any node::

```
extends Node

onready var json_resource = load("res://demo.json")

func _ready():
    print(json_resource.get_dict())
```


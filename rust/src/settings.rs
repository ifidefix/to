extern crate serde;
extern crate serde_json;

use std::fs::File;
use std::io::prelude::*;
use std::io::Error;
use std::convert::Into;
use std::path::Path;

include!(concat!(env!("OUT_DIR"), "/serde_types.rs"));

impl Settings {
    pub fn new() -> Settings {
        Settings {
            directories: Vec::new(),
			version: String::from("rust")
        }
    }

    pub fn save(&self, path: &Path) -> Result<(), Error> {
        let file = File::create(path);
        match file {
            Ok(mut file) => {
                let buffer: String = self.into();
                file.write_all(buffer.as_bytes()).unwrap();
                Ok(())
            },
            Err(e) => Err(e)
        }
    }

    pub fn from_file(file: File) -> Result<Settings, serde_json::Error>{
        serde_json::from_reader(file)
    }
}

impl Default for Settings {
    fn default() -> Settings {
        Settings::new()
    }
}

// Automatically convert a Settings object into pretty JSON
impl<'a> Into<String> for &'a Settings {
    fn into(self) -> String {
        serde_json::to_string_pretty(self).unwrap()
    }
}
